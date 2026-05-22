---
name: sweep-inbox
description: Invoke inbox-sweeper specialist to review what the Sunday Inbox sort routine has accumulated and help file/delete in batch. Use when Andy says sweep the inbox, review my inbox, what's in the inbox, file the inbox, inbox review.
---

# Sweep Inbox

Thin runtime wrapper for [[03 - Skills & Rules/Agents/Specialists/inbox-sweeper|inbox-sweeper specialist]]. Runs an on-demand inbox review.

## When to use
Triggers: `sweep the inbox`, `review my inbox`, `what's in the inbox`, `file the inbox`, `inbox review`, `inbox sweep`.

## Load
- `03 - Skills & Rules/Agents/Specialists/inbox-sweeper.md` - canonical spec
- `C:\Users\<YOUR-USERNAME>\OneDrive\Desktop\Inbox\last_run.log` - what the Sunday routine moved this week
- `5S_STANDARD.md` - filing conventions
- Drive map from `CLAUDE.md` - where things belong

## Run
1. Flip inbox-sweeper to `status: active`
2. Read `last_run.log` - get the list of files moved into `Desktop\Inbox\<type>\`
3. For each file: propose a destination based on type + filename + drive map. Group similar items.
4. Walk Andy through batches: `"5 PDFs look like research papers -- file to E:\Projects\<X>\Research\?"`
5. On approval, move files. Skip files Andy wants to defer.
6. Anything left after the sweep stays in `_Review_/` for next week.

## Output
Write a one-paragraph summary to today's daily note under `## Inbox sweep` section: `"Filed N, deferred M, deleted K. Largest batch: <type> -> <destination>."`

## After
1. Append Activity Log row
2. Flip inbox-sweeper to `status: idle`

## Don't
- Don't bulk-move without batch approval - Andy has judgment calls
- Don't delete without explicit confirmation
- Don't touch files outside `Desktop\Inbox\` and `_Review_/` - scope is sacred