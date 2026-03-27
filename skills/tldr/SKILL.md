---
name: tldr
description: "Summarizes a file or module in exactly three bullet points. Use when user asks for a summary, overview, explanation, or 'what does this do' for a file, module, or directory. Triggers on: tldr, summarize, overview, what does this do, explain this file, what is this module."
user_invocable: true
arguments: $PATH — path to the file or directory to summarize
---

# TL;DR

Summarize the target in **exactly 3 bullet points** — no more, no less.

## The Three Lenses

- **What** — What does this code do? State the behavior, not the implementation. "Authenticates users via OAuth" not "exports a function that calls the OAuth API."
- **Why** — Why does it exist? What problem or need does it address? If there's no clear "why" (utility files, config), state what depends on it instead.
- **How it fits** — Where does it sit in the architecture? Key consumers, upstream dependencies, or patterns it participates in.

## Rules

- Each bullet: one concise sentence. If you need a comma, it's probably two thoughts — pick the more important one.
- For directories/modules: summarize the module's purpose as a whole, not individual files.
- For large files (500+ lines): read the whole file but summarize at the highest abstraction level — what it does for its callers, not what's inside.

## NEVER

- List function names or exports — that's an index, not a summary
- Describe implementation mechanics ("uses a HashMap", "iterates over the array") — stay at the behavior level
- Write vague catch-alls ("handles various utility operations", "provides helper functions") — if you can't be specific, you haven't understood the file yet
- Add qualifiers or hedges ("primarily", "essentially", "basically") — just state what it does
