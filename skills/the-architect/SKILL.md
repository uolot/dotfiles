---
name: the-architect
description: "Plans complex features through deep codebase exploration, producing a detailed implementation plan with atomic commits before any code is written. Use when the user wants to plan a feature, design a refactor, architect a change, or create an implementation roadmap. Triggers on: plan, architect, design, implementation plan, roadmap, break down, spec out, plan a feature, think through."
user_invocable: true
arguments: $FEATURE — short description of the feature or change to plan
---

# The Architect

Plan first, build later. This skill produces a complete, atomic implementation plan. Implementation is handled separately (typically in a dedicated implementation session/agent).

The workflow has five stages. **Do not skip stages or combine them.**

**Hard gate:** Never move from one stage to the next without explicit user confirmation for that transition. Silence, implied approval, or "looks good" directed at a different artifact is not approval.

**Intent lock:** Capture user choices in explicit plan artifacts (Intent Snapshot + Decision Ledger) early. Treat them as source of truth for later stages.

**Clarification policy:** Ask questions only when blocked. Batch 1-3 high-impact questions, each with a recommended default and one line on what changes if another option is chosen.

**Plan integrity:** Before every stage transition, verify plan internals are consistent: status, progress tracker, commit count, dependency order, and implemented-vs-planned sections must agree.

---

## Stage 1: Scope & Discovery

**Goal:** Build a complete mental model of the relevant codebase before writing a single line of plan.

1. Ask the user to describe the feature or change in their own words. Clarify ambiguities only where they materially affect behavior, data contracts, rollout strategy, or risk.
2. Explore the codebase aggressively. Use Task agents for broad searches. Read every file that touches the affected area. Map out:
   - **Data flow**: Where does the relevant data originate, transform, and render?
   - **Entry points**: Which pages, endpoints, or components will be affected?
   - **Existing patterns**: How does the codebase already solve similar problems? Follow those patterns — don't invent new ones.
   - **Types and schemas**: What types, validation schemas, and DB columns are involved?
   - **Tests**: What test coverage exists for the affected code?
3. Report discoveries to the user as you go — share what you're finding and confirm your understanding. This is a conversation, not a monologue.
4. **Do not write any code or plan document during this stage.** The only output is shared understanding.
5. **Stop and wait for explicit user confirmation before starting Stage 2.**

## Stage 2: Outline

**Goal:** Produce a minimal initial plan that captures the high-level shape of the work, locks user intent, then hand it to the user for review and comments.

After discovery is complete, write a short outline as a markdown file in the repo's planning docs location (prefer `docs/plans/` when present) with six sections:

```markdown
# Starred Tasks Filter

> **Status:** Outline
> **Created:** 2026-03-27

## Intent Snapshot

2-5 bullets. Capture the user's intent as explicit constraints.

- Must keep existing filter UX patterns
- Must avoid N+1 queries on list pages
- Must support rollout compatibility with old URL params

## Decision Ledger

Record decisions already made. Each entry: decision, choice, why, impacted areas.

- Filter persistence: reset on page nav — matches current behavior and avoids hidden sticky state (affects URL + UI)

## Description

2-5 bullet points. What the feature does, how the user interacts with it, how it composes with existing features. Keep it behavioral — what changes from the user's perspective.

- A checkbox in the filter popover lets the user see only starred tasks
- Composable with the existing area filter — both can be active at once
- Active filters shown as pills below the popover trigger

## Data Flow Changes

Bullet points describing which data paths are affected and how.

- `getTasksForPage()` currently returns `{ tasks, grouping, filter }` — needs to return `filters` (plural) instead
- URL param `filter-by` → split into `area` and `starred` params
- `filterTasks()` needs to accept and compose multiple filter predicates

## Implementation Plan

Numbered bullet points — one per logical chunk of work. NOT atomic commits yet — just the broad strokes in order.

1. Rename `filter-by` param to `area` throughout
2. Extract starred filter predicate
3. Create unified filter popover component
4. Wire up all pages

## Open Questions

Unresolved decisions, ambiguities, or trade-offs that need user input before the detailed plan can be written.

- Should the starred filter persist across page navigation or reset?
- Do we want a "clear all filters" button?
```

