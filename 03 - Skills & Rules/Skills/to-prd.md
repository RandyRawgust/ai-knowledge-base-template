---
type: skill-doc
kind: slash-command
skill_name: to-prd
description: Turn the current conversation context into a PRD (problem statement, user stories, implementation decisions, testing decisions). Use when Andy wants to crystallize what we've been discussing into a written PRD - no interview, just synthesis.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, planning]
---

# /to-prd

Synthesizes the current conversation into a PRD. Does NOT interview — assumes the conversation already has enough context. Outputs to a GitHub issue or to `docs/prd/<MM-DD-YY>-<slug>.md` if `gh` isn't configured.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/to-prd/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/to-prd.md` |
| Upstream source | [mattpocock/skills · to-prd](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-prd) |

## Related

- Runtime: `.claude/skills/to-prd/SKILL.md`
- Integrates with: [[to-issues]] (downstream slicing), [[Rules/playbook-request]] (typical playbook that consumes the PRD), [[Rules/engineering-doctrine]]
