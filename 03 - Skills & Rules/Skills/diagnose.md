---
type: skill-doc
kind: slash-command
skill_name: diagnose
description: Disciplined diagnosis loop for hard bugs and performance regressions - reproduce, minimise, hypothesise, instrument, fix, regression-test. Use when Andy says diagnose this, debug this, reports a bug, says something is broken/throwing/failing, or describes a performance regression.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, debugging]
---

# /diagnose

A six-phase discipline for hard bugs: build a feedback loop → reproduce → hypothesise (3-5 ranked) → instrument → fix + regression test → cleanup + post-mortem.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/diagnose/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/diagnose.md` |
| Upstream source | [mattpocock/skills · diagnose](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnose) |

## Related

- Runtime: `.claude/skills/diagnose/SKILL.md`
- Integrates with: [[Rules/playbook-refresh]] (when prior fixes failed), [[tdd]] (regression-test step), [[improve-codebase-architecture]] (post-mortem)

## How it differs from existing skills

| Skill | Scope | Use when |
|---|---|---|
| [[diagnose]] | Specific code bug or perf regression (file-level) | Symptom is "code throws/wrong output/slow" |
| [[revive]] | Dormant project (project-level) | Project hasn't been touched in months |
| [[drift-fix]] | Vault drift (vault-level) | Drift-watcher flagged structural rot |

No overlap — three different scales of "something is broken."
