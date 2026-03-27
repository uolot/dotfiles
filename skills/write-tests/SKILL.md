---
name: write-tests
description: "Generates comprehensive tests for a file or module, matching existing project test patterns. Use when user asks to write tests, add test coverage, generate specs, or create unit/integration tests for a file. Triggers on: test, spec, coverage, unit test, integration test, write tests for, add tests, test this."
user_invocable: true
arguments: $FILE — path to the file or module to generate tests for
---

# Test Generation

Write tests that catch real bugs — not tests that just prove the code runs.

## Step 1: Discover Project Patterns

Before writing anything, search the project for existing tests:

- **Framework**: Jest, Vitest, pytest, Go testing, RSpec, etc.
- **File naming**: `*.test.ts`, `*_test.go`, `test_*.py`, `*_spec.rb`, etc.
- **Location**: co-located, `__tests__/`, `tests/`, `spec/`, etc.
- **Conventions**: common helpers, fixtures, factory functions, custom matchers already in use

Match what you find exactly. Introducing a new test style into an existing project creates friction.

## Step 2: Decide What's Worth Testing

Not every function deserves a test. Prioritize by risk:

- **High value**: Functions with branching logic, error handling, data transformation, state mutations, or external integrations
- **Low value**: Simple getters, thin wrappers, config objects, type definitions, re-exports

For each function worth testing, think adversarially: "What input would make this produce a wrong result, crash, or corrupt state?" Write that test first.

## Step 3: Write Tests

For each test, cover three layers — in this priority order:

1. **Core behavior** — Does it produce the right output for representative inputs? Use concrete, realistic values, not `"foo"` and `"bar"`.
2. **Boundaries** — What happens at the edges? Empty input, zero, max values, single-element collections, unicode, concurrent access.
3. **Failure modes** — Does it fail correctly? Wrong types, missing fields, network errors, timeouts. Verify it throws/returns the right error, not just that it doesn't crash.

## Step 4: Verify

Run the tests. Fix any that fail due to test bugs (wrong assertions, missing setup). If a test fails because it caught an actual bug in the source code, flag it clearly — don't "fix" the test to make it pass.

## NEVER

- Test implementation details (private methods, internal state shape) — these tests break on every refactor and catch nothing
- Mock what you don't have to — prefer real objects. Only mock external boundaries (network, DB, filesystem, time)
- Write tests that just replay the implementation logic ("it adds a + b" → `expect(add(2,3)).toBe(5)` is fine, but `expect(add(a,b)).toBe(a+b)` is testing nothing)
- Generate snapshot tests unless the project already uses them — they pass on creation and produce noisy diffs
- Test framework behavior (verifying that `Array.filter` works, or that your ORM saves records)
- Produce a wall of 30+ tests for a simple module — aim for 5-15 focused tests that cover the risk surface
