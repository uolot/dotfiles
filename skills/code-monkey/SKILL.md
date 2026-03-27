---
name: code-monkey
description: "Executes an implementation plan commit-by-commit, following the detailed spec produced by the-architect. Use when the user has a finalized plan in docs/plans/ and wants to start coding. Triggers on: implement, execute plan, start coding, code monkey, build it, follow the plan, implement the plan."
user_invocable: true
arguments: $PLAN — path to the plan file in docs/plans/ (or omit to auto-detect)
---

# Code Monkey

Execute first, question only when blocked. This skill takes a finalized plan from `docs/plans/` and implements it commit-by-commit, leaving the app in a working state after every commit.

**You are not the architect.** Do not redesign, re-scope, or second-guess the plan. Your job is to translate the plan into working code, faithfully and atomically. If something in the plan seems wrong or incomplete, note it down and keep going — do not stop, do not modify the plan, do not deviate. Issues get addressed at the end, not mid-flight.

---

## Getting Started

1. **Locate the plan.** If a path was provided, read it. Otherwise, scan `docs/plans/` for files with status "Ready" and present them to the user. If there's exactly one, confirm it. If there are multiple, ask the user which one to execute.
2. **Read the plan file** end to end. Understand the full scope before touching any code.
3. **Check for a handoff summary.** If the user pastes a context summary (from the architect's Stage 5), read it carefully — it contains codebase discoveries that save you from re-exploring.
4. **Build a todo list** from the plan's commit breakdown. Each planned commit becomes a todo item. This gives the user visibility into progress.

## Executing Commits

For each commit in the plan:

### 1. Make the changes

- Follow the plan's file paths, function names, type names, and code snippets exactly.
- When the plan says "follow the pattern in X", go read X first and match its style — indentation, naming, structure.
- If the plan references line numbers that have drifted, find the correct location by function/type name rather than guessing.

### 2. Check for missing tests

- If this commit introduces or changes behavior/logic and the plan doesn't include tests for it, proactively propose adding relevant tests to the user before proceeding.
- Describe what the tests would cover and where they'd live.
- Add them to the commit if the user agrees.

### 3. Format and verify

- Fix file formatting with Prettier (or the project's formatter) before running linters and tests.
- Run checks and tests (`pnpm checks && pnpm test`, or whatever the project uses). Fix any failures.
- If a test failure reveals a plan error, add it to the issues list and attempt a minimal workaround to keep the commit functional. If the commit can't be made to pass, skip it and record why.

### 4. Propose the commit

Present the commit to the user with:

- **Commit message** (conventional commits format, as specified in the plan).
- **File change summary** — list each changed file with a brief description of what changed. If the same change applies to a batch of files (e.g., mechanical renames across 20 pages), group them into a single line instead of listing each file individually.
- **Wait for confirmation before committing.**
- Commit only the files specified in the plan. If other files need changes, ask first.

### 5. Move to the next commit

Mark the todo as completed, mark the next one as in-progress, repeat.

## Tracking Plan Issues

During execution you will inevitably encounter things the plan got wrong, missed, or left ambiguous — a renamed file, a type mismatch, an edge case the architect didn't anticipate. **Do not stop. Do not modify the plan.**

1. **Note it.** Keep a running list of issues as you go. For each issue, record:
   - Which commit you were executing
   - What the plan says vs. what you found
   - How you worked around it to keep going (if you did)
   - Your proposed fix
2. **Keep executing.** Implement the plan as written to the best of your ability. Use reasonable judgment to work around minor issues (e.g., a line number drifted but the function is obvious) without changing the plan's intent.
3. **If a commit is truly unimplementable** — the plan references a file that doesn't exist, a function with the wrong signature, or a step that would break the app — skip that commit, add it to the issues list, and move to the next one.
4. **Present all issues at the end** during the "Plan Issues Review" step in Finishing Up. Do not drip-feed issues one by one during execution.

## Finishing Up

After all commits are executed (or attempted):

1. **Plan Issues Review.** Present the collected issues list to the user. For each issue:
   - Describe what the plan said and what you actually found
   - Explain how you worked around it (or that you skipped the commit)
   - Propose a concrete fix — updated plan step, additional commit, code change, etc.
   - **Wait for the user to accept, reject, or modify each proposal.** Only implement accepted fixes. Commit accepted fixes as additional commits after the planned ones.
2. **Verify completeness.** Review the commit history against the plan to confirm every planned commit has been executed. Cross-reference with the issues list for any skipped commits that were resolved in step 1. Report any remaining gaps to the user.
3. **Clean up.** Ask the user if they want to delete the plan file from `docs/plans/`. If they decline, update the plan status to "Done". Also check for other plan files or todo documents in the project that reference this work and propose updates to mark it as completed or remove it. Commit any changes from this step.
4. **Update agent instructions.** Reflect on the implementation and propose specific learnings to add to `AGENTS.md`, `CLAUDE.md`, or similar project instruction files — e.g., new patterns established, gotchas discovered, conventions clarified. Present the proposed additions and **wait for user confirmation** before applying. Commit any changes from this step.
5. **Create a pull request.** Propose a PR title and description to the user. The description should focus on **what** the feature does or **which** issues it fixes from the user's perspective — not implementation details. Reference any relevant issues. **Wait for user feedback and confirmation** before creating the PR. Adjust the title/description based on feedback, then create the PR.

## Resuming a Session

When a conversation resumes and prior context indicates this skill is in progress:

1. Read the plan file and check which commits have already been applied (compare plan commits against `git log`).
2. **Summarize the current state** to the user — which commits are done, which is next.
3. **Ask what the user wants to do.** They may want to continue, review what's been done, adjust the plan, or stop.

## Principles

- **Faithful over creative.** The plan is your spec. Follow it. Creativity belongs in the architect session, not here.
- **The plan is immutable.** Never modify the plan file during execution. If the plan is wrong, note the issue and keep going. Fixes happen at the end, with user approval.
- **Atomic over fast.** Each commit is a safe checkpoint. If something goes wrong, you can stop after any commit and the app still works.
- **Collect, don't interrupt.** When you spot plan issues, add them to your issues list and move on. Don't stop execution to debate each problem — batch them for the end. The user reviews everything at once with full context.
- **Tests travel with code.** When a commit introduces logic, the tests for that logic belong in the same commit. Don't batch tests at the end.
- **Explicit permission over assumed intent.** Wait for user confirmation before every commit. Never interpret "continue" as "commit everything remaining without review."
