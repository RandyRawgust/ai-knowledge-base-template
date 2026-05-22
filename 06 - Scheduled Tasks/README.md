---
type: index
project: AI-OS-Setup
created: 2026-05-15
updated: 2026-05-15
tags: [scheduled-tasks, automation, index]
---

# Scheduled Tasks

Cowork-managed jobs that run automatically on a cron schedule. They complement [[05 - Workflows/README|Workflows]] — workflows are recipes an agent follows in-conversation; scheduled tasks run themselves.

> Cron is evaluated in **local time** (not UTC). Format: `minute hour dayOfMonth month dayOfWeek`.
> Tasks run while Cowork is open. If Cowork is closed when a task is due, it fires on next launch.

## Active tasks

| Task | Schedule | Cron | Owner |
|---|---|---|---|
| [[weekly-summarizer]] | Sundays 8 AM | `0 8 * * 0` | Auditor |
| [[drift-watcher-quarterly]] | 1st of Jan/Apr/Jul/Oct, 9 AM | `0 9 1 1,4,7,10 *` | Auditor |

## Where they live

Each task has two artifacts:

1. **Runtime config** — `C:\Users\<YOUR-USERNAME>\OneDrive\Documents\Claude\Scheduled\<task-id>\SKILL.md`. Cowork manages this; don't edit directly.
2. **Vault doc** — `06 - Scheduled Tasks/<task-id>.md` in this folder. Human-readable mirror of what the task does, so it's findable from Obsidian.

## How to create a new scheduled task

From any Cowork session, use the `mcp__scheduled-tasks__create_scheduled_task` tool with:

- `taskId` — kebab-case identifier (e.g. `weekly-summarizer`)
- `cronExpression` — local-time cron string (or `fireAt` for one-shot)
- `prompt` — fully self-contained instructions; each run starts fresh with no memory of the conversation that created it
- `description` — one-line summary

The task is auto-created and shows up in Cowork's "Scheduled" sidebar. Then write a sibling `.md` in this folder documenting what it does.

## How to update or disable

- **Change schedule or prompt:** `mcp__scheduled-tasks__update_scheduled_task`
- **List what's running:** `mcp__scheduled-tasks__list_scheduled_tasks`
- **Disable temporarily:** `update_scheduled_task` with `enabled: false`
- **Delete entirely:** remove the `Scheduled/<task-id>/` folder under OneDrive\Documents\Claude

## Anti-patterns

- **Don't put session-specific context in the prompt.** Each run is a cold start. Reference files and rules, not "the thing we discussed earlier."
- **Don't schedule one-offs as recurring.** Use `fireAt` for "remind me Friday at 3 PM" type asks.
- **Don't skip the vault doc.** A task whose definition lives only in Cowork's hidden config is invisible to the vault and to drift-watcher.
- **Don't forget timezone in external checks.** Cron is local, but if your task calls an external API, that API's "today" may differ.

## Status markers

- ✅ live — running on schedule
- ⏸️ paused — disabled but not deleted
- 🚧 broken — last run failed; needs investigation
- 🗑️ retired — kept here for posterity, no SKILL.md

## Retrospective

> Append durable lessons.

- [2026-05-15] — Initial 2 tasks created. Phase 9 of the AI OS rollout. Next iteration: see whether weekly-summarizer surfaces signal worth acting on vs noise (and tighten the prompt accordingly).