**After writing the outline:**

1. Present it to the user.
2. **Stop and wait for explicit user confirmation.** The user will read, edit the file directly, and add their comments or corrections. Do not proceed to Stage 3 until the user clearly confirms the outline is approved.
3. Address any user comments — update the outline or ask follow-up questions as needed.
4. If asking questions, use a strict format:
   - options (A/B or numbered)
   - recommended option
   - one-line tradeoff
   - one-line impact of choosing a different option
   Then immediately record the outcome in the Decision Ledger.

## Stage 3: Expand the Plan

**Goal:** Flesh out the outline into a proper plan — detailed enough to guide implementation, but not yet broken into atomic commits.

Update the outline file in place. Change the status to "Draft".

1. Expand the Description into a **Behavior** section: what the user sees, how it works end-to-end, how it composes with existing features.
2. Add an **Out of Scope** section: what this plan explicitly does NOT do, and why.
3. Add a **Contract Lock** section that freezes canonical terminology and contracts:
   - canonical domain terms (for example, `subtasks` vs `subtask`)
   - critical type/ID contracts (for example, `id: number` vs `id: string`)
   - endpoint/resource contracts (paths + payload shapes)
   - synthetic/persisted interoperability rules (ID type alignment, discriminator strategy, collision handling)
4. Add/refresh a **Decision Ledger** section. Every non-trivial choice must include chosen option, reason, and impacted sections.
5. If rollout is involved, split behavior explicitly into:
   - **Rollout Behavior (current)**
   - **Post-rollout Cleanup (later)**
   Keep cleanup work out of rollout commits unless explicitly requested.
6. Expand each Implementation Plan bullet into a **detailed step** with:
    - A brief description of the change
    - **Why / What / How** bullets — these guide the code monkey during implementation:
      - **Why**: Purpose of this step — what problem it solves or what it enables
      - **What**: Observable change — what's different after this step
      - **How**: Approach — which pattern to follow, which existing code to reference
   - Which files and functions are affected (by name, not line number)
   - What types, props, or signatures change
   - Which existing patterns to follow and where to find them in the codebase
   - Any new files or components to create
7. **Assess test coverage.** For each implementation step, check whether the code being changed already has tests. If it doesn't, propose adding tests to the user. Be specific about:
    - What type of tests (unit, integration, etc.)
    - What behaviors and edge cases they should cover
    - Where the test file should live (following project conventions)
    - Do NOT include test implementation details yet — just the scope and intent
