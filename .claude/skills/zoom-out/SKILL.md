---
name: zoom-out
description: Zoom out and get a higher-level perspective on a section of code. Use when you (or Andy) are unfamiliar with an area and need to understand how it fits into the bigger picture. Triggers - zoom out, map this, what's around this, give me the layout, higher-level view.
---

# Zoom Out

I don't know this area of code well. Go up a layer of abstraction. Give me a map of all the relevant modules and callers, using the project's domain vocabulary (from `CONTEXT.md` or the project README if no CONTEXT exists).

## When to use
Triggers: `zoom out`, `map this`, `give me the layout`, `what's around this`, `who calls this`, `higher-level view`, `I don't know this area`.

## Output shape
- A bulleted map of the modules in scope and a one-line responsibility for each
- Inbound callers (who depends on this) and outbound dependencies (what this depends on)
- Domain terms surfaced from CONTEXT.md / README / vault notes — used consistently in the map
- Anything that smells like a deep module hiding in plain sight, or a shallow pass-through worth deleting

## Don't
- Don't drop into a per-function trace; that's zooming IN
- Don't invent terms — use what the project already names things
- Don't recommend refactors here. If you spot them, hand off to `improve-codebase-architecture`

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/zoom-out) — 05-21-26. Adapted lightly: domain-glossary reference now also points to project README when no CONTEXT.md exists.

## Integrates with
- `03 - Skills & Rules/Rules/engineering-doctrine.md` — research-first habits
- `03 - Skills & Rules/Skills/improve-codebase-architecture.md` — escalate refactor candidates here
