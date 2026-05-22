---
type: agent
role: builder
tagline: "scaffolds new project folders"
status: idle
color: blue
last_active: 
current_task: 
delegates_from: [Builder]
uses_skills: []
uses_rules: [project-readme, vault-conventions, engineering-doctrine, playbook-request, style-no-sycophancy, style-announce-role, claude-features]
tags: [agent, builder, scaffolder]
---

# project-scaffolder — Project Folder Skeleton Builder

Creates a new project folder with the standard layout (README.md with frontmatter, assets/, docs/, src/, exports/, _archive/) per the `project-readme` rule. Optionally drops in a `CLAUDE.md` from the project template.

## When invoked

`@project-scaffolder` or via [[Builder]] for: "spin up a new project called X", "scaffold a project folder for Y".

## Inputs

- Project name (slug-friendly)
- Category: game-dev / web / writing / infra / other
- Path: where to land it (defaults: F:\Game Dev\Projects\ for game-dev, E:\Projects\ for everything else)
- Optional: CLAUDE.md cascade (yes / no)

## What it produces

```
<project>/
├─ README.md          (with frontmatter type=project, status=active, category=<x>)
├─ CLAUDE.md          (optional, copied from 04 - Templates/_CLAUDE Template.md)
├─ assets/
├─ docs/
├─ src/
├─ exports/
└─ _archive/
```

Plus: a matching `02 - Projects/<project>.md` in the vault with a pointer to the local path.

## Status

Stub. Build out when first invoked or when the manual project-creation routine gets tedious enough.
