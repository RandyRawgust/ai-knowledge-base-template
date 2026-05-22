---
name: handoff
description: Write a next-session handoff note before context runs out. Captures current state, what's done, what's mid-stream, and what to pick up first. Use when Andy says handoff, write a handoff, wrap up, context is running out, save state, end of session.
---

# Handoff

Write a structured next-session handoff so the next agent (or future-Andy) can resume cold without re-deriving context.

## When to use
Triggers: `handoff`, `write a handoff`, `wrap up the session`, `context is running out`, `save state`, `end of session`, `next session brief`.

## Load
- `CLAUDE.md` - so the handoff respects vault conventions
- `03 - Skills & Rules/Agents/Activity Log.md` - last 5 rows for context
- Current daily note `01 - Daily Notes/<today>.md` if it exists
- Any files the session has been editing (re-read for accurate current-state)

## Output

Write to `00 - Chats/handoffs/<MM-DD-YY>-<slug>.md`. Create the `handoffs/` subfolder if missing.

Format:

```markdown
---
type: handoff
created: <MM-DD-YY>
session_topic: <one-line>
status: <in-progress | done | blocked>
tags: [handoff]
---

# Handoff -- <topic>

## TL;DR
One paragraph: what we were doing, where we left off, what to do next.

## What got done this session
- <concrete change with file path>
- <...>

## Mid-stream (pick up here)
- <file or task half-finished, with line numbers / cursor location if relevant>
- <...>

## Blockers / open questions
- <thing that needs Andy's decision before next agent can proceed>

## Files touched
- <relative path> -- <one-line what changed>

## Recommended first move next session
The single most useful thing to do in the first 2 minutes of the next session.
```

## After writing
1. Provide `[Open handoff](computer://...)` link
2. Append Activity Log row noting the handoff was written
3. If today's daily note exists, append to its `## Captures` section: `- [[<MM-DD-YY>-<slug>]] -- handoff`

## Don't
- Don't dump the entire conversation - the handoff is a summary, not a transcript
- Don't skip the `Recommended first move` - that's the highest-value field
- Don't write a handoff if the session was trivial (under ~5 substantive turns)