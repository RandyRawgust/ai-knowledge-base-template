---
name: forge
description: Mine session history (00 - Chats/, daily notes, brainstorms) for prompting patterns that recur 3+ times across separate sessions. Propose them as new skills, rules, or specialists. Use when Andy says forge, mine the sessions, what patterns am I repeating, find skill candidates, what should be a skill.
---

# Forge

Cross-session pattern detector. Scans Andy's recent session history for patterns that have recurred enough to deserve promotion into a skill, rule, or specialist. Inspired by the FORGE archetype from the /goal video — the system-level version of the TCE evolution rule (add a symbol when it's been explained 3+ times).

## When to use
Triggers: `forge`, `mine the sessions`, `what patterns am I repeating`, `find skill candidates`, `what should be a skill`, `promote a pattern`.

Best run after a substantive working week, or before a quarterly drift audit. The /retro skill captures lessons from ONE session; /forge looks ACROSS sessions.

## Load
- `03 - Skills & Rules/Rules/engineering-doctrine.md` - research-first habits
- `00 - Chats/` - session summaries (not full transcripts — those are too noisy)
- `00 - Chats/brainstorms/` - past brainstorms
- `00 - Chats/handoffs/` - past handoff notes
- `01 - Daily Notes/` - last 30 days
- `03 - Skills & Rules/Agents/Activity Log.md` - last ~50 rows
- Current skills list at `.claude/skills/` (don't re-propose what exists)

## Run

### Phase 0 — Survey
Walk the source corpus. For each chat / brainstorm / daily note / activity row, extract: what task was being done, what instructions Andy gave repeatedly, what corrections he made, what manual steps recurred.

### Phase 1 — Pattern detection
Cluster by similarity. A pattern qualifies as a candidate when:
- It appears in ≥3 separate sessions (different days, different contexts)
- It involves a workflow that took multiple turns to describe
- Andy's correction pattern is similar across the instances
- A skill could meaningfully wrap it (not just trivial 1-line ops)

### Phase 2 — Propose

Group candidates by promotion target:

| Promotion | When |
|---|---|
| **New skill** | The pattern is invocable via a trigger phrase + has a clear inputs→outputs shape |
| **New rule** | The pattern is a recurring habit / convention (not invocation-shaped) |
| **New specialist** | The pattern has enough scope + judgment to warrant its own agent |
| **Extension to existing skill/specialist** | The pattern is a feature gap in something we already have |
| **No promotion** | Pattern recurs but doesn't earn a slot (under 3 hits, or pattern is too narrow) |

## Output

Write a forge report to `01 - Daily Notes/<YYYY-MM-DD> - Forge Report.md`:

```markdown
---
type: forge-report
created: <MM-DD-YY>
sessions_scanned: <count>
candidates_found: <count>
candidates_proposed: <count>
tags: [forge, doctrine-evolution]
---

# Forge Report -- <MM-DD-YY>

## Candidates proposed
| Pattern | Recurrence | Promotion target | Notes |
|---|---|---|---|
| <one-line description> | <N sessions> | new skill /<name> | <why> |

## Candidates rejected (under threshold)
- <pattern>: only <N> hits, watch for more

## Recommended next action
- <which candidate to build first, why>
```

## After
1. Surface the top 1-3 candidates with concrete proposals for what they'd look like
2. Don't auto-create the skill/rule/specialist — Andy approves the promotion
3. Append Activity Log row
4. If approved, hand off to the relevant creator skill (`/specialist-creator` for specialists, direct edits to `setup-claude-skills.ps1` for new skills, direct edits to `Rules/` for new rules)

## Don't
- Don't propose patterns that already exist (re-check the registry before reporting)
- Don't propose anything that recurred only in one mega-session — that's narrowness, not pattern strength
- Don't auto-promote — promotion is Andy's choice, you propose
- Don't include the full source quotes — distill to the pattern, link to source