---
type: skill
category: automation
source: cowork-builtin
tags: [skill, automation]
source: anthropic
external: true
---

# schedule — Scheduled Tasks

Create scheduled tasks in Cowork that run on intervals or on-demand.

## Capabilities

- Define tasks with cron-style schedules
- One-time future tasks (fire-once at a specific time)
- On-demand tasks (manually triggered)
- Tasks have associated SKILL.md prompts that drive them

## Used by

- [[AI OS Setup]] — could host the weekly Inbox audit summary
- Future: course progress reminders, project status digests

## Note

This is **separate from** the Windows Task Scheduler running `sort_inbox.py`.
That's at the OS level. Cowork scheduled tasks run inside Cowork.
