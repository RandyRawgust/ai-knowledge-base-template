---
name: prototype
description: Build a throwaway prototype to flush out a design before committing - either a runnable terminal app for state/business-logic questions, or several radically different UI variations toggleable from one route. Use when Andy says prototype this, let me play with it, sanity-check a data model, try a few designs, mock up a UI.
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

Identify which question is being answered — from Andy's prompt, the surrounding code, or by asking if he's around:

- **"Does this logic / state model feel right?"** → Logic branch. Build a tiny interactive terminal app that pushes the state machine through cases that are hard to reason about on paper.
- **"What should this look like?"** → UI branch. Generate several radically different UI variations on a single route, switchable via a URL search param and a floating bottom bar.

The two branches produce very different artifacts — getting this wrong wastes the whole prototype. If the question is genuinely ambiguous and Andy isn't reachable, default to whichever branch better matches the surrounding code (backend module → logic; page or component → UI) and state the assumption at the top of the prototype.

## Rules that apply to both

1. **Throwaway from day one, and clearly marked as such.** Locate the prototype close to where it will actually be used (next to the module or page it's prototyping for) so context is obvious — but name it so a casual reader can see it's a prototype, not production. For throwaway UI routes, obey whatever routing convention the project already uses.

2. **One command to run.** Whatever the project's existing task runner supports — `pnpm <name>`, `python <path>`, `bun <path>`, etc. Andy must be able to start it without thinking.

3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is *checking*, not something it should depend on. If the question explicitly involves a database, hit a scratch DB or a local file with a clear `PROTOTYPE — wipe me` name.

4. **Skip the polish.** No tests, no error handling beyond what makes it *runnable*, no abstractions. Learn something fast, delete it.

5. **Surface the state.** After every action (logic) or on every variant switch (UI), print or render the full relevant state so Andy can see what changed.

6. **Delete or absorb when done.** When the prototype has answered its question, either delete it or fold the validated decision into the real code — don't leave it rotting in the repo.

## Logic branch (cheat-sheet)

- Single file (or one file + a small fixtures file)
- A `while True` loop reading from stdin, applying one action per loop, printing state
- No I/O beyond stdin/stdout. No HTTP, no DB.
- Hard-code the cases that are awkward to reason about on paper and step through them interactively

## UI branch (cheat-sheet)

- A single route at a clearly-marked path (`/_prototype/<feature>` or your framework's equivalent)
- 3–5 variants, switchable via `?variant=<n>` or a small floating button bar at the bottom
- Each variant is allowed to look *radically* different — explore, don't converge yet
- No real data; fixtures only
- Annotate each variant with what it's trying to test (information hierarchy? interaction model? visual density?)

## When done

The *answer* is the only thing worth keeping. Capture it somewhere durable (commit message, ADR, issue, or a `NOTES.md` next to the prototype) along with the question it was answering. Leave the placeholder so future-Andy can fill in the verdict before deleting the prototype.

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/prototype) — 05-21-26. Helper files (LOGIC.md, UI.md) summarised inline as cheat-sheets above.

## Integrates with
- `03 - Skills & Rules/Agents/Builder.md` — Builder dispatches `prototype` for "try a quick thing" requests
- `03 - Skills & Rules/Skills/tdd.md` — when the prototype answers its question, the real version is built TDD-style
