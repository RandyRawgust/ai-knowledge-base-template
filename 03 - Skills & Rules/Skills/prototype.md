---
type: skill-doc
kind: slash-command
skill_name: prototype
description: Build a throwaway prototype to flush out a design before committing - either a runnable terminal app for state/business-logic questions, or several radically different UI variations toggleable from one route. Use when Andy says prototype this, let me play with it, sanity-check a data model, try a few designs, mock up a UI.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, design]
---

# /prototype

Throwaway code that answers a question. Branches into **logic** (terminal app, state machine exploration) or **UI** (multiple radical variants on one route, switchable via search param).

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/prototype/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/prototype.md` |
| Upstream source | [mattpocock/skills · prototype](https://github.com/mattpocock/skills/tree/main/skills/engineering/prototype) |

## Related

- Runtime: `.claude/skills/prototype/SKILL.md`
- Integrates with: [[Agents/Builder]] (typical dispatcher), [[tdd]] (the real version after the prototype answers its question)

## Rules of the road
Throwaway from day one, one command to run, no persistence by default, no polish, surface state, delete or absorb when done.
