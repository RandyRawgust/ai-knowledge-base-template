---
type: skill-doc
kind: slash-command
skill_name: setup-pre-commit
description: Set up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests in the current repo. Use when Andy wants to add pre-commit hooks, set up Husky, configure lint-staged, or add commit-time formatting / typechecking / testing to a JS/TS project.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, git]
---

# /setup-pre-commit

Installs Husky + lint-staged + Prettier into a JS/TS project. Writes `.husky/pre-commit` that runs `lint-staged`, `typecheck`, and `test`. Adapts to the detected package manager (npm/pnpm/yarn/bun).

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/setup-pre-commit/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/setup-pre-commit.md` |
| Upstream source | [mattpocock/skills · setup-pre-commit](https://github.com/mattpocock/skills/tree/main/skills/misc/setup-pre-commit) |

## Related

- Runtime: `.claude/skills/setup-pre-commit/SKILL.md`
- Integrates with: [[git-bootstrap]] (typical predecessor), [[commit-message-writer]]

## Scope note
**JS/TS only.** For Andy's PowerShell-bootstrapped projects (TerraWatt, the vault), use `git-bootstrap` plus the hook PowerShell scripts in `22 - Scripts/`.
