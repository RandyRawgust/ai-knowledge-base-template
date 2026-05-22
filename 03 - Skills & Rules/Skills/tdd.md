---
type: skill-doc
kind: slash-command
skill_name: tdd
description: Test-driven development with red-green-refactor in vertical slices. Use when building features or fixing bugs test-first, mentions of red-green-refactor, integration tests, tracer-bullet TDD, or test-first development.
generated_by: manual import from mattpocock/skills
last_generated: 05-21-26
tags: [skill, slash-command, imported, testing]
---

# /tdd

Test-driven development with a red-green-refactor loop, vertical slices (tracer bullets), and tests written against public interfaces only.

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | `.claude/skills/tdd/SKILL.md` |
| Vault doc (this file) | `03 - Skills & Rules/Skills/tdd.md` |
| Upstream source | [mattpocock/skills · tdd](https://github.com/mattpocock/skills/tree/main/skills/engineering/tdd) |

## Related

- Runtime: `.claude/skills/tdd/SKILL.md`
- Integrates with: [[diagnose]] (regression-test loop), [[improve-codebase-architecture]] (step-4 refactors), [[Rules/engineering-doctrine]]

## Notes
- The helper docs in Matt's repo (`tests.md`, `mocking.md`, `deep-modules.md`, `interface-design.md`, `refactoring.md`) were not pulled in. Key points are inlined in the SKILL.md.
- TDD philosophy here is **integration-style tests against public interfaces** — no mocking internal seams.
