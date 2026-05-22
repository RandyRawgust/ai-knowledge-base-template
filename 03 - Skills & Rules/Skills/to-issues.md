---
type: skill-doc
kind: slash-command
skill_name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable GitHub issues using tracer-bullet vertical slices. Use when Andy wants to convert a plan into issues, create implementation tickets, or break work into shippable units.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, planning]
---

# /to-issues

Break a plan into independently-grabbable GitHub issues using **vertical slices (tracer bullets)** — each slice cuts through ALL integration layers end-to-end, never a horizontal slice of one layer. Quizzes Andy on granularity and dependencies before creating issues.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/to-issues/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/to-issues.md` |
| Upstream source | [mattpocock/skills · to-issues](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-issues) |

## Related

- Runtime: `.claude/skills/to-issues/SKILL.md`
- Integrates with: [[to-prd]] (typical upstream), [[tdd]] (downstream implementation)

## Notes
Falls back to `docs/issues/<MM-DD-YY>-<slug>.md` markdown list when the project has no `gh` CLI configured. Tags slices as `HITL` (human-in-the-loop) or `AFK` (agent-friendly). Prefer AFK.
