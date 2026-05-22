---
type: index
created: 2026-05-09
---

# Courses

Self-paced training material — courses you're building or working through.
Each course is a folder with markdown lessons. Progress is tracked via
frontmatter so the Dashboard can show it visually.

## How a course is structured

```
13 - Courses\
└─ <course-slug>\
    ├─ README.md          ← course meta (title, status, total_lessons)
    ├─ 01-introduction.md
    ├─ 02-...md
    ├─ ...
    └─ exercises\         (optional)
        └─ ...
```

## Lesson frontmatter

Every lesson `.md` file starts with:

```yaml
---
type: lesson
course: <course-slug>
order: 1
status: not-started | in-progress | completed
completed:           # YYYY-MM-DD when completed
---
```

## Course README frontmatter

```yaml
---
type: course
status: active | paused | completed
created: YYYY-MM-DD
topic: short description
total_lessons: 10
---
```

## Building new courses

Two paths:

1. **Manual**: copy `04 - Templates/_template-course/` to `13 - Courses/<your-course>/`, fill it in.
2. **Agent-driven**: in Cowork or Claude Code, say:
   *"Build me a course on X. Use the template at `04 - Templates/_template-course/`.
    Output one markdown file per lesson with the frontmatter pattern."*

Either way, the dashboard query picks up the new course automatically.

## Progress query (lives in Dashboard.md)

```dataview
TABLE
  length(rows) AS "Lessons",
  length(filter(rows, (r) => r.status = "completed")) AS "Completed",
  length(filter(rows, (r) => r.status = "in-progress")) AS "In progress"
FROM "13 - Courses"
WHERE type = "lesson"
GROUP BY course
SORT course ASC
```

Above query counts lessons by their `course` frontmatter field — no manual
tallying needed.

## Existing courses

(none yet — drop your in-flight course from the other Claude chat into a
new folder here)
