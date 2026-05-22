---
type: skill-doc
kind: slash-command
skill_name: grill-with-docs
description: Grilling session that challenges a plan against the existing domain model, sharpens terminology, and updates CONTEXT.md and ADRs inline as decisions crystallise. Use when Andy wants to stress-test a coding plan against the project's domain language and documented decisions. Code-side counterpart to the brainstormer specialist.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, alignment]
---

# /grill-with-docs

Relentless interview about a code plan, asked one question at a time, that updates `CONTEXT.md` (domain glossary) and `docs/adr/` (architectural decision records) inline as decisions crystallise. Stress-tests vocabulary against existing project language.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/grill-with-docs/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/grill-with-docs.md` |
| Upstream source | [mattpocock/skills · grill-with-docs](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs) |

## Related

- Runtime: `.claude/skills/grill-with-docs/SKILL.md`
- Integrates with: [[Agents/Specialists/brainstormer]] (non-code analog), [[to-prd]] (typical downstream), [[improve-codebase-architecture]] (same grilling loop in step 3), [[Rules/style-no-sycophancy]] (required)

## Relationship to existing brainstormer
- `brainstormer` specialist (Writer dept) → "is this idea worth doing" — wide, conceptual, often outside code. Saves to `00 - Chats/brainstorms/`.
- `grill-with-docs` skill → "is this design consistent with the code we have" — narrow, code-grounded. Saves to `CONTEXT.md` + `docs/adr/`.

**They do not overlap.** Different tools for different questions.
