# 🤖 CLAUDE.md — <Project Name>
> Project-level rules. Layered ON TOP of vault-root CLAUDE.md.
> Keep under 150 lines. Refactor out if you need more.

## What this project is

<One sentence: what is this project, what's the goal, what's the stack.>

Path: `<absolute path to project folder>`
Status: `active | paused | dormant | done | archived`

## Project-specific conventions

(rules that ONLY apply when working in this project — don't repeat
vault-wide ones, those are already in the root CLAUDE.md)

- 
- 
- 

## Decision table — when user asks X in this project, do Y

| Request | Agent / Skill / Action |
|---|---|
| "build the next <thing>" | [[Builder]] → <specialist> |
| "fix <bug>" | [[Writer]] → edit `src/<file>` |
| | |

## Stack

- Software: [[<software-1>]], [[<software-2>]]
- Skills: docx / pdf / etc as needed
- Agents owned by this project: `03 - Skills & Rules/Agents/Projects/<this>/`

## Folder layout

```
<project>/
├─ README.md              ← what this is + status
├─ CLAUDE.md              ← this file
├─ workflows/             ← project-specific workflows (see Workflows below)
│   ├─ <slug>.md          ← one file per workflow
│   └─ <slug>.canvas      ← auto-generated; do not hand-edit
├─ assets/                ← images, audio, reference material
├─ docs/                  ← design docs, plans, notes
├─ src/                   ← code, scripts, raw working files
├─ exports/               ← rendered output, deliverables
└─ _archive/              ← old versions, kept for reference
```

## Workflows

Detailed sequences for recurring work in this project live in `./workflows/`.
Format: see [[03 - Skills & Rules/Rules/workflow-spec]]. Workflows are markdown-only
as of 05-17-26 — the `.canvas` sibling requirement was retired.

- [[workflows/<slug>|<workflow name>]] — one-line summary
- [[workflows/<slug>|<workflow name>]] — one-line summary

## Anti-patterns (don'ts for this project)

- 
- 

## Status

Current focus:
Blockers:
Next milestone:

## Retrospective — lessons specific to this project

> Append after major work sessions. Don't dump every commit history;
> only durable lessons.

- 
