---
name: copilot-pr-review
description: Critically review and respond to GitHub Copilot PR comments. Use this skill whenever the user mentions Copilot review comments, wants to process automated PR feedback, asks to triage bot comments on a pull request, or references Copilot suggestions on their code. Also use when the user says things like "handle the copilot comments", "go through the Copilot PR review", or "address the bot feedback". This skill applies to any language, not just TypeScript.
---

# Copilot PR Review

Review GitHub Copilot's PR comments with critical judgment. Copilot catches real issues, but it also generates noise — outdated comments, theoretical concerns, and suggestions that introduce worse patterns than the code they replace. Your job is to separate signal from noise, fix what matters, and dismiss the rest with clear reasoning.

## Workflow

### 1. Resolve the PR number

This skill accepts an optional PR number as an argument (e.g., `/copilot-pr-review #1234` or `/copilot-pr-review 1234`).

- **If a PR number was provided**: use it directly.
- **If no PR number was provided**: detect it from the current branch:
  ```bash
  gh pr view --json number,title,url --jq '"\(.number) \(.title) \(.url)"'
  ```
  Present the result to the user and ask them to confirm before proceeding. If no PR is associated with the current branch, ask the user for the number.

### 2. Fetch and filter the PR comments

Use the REST API to pull review comments with staleness info:

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments --jq '.[] | {id, path, line, body, user: .user.login, created_at, updated_at, in_reply_to_id, position, diff_hunk, subject_type}'
```

Filter to Copilot's comments. The login varies by API:
- **REST API**: `Copilot` (capital C, type `Bot`)
- **GraphQL**: `copilot-pull-request-reviewer`

Always check the actual `user.login` / `author.login` from the response to confirm.

**Drop outdated and resolved comments before triaging.** These are noise by definition — don't waste time re-evaluating them.

- **Outdated** (REST API returns `position: null`): GitHub marks review comments as outdated when the underlying code changes. Filter these out:
  ```bash
  gh api repos/{owner}/{repo}/pulls/{number}/comments \
    --jq '[.[] | select(.user.login == "Copilot" or .user.login == "copilot-pull-request-reviewer[bot]" or .user.login == "github-copilot[bot]") | select(.position != null)] | map({id, path, line, body, diff_hunk, subject_type})'
  ```
  Comments with `position: null` are outdated — the diff they reference no longer exists in the current version of the PR. Exclude them.

- **Resolved**: GitHub tracks resolved state on review _threads_, not individual comments. Use GraphQL to check:
  ```bash
  gh api graphql -f query='
    query($owner: String!, $repo: String!, $number: Int!) {
      repository(owner: $owner, name: $repo) {
        pullRequest(number: $number) {
          reviewThreads(first: 100) {
            nodes {
              isResolved
              isOutdated
              comments(first: 1) {
                nodes { id databaseId body author { login } }
              }
            }
          }
        }
      }
    }' -f owner='{owner}' -f repo='{repo}' -F number={number}
  ```
  Drop any thread where `isResolved: true` or `isOutdated: true`. Only triage threads that are both **active** and **current**. Cross-reference by matching `databaseId` from GraphQL to `id` from the REST results — exclude any REST comment whose thread is resolved or outdated.

**You MUST run the GraphQL query before proceeding to triage.** The `/pulls/{number}/comments` REST response does not include review-thread resolution state, so skipping this step will cause you to re-triage comments the author has already resolved.

If _all_ Copilot comments are outdated or resolved, report that to the user and stop — there's nothing to triage.

### 3. Triage each comment

Read each remaining comment alongside the actual code it references. Classify into **fix** or **dismiss** using the framework below.

**Extract Copilot's severity** from the comment body. This repo's Copilot instructions (`.github/instructions/code-review.instructions.md`) tell Copilot to prefix comments with a severity emoji:

- 🔴 = critical
- 🟠 = high
- 🟡 = medium
- 🟢 = low
- ⚪ = nit

Parse the first emoji in the body to extract severity. If no severity emoji is present (e.g., older reviews before the instructions were added), record it as `—`.

**Assess your own severity** independently by reading the actual code, its callers, and the surrounding context. Use these levels:

| Level        | Meaning                                                                                          |
|--------------|--------------------------------------------------------------------------------------------------|
| **critical** | Will cause runtime failure, data loss, or security vulnerability in production                   |
| **high**     | Likely bug or correctness issue that affects real users under normal conditions                   |
| **medium**   | Real concern but limited blast radius — edge case handling, missing validation at a boundary      |
| **low**      | Style, readability, or minor convention issue — correct code that could be marginally better      |
| **none**     | No real issue — the comment is noise (theoretical, already addressed, or suggests a worse pattern)|

Present a summary table to the user before acting. If any comments were filtered as outdated/resolved, note the count above the table (e.g., "Skipped 3 outdated/resolved comments"):

```
| # | File:Line         | Category | Copilot Sev. | Our Sev. | Action  | Summary                              |
|---|-------------------|----------|--------------|----------|---------|--------------------------------------|
| 1 | src/auth.ts:42    | Bug      | 🟠 high      | critical | Fix     | Null check missing on user.session   |
| 2 | src/api.ts:88     | Style    | 🟡 medium    | none     | Dismiss | Already fixed in abc1234             |
| 3 | lib/parser.py:15  | Type     | —            | low      | Dismiss | Suggests adding Any — weakens types  |
```

When Copilot's severity and yours **disagree**, add a brief note explaining why (e.g., "Copilot rates medium but the code path is unreachable from any caller" or "Copilot rates low but this is a real null dereference in the hot path").

Wait for the user to confirm or adjust the triage before proceeding.

### 4. Apply fixes

For each comment marked **fix**, make the change in the codebase. Commit with a message that references the review:

```
fix: null-check user.session before access

