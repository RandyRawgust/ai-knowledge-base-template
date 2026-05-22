---
type: rule
created: 2026-05-13
applies_to: [Orchestrator, Builder, Writer, Archivist, Auditor]
tags: [rule, memory, agent-protocol]
---

# Agent Memory Protocol

Every dept head has its own memory folder at `03 - Skills & Rules/Agents/memory/<DeptHead>/`. This rule defines what's in each file, when to read, when to write, and how decay works.

## Files per dept head

| File | Purpose | Decay |
|---|---|---|
| `universal.md` | Cross-project facts about Andy. Loaded every invocation, regardless of project. | Never; consolidated weekly by Auditor. |
| `pinned.md` | Explicitly-told "always remember" items. Things Andy said "remember this" about. | Never; never decays. |
| `recent.md` | Rolling 30-day conversation log — what the agent has done lately. | Auditor prunes >30 days each Sunday. |
| `projects/<slug>.md` | Project-specific facts. Loaded only when working on that project. | Never; consolidated weekly. |

## On invocation — read order

When a dept head is invoked, before forming a response, it reads:

1. **`pinned.md`** — always, first. These are non-negotiable directives.
2. **`universal.md`** — always, second. Background context about Andy.
3. **`projects/<active-project>.md`** — only if a project is in play (detected via cwd, first @-mention, or active session).
4. **`recent.md`** — only if continuity matters (e.g., user references "what we did yesterday").

Specialists do NOT have their own memory — they inherit from their parent dept head.

## During the session — what to capture

The agent watches for moments worth remembering:

- **Pin signals** — phrases like "always remember", "from now on", "I prefer X over Y" → append a line to `pinned.md`.
- **Project facts** — durable things specific to one project ("KerbGPT uses Llama 3.1") → append to `projects/<slug>.md`.
- **Universal facts** — durable things about Andy generally ("Andy is on Windows with a 4.4GB-RAM CPU-only machine") → append to `universal.md` (only if not already there).
- **Recent work** — what got done this session → append a one-liner to `recent.md` at session end.

Format for appended lines:

```markdown
- [YYYY-MM-DD] <durable fact in one sentence>
```

## Decay & consolidation

Run weekly by Auditor (or [[Specialists/weekly-summarizer]]):

1. Read each dept head's `recent.md`.
2. For entries older than 30 days:
   - If the entry repeats existing knowledge in `universal.md` or `projects/*.md`, drop it.
   - If it introduced a new durable fact, promote it to `universal.md` (or the right project file).
   - Otherwise let it fall off.
3. Trim `pinned.md` only if Andy explicitly says "stop remembering X".
4. Bump the `last_consolidated:` field in each file's frontmatter.

## File size discipline

- `pinned.md`: never more than 30 lines. If it grows, half of it isn't actually pinned — Auditor demotes the rest.
- `universal.md`: never more than 60 lines. Group facts by topic.
- `recent.md`: never more than 100 lines. Auditor truncates.
- `projects/<slug>.md`: project-by-project, no hard cap, but if it crosses 200 lines split by sub-topic.

## When the protocol is OFF

- One-shot questions where context doesn't matter (e.g., "what's the time")
- Diagnostic / debug sessions where Andy doesn't want history affecting the answer
- Andy says "fresh slate" or "no memory" at the start

## What this rule replaces / supersedes

This rule formalizes the memory architecture that was sketched in [[CLAUDE.md]]. CLAUDE.md still names WHICH files exist; this rule defines WHEN they're read, WHEN they're written, and HOW they decay.
