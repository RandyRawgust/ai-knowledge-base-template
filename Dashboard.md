---
type: dashboard
created: 2026-05-09
updated: 2026-05-13
tags: [dashboard, home]
---

# 🟢 Dashboard

> Canvas view: [[_Command Center.canvas|Command Center]] · this file is the source of truth; the canvas just composes sections of it.

## Today's focus

```dataview
LIST
FROM "01 - Daily Notes"
SORT file.name DESC
LIMIT 1
```

Anti-todo list (things you actually got done — write here as you go):

-

---

## Active projects

```dataview
TABLE status, category, file.mtime AS "last touched"
FROM ""
WHERE type = "project" AND status = "active"
SORT file.mtime DESC
```

(See [[Projects-Index]] for the full game-dev / non-game-dev split.)

---

## Course progress

```dataview
TABLE
  length(rows) AS "Lessons",
  length(filter(rows, (r) => r.status = "completed")) AS "Completed",
  length(filter(rows, (r) => r.status = "in-progress")) AS "In progress"
FROM "13 - Courses"
WHERE type = "lesson"
  AND course
  AND !startswith(string(course), "_")
  AND !contains(file.path, "_template")
GROUP BY course
SORT course ASC
```

[[13 - Courses/README|Courses index]] · drop new courses into `13 - Courses\<slug>\` and they auto-populate.

---

## 🎛️ Agent Status Board

### Department Heads

```dataview
TABLE
  department AS "Dept",
  status AS "Status",
  current_task AS "Working on",
  last_active AS "Last seen"
FROM "03 - Skills & Rules/Agents"
WHERE type = "agent" AND role = "dept-head"
SORT department ASC
```

### Specialists

```dataview
TABLE
  status AS "Status",
  current_task AS "Working on",
  last_active AS "Last seen"
FROM "03 - Skills & Rules/Agents/Specialists"
WHERE type = "agent"
SORT file.name ASC
```

### Project-specific agents

```dataview
TABLE
  project AS "Project",
  status AS "Status",
  current_task AS "Working on",
  last_active AS "Last seen"
FROM "03 - Skills & Rules/Agents/Projects"
WHERE type = "agent"
SORT project ASC, file.name ASC
```

Project-scoped forks of universal agents (per [[03 - Skills & Rules/Rules/vault-conventions]] — when a project needs tweaked behavior, fork the agent under `Agents/Projects/<project>/` instead of mutating the global).

**Status conventions:**
- `idle` — agent is defined but not currently running
- `active` — agent is running right now (you set this before invoking)
- `working` — agent is mid-task (set if it takes more than a few seconds)
- `paused` — agent paused mid-task waiting on you
- `error` — last invocation failed

**Quick links:**
- [[Activity Log]] — full history of who did what
- [[03 - Skills & Rules/README|Agents registry]] — descriptions of each
- [[10 - Topics/AI/Multi-Agent Architecture]] — the bigger plan
- [[20 - Decks/README|Presenter decks]] — voice-chat session decks (Phase 7)

**Workflow (Phase A — manual):**
1. Edit an agent's note → change `status: idle` to `status: active`, fill in `current_task`, update `last_active`
2. Run the agent (paste its prompt into Cowork / Claude Code)
3. When done: append a row to [[Activity Log]], flip `status` back to `idle`

---

## 🕒 Scheduled Tasks

```dataview
TABLE schedule AS "Schedule", status AS "Status", agent AS "Owner"
FROM "06 - Scheduled Tasks"
WHERE type = "scheduled-task"
SORT cron ASC
```

Full index: [[06 - Scheduled Tasks/README]]

---

## 🛠️ Workflows

```dataview
TABLE status AS "Status", agents AS "Agents", file.mtime AS "Updated"
FROM "05 - Workflows"
WHERE type = "workflow"
SORT file.name ASC
```

Workflow spec + how-to: [[03 - Skills & Rules/Rules/workflow-spec]]

---

## Recent activity

```dataview
TABLE WITHOUT ID
  file.link AS "File",
  dateformat(file.mtime, "MM-dd HH:mm") AS "When"
FROM ""
WHERE file.mtime >= date(today) - dur(7 days)
  AND !contains(file.path, ".obsidian/")
SORT file.mtime DESC
LIMIT 10
```

---

## File system health

- Inbox sort routine: **Sunday 9 AM** weekly (Windows Task Scheduler)
- Phase 0 cleanup: 2026-05-08 — 308 files moved, 0 errors
- Phase 2.5 (drive tightening): 2026-05-09 — F:\Game Dev / F:\Docs / E:\Media\{Images,Audio,Videos} structure live
- Items in `_Review_`: check [`Desktop\Inbox\_Review_`](file:///C:/Users/andya/OneDrive/Desktop/Inbox/_Review_)

---

## Quick links

- [[ROADMAP]] — the phased plan
- [[5S_STANDARD]] — file conventions
- [[Projects-Index]]
- [[12 - Software Map/README|Software Map]]
- [[10 - Topics/README|Topics]]
- [[13 - Courses/README|Courses]]
- [E:\Projects](file:///E:/Projects) — non-game projects + vault
- [F:\Game Dev\Projects](file:///F:/Game%20Dev/Projects) — game dev projects
- [F:\Docs](file:///F:/Docs) — game-related reference docs
- [Desktop\Inbox](file:///C:/Users/andya/OneDrive/Desktop/Inbox) — staging

---

## Command Center

The live dashboard is `[[_Command Center.canvas]]` at vault root — a native Obsidian Canvas composing Dataview-driven views of agent status, active projects, workflows, scheduled tasks, and recent activity. No server, no Python, no JS. Open in Obsidian directly. The previous Python implementation (`command_center.py` at `E:\Projects\Command Center\`) was superseded on 05-17-26 — see [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra]] for details.

---

## Embedded views (Custom Frames)

Open via **Ctrl+P → Custom Frames: Open Calendar / Gmail / Command Center**, or click the ribbon 