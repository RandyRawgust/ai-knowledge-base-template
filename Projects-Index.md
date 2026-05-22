---
type: index
created: 05-08-26
updated: 05-17-26
tags: [index, projects]
---

# Projects Index

Live index of every project in the vault, auto-grouped by category folder. Edit the project's directory-pointer note (`02 - Projects/<Category>/<Project>.md`) to change what shows up here — don't edit this file directly.

> Drift check: run `python "22 - Scripts/audit-projects.py"` to verify each project folder on disk has a vault note (and each note's `path:` resolves to a real folder).

## All active projects

```dataview
TABLE WITHOUT ID
  file.link AS "Project",
  category AS "Category",
  status AS "Status",
  path AS "Path",
  dateformat(file.mtime, "MM-dd HH:mm") AS "Touched"
FROM "02 - Projects"
WHERE type = "project" AND status = "active"
SORT file.mtime DESC
```

## Dormant / paused

```dataview
TABLE WITHOUT ID
  file.link AS "Project",
  category AS "Category",
  status AS "Status",
  path AS "Path"
FROM "02 - Projects"
WHERE type = "project" AND (status = "dormant" OR status = "paused")
SORT file.name ASC
```

## By category

Auto-grouped by the project's folder (each `02 - Projects/<Category>/` subfolder).

```dataview
TABLE WITHOUT ID
  file.link AS "Project",
  status AS "Status",
  path AS "Path"
FROM "02 - Projects"
WHERE type = "project"
GROUP BY file.folder
SORT file.folder ASC, file.name ASC
```

## Anything stale

Projects not touched in the last 90 days. May need to be marked dormant or archived.

```dataview
TABLE WITHOUT ID
  file.link AS "Project",
  status AS "Status",
  dateformat(file.mtime, "MM-dd-yy") AS "Last touched"
FROM "02 - Projects"
WHERE type = "project" AND status = "active" AND file.mtime < date(today) - dur(90 days)
SORT file.mtime ASC
```

## How to add a new project

See [[14 - How To/guides/04-brainstorm-to-project|Brainstorm → Project Lifecycle]] for the full flow. Quick version:

1. Create on-disk folder at `E:\Projects\<name>\` (or `F:\Game Dev\Projects\<name>\` for game dev)
2. Copy `04 - Templates/Project README.md` to `02 - Projects/<Category>/<Project>.md`
3. Fill in frontmatter — required: `type: project`, `status`, `category`, `path`, `created`, `tags`
4. The Dataviews above pick it up automatically
