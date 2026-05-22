---
type: skill-doc
kind: slash-command
skill_name: improve-codebase-architecture
description: Find deepening opportunities in a codebase, informed by domain language and ADRs. Use when Andy wants to improve architecture, find refactoring opportunities, consolidate tightly-coupled modules, or make a codebase more testable and AI-navigable. Run periodically to keep entropy in check.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, architecture]
---

# /improve-codebase-architecture

Surface architectural friction and propose **deepening opportunities** — refactors that turn shallow modules into deep ones. Uses a precise vocabulary (Module / Interface / Implementation / Depth / Seam / Adapter / Leverage / Locality) and the **deletion test** to identify pass-throughs.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/improve-codebase-architecture/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/improve-codebase-architecture.md` |
| Upstream source | [mattpocock/skills · improve-codebase-architecture](https://github.com/mattpocock/skills/tree/main/skills/engineering/improve-codebase-architecture) |

## Related

- Runtime: `.claude/skills/improve-codebase-architecture/SKILL.md`
- Integrates with: [[Agents/Auditor]] (typical dispatcher on a cadence), [[zoom-out]] (upstream input), [[diagnose]] (post-mortem hand-off)

## Cadence suggestion
Matt recommends running this every few days on any actively-developed codebase. For Andy's projects (TerraWatt especially), make it a monthly Auditor task.
