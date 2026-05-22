---
name: project-scaffolder
description: Scaffold a new project folder with CLAUDE.md, README.md, .gitignore, and the canonical structure. Use when Andy says build/start/create a new project, scaffold X, or set up a new project folder.
---

# Project Scaffolder

Drop a fresh project folder following Andy's vault conventions.

## When to use
Trigger words: scaffold, set up, create a new project, start a new X, drop in a new folder.

## Inputs to confirm
1. Project name (lowercase-hyphens)
2. Location (default `E:\Projects\<name>`)
3. Type (code / docs / course / game-dev)
4. Public or private repo

## Load
- `03 - Skills & Rules/Rules/project-readme.md` - README structure
- `03 - Skills & Rules/Agents/Specialists/project-scaffolder.md` - canonical spec
- `CLAUDE.md` - template for project-level CLAUDE.md

## Create
`project-name/` with: README.md, CLAUDE.md, .gitignore, workflows/ (stub). Add row to Projects-Index.md. Suggest git-bootstrap as next step.

## Don't
- Don't overwrite existing folders without asking
- Don't skip the project CLAUDE.md - it's how doctrine cascades