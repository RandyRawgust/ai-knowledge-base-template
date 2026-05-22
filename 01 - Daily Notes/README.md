---
type: index
created: 2026-05-08
---

# Daily Notes

One file per day, named `YYYY-MM-DD.md`. Short. Intent-driven.

## Suggested template (paste into Templater plugin once installed)

```markdown
---
type: daily
date: <% tp.date.now("YYYY-MM-DD") %>
tags: [daily]
---

# <% tp.date.now("dddd, MMMM Do YYYY") %>

## 🎯 Top 3 today

1.
2.
3.

## ✅ Anti-todo (what I actually got done — fill in as you go)

-

## 📓 Notes / brain dump

-

## 🔗 Touched today

(wikilinks to projects/topics worked on)

-
```

## Why daily notes matter for the AI OS

- Claude can read the last 7 daily notes and write a weekly digest
- Anti-todo answers "did I make progress?" without needing a planning system
- Wikilinks here become connection-edges in the graph

## Cadence

- One per day during active weeks
- It's fine to skip days; don't backfill
- The dashboard surfaces the most-recent one
