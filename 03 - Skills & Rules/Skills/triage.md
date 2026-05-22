---
type: skill-doc
kind: slash-command
skill_name: triage
description: Triage issues through a state machine of triage roles - bug/enhancement plus needs-triage/needs-info/ready-for-agent/ready-for-human/wontfix. Use when Andy wants to create an issue, triage incoming bugs or feature requests, prepare issues for an AFK agent, or manage issue workflow.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, workflow]
---

# /triage

Walks issues through a state machine of triage roles (bug/enhancement × needs-triage/needs-info/ready-for-agent/ready-for-human/wontfix). Posts triage notes, agent briefs, or out-of-scope rationales as appropriate. Every comment carries an "AI-generated during triage" disclaimer.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/triage/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/triage.md` |
| Upstream source | [mattpocock/skills · triage](https://github.com/mattpocock/skills/tree/main/skills/engineering/triage) |

## Related

- Runtime: `.claude/skills/triage/SKILL.md`
- Integrates with: [[Agents/Specialists/inbox-sweeper]] (vault-side counterpart), [[to-prd]] (when an enhancement needs a full PRD), [[to-issues]] (downstream slicing)

## Pre-req
Project needs a label vocabulary. Map Matt's canonical roles to the actual GitHub labels you use the first time you run this; capture the mapping in the project README or `.github/triage-labels.md`.
