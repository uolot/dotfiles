---
name: refactor
description: "Analyzes code and suggests concrete refactoring improvements. Use when user asks to refactor, clean up, simplify, improve, or review code quality of a specific file or module. Triggers on: refactor, code smell, clean up, simplify, improve code, make more readable, reduce complexity, tech debt."
user_invocable: true
arguments: $FILE — path to the file to analyze
---

# Refactor

Suggest changes that reduce the cost of the *next* change — not changes that merely look cleaner.

## Before You Suggest Anything

Read the file, then ask yourself:

1. **Churn**: Is this code actively modified? Low-churn code rarely benefits from refactoring — leave it alone even if it's ugly.
2. **Blast radius**: Does the change cross module boundaries or alter public API? Flag it as high-risk and weigh whether the payoff justifies it.
3. **Intent**: Why is the code written this way? Duplication is sometimes intentional for decoupling. Long functions sometimes read better top-to-bottom. Understand the author's trade-off before second-guessing it.
4. **ROI**: Will this change make future work measurably easier, or does it just satisfy aesthetic preference?

## What to Look For

Focus on issues that cause real pain during development:

- **Readability traps**: Code where the next reader will misunderstand behavior — misleading names, hidden side effects, boolean parameters that invert meaning
- **Change amplification**: Modifying one behavior requires touching many places — missing abstraction or scattered responsibility
- **Cognitive load**: Functions where you must hold too many things in your head at once — deep nesting, interleaved concerns, non-obvious control flow
- **Fragile hotspots**: Code where small changes frequently cause bugs — tight coupling, implicit ordering dependencies, shared mutable state

## NEVER Suggest

- Extracting a function called exactly once just to "name" 3-5 lines — inline code with a comment is already clear
- Replacing clear imperative loops with chained functional calls for "elegance" — readability beats style
- Breaking up a file that reads well top-to-bottom solely because it exceeds some line count
- Adding abstraction layers when only one implementation exists — abstractions earn their keep at two or more
- Renaming variables to match your preference when existing names are clear in context
- Suggesting design patterns (Strategy, Observer, Factory) where a simple if/else or function call suffices
- Rewriting working code in a "more modern" style when the current style is consistent within the project

## Output

Limit to 3-7 suggestions. If you'd list more, prioritize by impact and cut the rest.

For each suggestion:

```
**<Brief title>** (lines X-Y)
- Pain: What goes wrong when someone works with this code
- Change: What to do and why it helps
- Risk: What could break (or "Low risk" if safe)
```

If the code is clean and well-structured, say so and stop. An empty report is a valid outcome — resist the urge to find something wrong.
