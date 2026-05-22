---
name: daily-note-writer
description: Create today's Daily Note in 01 - Daily Notes/ with frontmatter, top-3 prompt, and anti-todo section. Use when Andy says start the day, daily note, today's note, what should I work on today.
---

# Daily Note Writer

## When to use
Triggers: daily note, today's note, start the day, morning kickoff, anti-todo.

## Create
File: `01 - Daily Notes/<YYYY-MM-DD>.md` (today's date in ISO).

## Template
```markdown
---
type: daily-note
created: <YYYY-MM-DD>
tags: [daily]
---

# <Day name, Month Day Year>

## Top 3
1.
2.
3.

## Anti-todo
> Things you actually got done today (write here as you go - low-friction capture).

-

## Captures
> Ideas, links, quotes - anything worth keeping.

-

## Tomorrow
> One thing to seed tomorrow.

-
```

## After creating
Open the file. Don't fill in Top 3 yourself - leave for Andy. Suggest he reads the previous day's note (if it exists) for context.

## Don't
- Don't auto-fill Top 3 - that's Andy's choice
- Don't add task-management formality (no priorities, no labels) - it's intentionally minimal
- Don't pad with extra sections - the four above are it