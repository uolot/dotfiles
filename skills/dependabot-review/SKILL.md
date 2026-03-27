---
name: dependabot-review
description: Use when validating Dependabot PRs, checking dependency updates are safe, or verifying automated dependency bumps before merge. Triggers on "validate dependabot", "check PR #X", "dependency update", or when reviewing bot-generated PRs.
---

# Validating Dependabot PRs

## Overview

Dependabot PRs automate dependency updates but require systematic validation. This skill enforces complete validation through all steps.

## When to Use

Use when:

- User asks to validate a Dependabot PR
- Checking if a dependency update is safe to merge
- Reviewing bot-generated dependency bumps
- User provides a PR number or branch for validation

Do NOT use for:

- Manual dependency updates (use standard PR review)
- Non-dependency changes

## The Iron Rule

**Complete ALL validation steps. Fix small issues on the spot, document larger ones.**

Validation steps are non-negotiable:

- Always run `pnpm install` → validates lock file
- Always run ALL checks → catches real issues
- Always run the app → tests ≠ runtime behavior
- Always check changelog → patch versions can break

**When issues found:**

- **Quick fixes** (types, formatting, test mocks) → Fix on the spot, continue validation
- **Larger issues** (peer dep conflicts, breaking changes) → Document clearly, still provide recommendation

## Step-by-Step Process

### 1. Get Branch or PR Number

```bash
gh pr checkout <PR_NUMBER>
# or
git checkout <branch-name>

# Always pull latest changes
git pull
```

### 2. Install Dependencies

**Always run install.**

```bash
pnpm install
```

**Validate lock file and dependencies:**

```bash
pnpm why <updated-package>        # Check dependency chain
pnpm -r list <updated-package>    # Check versions across workspaces (monorepo)
pnpm audit                        # Security vulnerabilities
```

**If warnings appear:**

- Peer dep conflicts → Document, may need follow-up updates
- Duplicate versions across workspaces → Run `pnpm dedupe` or document
- Lock file out of sync → Blocker, document this

### 3. Run ALL Checks

**Run the standard validation checks:**

```bash
pnpm format:check
pnpm typecheck
pnpm lint
pnpm stylelint
pnpm check-licenses
pnpm ls-lint
pnpm lint:ws
pnpm test  # Unit tests (pre-push uses test:changed conditionally)
```

**Note:** If checks pass suspiciously fast, Turbo cache may be stale. Force rerun with `pnpm exec turbo run test --force`.

**If ANY check fails:** Fix it before proceeding.

### 4. Run the Application

**Critical step.**

```bash
# Start app
pnpm dev  # or pnpm start
```

**Verify:**

- App starts without errors
- No runtime console errors
- Basic navigation works (open http://localhost:3000)

Tests can pass while app fails at runtime.

### 5. Check Changelog for Breaking Changes

**Read changelog/release notes for EVERY updated package.**

```bash
gh pr view <PR_NUMBER> --json body  # Dependabot includes changelog excerpt
```

Look for:

- Breaking changes (even in patches - they happen)
- Deprecated APIs used in codebase
- New features affecting types

**Never assume patch version = safe.**

### 6. Fix Issues or Document Them

**Quick fixes:**

- Type errors from new optional properties → Add to mocks/interfaces
- Test failures from updated APIs → Update test expectations
- Formatting issues → Run `pnpm format:fix`

**For each fix:**

- Document file:line - what changed and why

**Larger issues (document, don't block):**

- Peer dep conflicts requiring multiple package updates
- Breaking changes needing team discussion

Example:

```
✅ Good: "Added unstable_mask: undefined to test mocks (test/setup.ts:18,80) - new optional property in react-router 7.13.1"
❌ Bad: "Updated types"
```

### 7. Write Summary

**Before writing summary:**

```bash
# REQUIRED: Verify formatting on modified files
pnpm format:check
```

**Format: Decision first, evidence second, actions third.**

Lead with status:

- ✅ READY TO MERGE - Fixed all issues or none found
- ⚠️ READY WITH NOTES - Works but has documented concerns
- ❌ BLOCKED - Critical issue needs discussion

Provide evidence:

- Package versions changed
- Lock file status
- Check results (pass/fail count)
- Database + app status
- Breaking changes (or "None")
- Fixes made (file:line - what + why)
- Outstanding issues (if any)

End with **Next:** concrete action.

## Red Flags

These thoughts mean you're rationalizing:

- "Patch version is safe" → Still check changelog
- "Tests pass" → Still run the app
- "This is taking too long" → Complete validation

**All of these mean: Complete ALL steps.**

## Common Mistakes

| Mistake                  | Fix                                                          |
| ------------------------ | ------------------------------------------------------------ |
| Skip app validation      | Run `pnpm dev` and verify startup                            |
| Assume patch = safe      | Read changelog for breaking changes                          |
| Cherry-pick checks       | Run the full standard check suite (format, typecheck, etc.) |
| Skip format verification | Run `pnpm format:check` before completion                    |
| Ignore Turbo cache       | Force rerun with `pnpm exec turbo run test --force`          |

## Example Summary

```markdown
## PR #2881: AWS CDK v2.238.0 → v2.243.0

**✅ READY TO MERGE** - All checks pass, no breaking changes

**Changes:**

- `aws-cdk-lib`: 2.238.0 → 2.243.0 (patch)
- `constructs`: 10.4.1 → 10.4.5 (patch)
- Lock file: ✅ Clean install, no workspace conflicts
- Database: ✅ Started (port 5432)
- Checks: ✅ All passed (8/8 via Turbo)
  - format:check, typecheck, lint, stylelint, check-licenses, ls-lint, lint:ws, test (2056/2056)
- App: ✅ Starts at http://localhost:3000, no runtime errors
- Breaking: None (changelog reviewed - bugfixes only)

**Fixes made:** None needed

**Next:** Safe to merge
```