8. **Identify project quality gates.** Determine which validation commands are standard for this repo (tests, linters, formatters, type checks, build/check commands). Record the exact commands in the plan so implementation can run them before every commit.
9. Resolve the Open Questions from Stage 2 (using the user's comments) and remove answered ones. Add any new questions that surfaced during expansion.
10. Call out **risks** or areas where the plan may need adjustment during implementation.
11. Add a **Storage Semantics Check** section when relevant (DB defaults vs domain meaning):
    - `null` vs `""` vs `[]` handling
    - read-time normalization rules
    - write-time clearing semantics
    - where each rule is enforced (DB, schema, service, UI)
12. Run a **Consistency Pass** before presenting:
    - no contradictory values across sections (types, defaults, constants, endpoint shapes)
    - terminology is consistent across behavior, steps, commits, and handoff
    - Decision Ledger entries are reflected in all impacted sections
13. Run a **Plan Integrity Check** (status/progress/dependencies/implemented-vs-planned alignment).
14. Present the expanded plan to the user. Iterate until they're satisfied. Expect 1-3 revision rounds.
15. **Stop and wait for explicit user confirmation before starting Stage 4.**

### Plan document format (Stage 3)

```markdown
# Starred Tasks Filter

> **Status:** Draft
> **Created:** 2026-03-27

## Behavior

A filter popover in the task list header with two independent controls:
an area dropdown (personal/work) and a starred checkbox. Both compose —
selecting "work" + "starred" shows only starred work tasks. Active filters
appear as dismissible pills. Filters are URL-param based and cause a page
reload.

## Out of Scope

- Client-side instant filtering (future enhancement)
- Saving filter presets

## Implementation Plan

### 1. Rename area filter infrastructure

Rename `Filter` type to `AreaFilter`, `FILTER_CHOICES` to `AREA_FILTER_CHOICES`,
`getFilterForPage` to `getAreaFilter`. Update all consumers in services, components,
and pages. Follow the existing naming pattern in `src/data/types.ts`.

- **Why:** Frees up the generic `Filter` name for the new composite filter system and makes the area filter's scope explicit
- **What:** Pure rename — no behavior change, all existing tests should pass as-is
- **How:** Find-and-replace across the codebase; follow the naming convention already used in `src/data/types.ts`

### 2. Add starred filter predicate

Create `isStarred` filter function in `src/data/filters.ts` following the same
shape as `filterByArea`. Add a `PageFilters` type that bundles both area and starred
filters. Update `getTasksForPage()` to return `PageFilters` instead of a single filter.

- **Why:** Introduces the starred filter as a composable predicate alongside the existing area filter
- **What:** New `isStarred` function, new `PageFilters` type, updated return type for `getTasksForPage()`
- **How:** Mirror the shape of `filterByArea` exactly — same parameter style, same return type, same naming convention

**Tests:** No existing tests for filter functions. Propose adding unit tests in
`src/data/filters.test.ts` covering: `isStarred` with starred/unstarred tasks,
`getFiltersForPage` URL param parsing (both params, one, neither, invalid values),
`filterTasks` composing area + starred filters together.

### 3. Build unified filter popover

Replace `FilterBySelect.svelte` with a new `FilterPopover.svelte` that contains
both the area dropdown and a starred checkbox. Use the existing `SmallPill.svelte`
for active filter indicators. Follow the popover pattern already used in the codebase.

- **Why:** Single entry point for all task filters, replacing the area-only select
- **What:** New `FilterPopover.svelte` component; `FilterBySelect.svelte` deleted
- **How:** Follow the popover pattern from `[example].svelte` in the codebase; reuse `SmallPill.svelte` for active filter pills

### 4. Wire up pages and layout

Update `TasksLayout.astro` prop from `filter` to `filters`. Mechanical rename across
all 20 Astro pages that destructure from `getTasksForPage()`.

- **Why:** Connects the new filter system to every page that displays tasks
- **What:** Prop rename in layout + destructuring update in all 20 page files
- **How:** Purely mechanical — find all pages that call `getTasksForPage()`, update the destructured variable name from `filter` to `filters`

## Risks

- 20 pages need a mechanical rename — easy to miss one

## Open Questions

Anything still unresolved.
```

## Stage 4: Commit Breakdown

**Goal:** Break the approved plan into atomic commits with exact file paths, line numbers, and code changes.

Update the plan file in place. Change the status to "Ready" once approved.

1. Break each implementation step from Stage 3 into one or more **atomic commits** — each one leaves the app in a fully working state (checks pass, tests pass, no broken UI).
2. Order commits to minimize risk: mechanical renames and type changes first, then logic changes, then UI, then cleanup.
3. **Tests go with the code they cover, not at the end.** When a commit introduces new logic or changes behavior, include the corresponding tests in that same commit. A commit that adds `isStarred()` should also add the unit tests for `isStarred()`. Only split tests into a separate commit when adding coverage for pre-existing untested code.
4. **Run quality gates before every commit.** Do not commit until repo-appropriate checks succeed for that step (at minimum relevant tests + lint/format/type/build checks used by this project). If a check fails, fix the issue before committing.
5. For each commit, specify:
    - **Commit message** (conventional commits format)
    - **Implementation guidance** with **Why / What / How**
    - **Validation commands** to run before committing (exact commands for that commit)
    - **Files changed** with exact paths
    - **What changes** in each file (line-level references and before/after snippets for non-trivial changes)
6. Add a **Commit Notes Protocol** section in the plan file:
    - before each commit, append/update `Commit N notes`
    - record deviations from plan and why they were necessary
    - before planning the next commit, review prior notes and update downstream commit scopes if needed
7. Add an **Execution Protocol** block with concrete run-order requirements:
    - announce `Scope` and `Details` before each commit implementation
    - run quality gates and confirm pass status before proposing commit summary
    - update current `Commit N notes` before running `git commit`
    - include plan-file note updates in the same commit as related code changes
8. Define a **Plan Extension** rule for unplanned commits:
    - mark as `Plan Extension`
    - explain trigger and why it was not in original commit breakdown
    - document dependency impact and whether behavior is user-facing
9. Define a **No-op Deviation** rule when a planned file/step needs no changes:
    - record explicitly in `Commit N notes`
    - explain why no change was needed
    - note any downstream impact
10. Run a **Plan Integrity Check** after commit breakdown edits.
11. Present the breakdown to the user. Iterate until they're satisfied.
12. **Stop and wait for explicit user confirmation before starting Stage 5.** Do NOT proceed to Stage 5 until the user explicitly confirms the commit breakdown is approved. Setting status to "Ready" means the plan is ready for the user to review — it is not permission to implement.

## Stage 5: Handoff

**Goal:** Produce a structured context summary so a fresh implementation session can execute the plan without losing any knowledge.

Once the plan is finalized (user explicitly confirms transition to Stage 5, status set to "Ready"):

1. Write a **context summary** as a message to the user, structured as:
    - **Goal**: one-sentence description
    - **Frozen decisions**: non-negotiable choices from the Decision Ledger
    - **Contract lock**: canonical terminology, type/ID contracts, endpoint contracts
    - **Known deviations**: approved deviations and why
    - **Discoveries**: key codebase facts from exploration
    - **Accomplished**: what this session produced
    - **Relevant files/directories**: grouped by role (plan, data, services, components, pages, tests, config)
2. Run a final **Consistency Pass** before sending the summary.
3. Run a final **Plan Integrity Check** before sending the summary.
4. This summary is for pasting into a fresh implementation session. It must be **self-contained**: summary + plan file should be enough to execute without re-exploration.

**The architect's job ends here.** Implementation is handled in a separate execution session.

---

## Resuming a Session

When a conversation resumes and prior context indicates this skill is in progress:

1. Identify which stage we're at based on the plan file status and conversation history.
2. **Summarize the current state** to the user — what's done, what's next.
3. **Ask what the user wants to do.** Do not assume. The user may want to review the plan, add comments, approve it, revise it, or do something else entirely.
4. If Stage 4 is in progress, review the latest `Commit N notes` before proposing next commit scopes.
5. If the plan status is "Ready", the architect's work is done. Point the user to an implementation session/agent.
6. Never auto-advance stages after resuming; get a fresh explicit confirmation for the next stage, even if prior messages suggest likely approval.

## Principles

- **Read-only until Stage 4.** No code changes during discovery, outlining, or plan expansion. The temptation to "just fix this while I'm here" leads to tangled commits and lost focus.
- **Exact over vague.** "Update the filter function" is useless. "In `src/data/filters.ts:42`, rename `getFilterForPage` to `getAreaFilter` and change the return type from `Filter` to `AreaFilter`" is actionable.
- **Patterns over invention.** The codebase already has conventions. Find them and follow them. The plan should feel like it was written by someone who's worked on this project for months.
- **Consistency beats cleverness.** Resolve conflicting terms, constants, and contracts immediately. A plan with mixed signals is a broken plan.
- **Cross-cutting concerns are first-class.** Every feature plan must explicitly evaluate performance impact, DRY opportunities (avoid duplicated logic/structures), and security implications (auth, data handling, input validation, secrets exposure).
- **Never commit red or dirty quality checks.** Before each commit, run the step's required validation commands (tests/checks/linters/formatters) and fix failures first.
- **The plan is the artifact.** The plan file in `docs/plans/` is the deliverable of this skill — not the code. Code comes later, guided by the plan.
- **Explicit permission over assumed intent.** Every stage transition requires explicit user approval tied to the specific next stage. When in doubt, ask.
