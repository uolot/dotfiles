---
name: review-local
description: "Reviews local code changes for bugs, security issues, and design problems. Use when user asks to review code, check a diff, review a PR, or audit changes before merging. Triggers on: review, code review, check my code, review this diff, PR review, look over changes, audit, pre-merge check."
user_invocable: true
---

# Code Review

Your job is to catch what automation can't — logic errors, design problems, missing edge cases, and security gaps. Leave formatting and style to linters.

## How to Review

1. **Get the diff.** Run `git diff` (or `git diff --staged`, or diff against the target branch) to see what actually changed. Review only what changed — don't audit the entire file.
2. **Understand purpose first.** Read the full diff before commenting on any line. What is this change trying to accomplish? A rename refactor and a feature addition demand very different review lenses.
3. **Think adversarially.** For each change, ask: "What input, timing, or state would break this?" Focus on failure modes the author likely didn't consider.
4. **Check what's missing.** The most valuable review comments are about what ISN'T in the diff — missing error handling for a new code path, missing test for a new branch, missing migration for a schema change, missing null check after an API call that can fail.

## What to Flag

Prioritize by how much damage it causes if it ships:

- **Logic errors** — Off-by-one, wrong comparison operator, inverted boolean, race condition, early return that skips cleanup
- **Security gaps** — Unsanitized input reaching a query or shell command, secrets in code, missing auth check on a new endpoint, overly permissive CORS
- **Silent failures** — Swallowed exceptions, ignored return values, fire-and-forget calls that should be awaited, error paths that log but don't propagate
- **Contract violations** — Changed function behavior without updating callers, new nullable field without handling nil downstream, broken backwards compatibility

## NEVER Flag

- Style or formatting issues — that's the linter's job, not yours
- Naming preferences that contradict the project's existing conventions (if the codebase uses `ctx`, don't suggest `context`)
- Theoretical performance concerns without evidence of actual impact — "this loop is O(n²)" only matters if n can be large
- Missing tests for trivial changes (config tweaks, copy changes, dependency bumps)
- Code outside the diff unless the change directly breaks it
- "You could also..." tangents — suggestions that aren't problems, just alternatives you find more elegant

## Output

Cap your review at 3-7 findings. If you'd flag more, keep only the highest-severity items. A wall of 20 comments teaches the author to ignore reviews.

For each finding:

```
<severity> **<Title>** (file:lines)
<What's wrong and what could go wrong if it ships>
<Suggested fix>
```

Severity:
- 🔴 **Critical** — Would cause data loss, security breach, crash in production, or silent corruption. Must fix.
- 🟡 **Warning** — Likely to cause bugs under realistic conditions, or makes the next change significantly harder. Should fix.
- 🟢 **Nit** — Minor improvement. Take it or leave it. You get at most ONE of these per review — spend it wisely.

If the changes look solid, say so and stop. A clean review is the best outcome, not a failure to find something.