Addresses Copilot review comment on PR #<number>
```

Group related fixes into a single commit when they address the same concern.

### 5. Draft replies

For each comment, draft a concise reply. Present all draft replies to the user for approval before posting.

**For fixed items** — include both hash and message, since hashes change on rebase:

> Fixed in `abc1234` ("fix: null-check user.session before access") — added null check before accessing `user.session`.

**For dismissed items:**

> Already addressed in `def5678` ("fix: add input validation to auth flow") which adds the validation upstream.

or

> The suggested `Any` cast would weaken type safety here. The current typing is correct — `UserSession` is the narrowest valid type for this call site.

Post approved replies:

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies \
  -f body="<reply text>"
```

## Triage Framework

### Fix — the comment identifies a real problem

- **Genuine bugs**: Null dereference, off-by-one, race condition, incorrect logic that would fail at runtime
- **Security issues**: Injection, auth bypass, sensitive data exposure, insecure defaults
- **Convention violations**: Naming, patterns, or structures that conflict with the project's established conventions (check CLAUDE.md, linter config, or surrounding code for what "convention" means in this repo)
- **Missing error handling**: At system boundaries (user input, network calls, file I/O) where failures are realistic

### Dismiss — the comment is noise

- **Already addressed**: Another commit in the PR or branch already fixes this. Check with `git log --oneline` on the branch.
- **Suggests weaker types**: Any comment that recommends introducing `any`, `Any`, `object`, `Object`, `dynamic`, untyped generics, or similarly loose types where a specific type already exists. Copilot frequently suggests these "for flexibility" — they almost always reduce safety.
- **Theoretical concerns**: The comment flags a scenario that _could_ happen in general but _doesn't_ happen given the actual call sites, inputs, or constraints of this codebase. Check the callers before dismissing — if only 2 functions call this code and neither can produce the problematic input, it's theoretical.
- **Unnecessary complexity**: The suggestion adds abstraction, indirection, or defensive code that doesn't serve a concrete need. If the current code is correct and readable, more code is not better code.
- **Style-only with no convention backing**: Copilot sometimes suggests stylistic changes (variable renames, reordering, extra whitespace) that don't match any project convention. If the linter doesn't flag it and the team doesn't enforce it, dismiss.

### When you're unsure

If a comment sits on the border, default to asking the user rather than guessing. Present the comment, the relevant code, and the callers — let them decide.

## Anti-patterns — what NOT to do

**Do not blindly apply Copilot's suggested code.** Copilot's _detection_ of issues is often better than its _fixes_. Common problems with its suggestions:

- Introduces `any`/`Any` casts to "solve" type errors
- Adds unnecessary null checks or try/catch blocks around code that's already safe
- Wraps simple code in abstractions (helper functions, utility classes) for a single use
- Suggests verbose patterns where the language has a cleaner idiom

When fixing a genuine issue Copilot found, write the fix yourself based on the surrounding code's style and the project's patterns. Use Copilot's suggestion only as a starting point if it happens to be good.

**Do not reply with boilerplate.** Avoid responses like "Great catch!" or "Thanks for the feedback!" — they add noise to the PR. State what you did and why, nothing more.

**Do not batch-dismiss without reading.** Even when most comments are noise, read each one against the actual code. Copilot occasionally buries a real bug in a sea of style nits.
