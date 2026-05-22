---
type: software
category: dev-tool
installed: true
install_location: C:\Users\<YOUR-USERNAME>\AppData\Local\Programs\Python\Python312
publisher: Python Software Foundation
license: free
last_used: 2026-05-08
tags: [scripting, dev]
---

# Python

General-purpose scripting language. Used for the weekly Inbox sort routine,
data wrangling, and any script Cowork or Claude Code generates.

## Touches

- [C:\Users\<YOUR-USERNAME>\Tools\sort_inbox.py](file:///C:/Users/andya/Tools/sort_inbox.py) — the routine
- [E:\Projects](file:///E:/Projects) — any project's `src/` folder
- [C:\Users\<YOUR-USERNAME>\OneDrive\Documents\Cowork Plans](file:///C:/Users/andya/OneDrive/Documents/Cowork%20Plans) — `build_plan_v2.py` and similar

## Powers / Used by

- The weekly Inbox sort routine (Sunday 9 AM)
- Any one-off data-wrangling Cowork generates
- Future: vault maintenance scripts, dashboard data fetchers

## Related software

- [[git]] — version control for any non-trivial Python project
- [[cowork]] / [[claude-code]] — primary callers/authors

## Notes

- `pip install --user <pkg>` for personal scripts (avoid admin)
- Use venv (`python -m venv .venv`) for any project with dependencies
- For the sort_inbox.py routine: zero dependencies, runs on stdlib only
