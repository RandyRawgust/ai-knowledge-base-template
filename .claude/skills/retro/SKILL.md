---
name: retro
description: Invoke playbook-retro at session end to capture durable lessons and evolve the doctrine. Use when Andy says retro, do a retro, close the loop, what did we learn, end-of-session reflection.
---

# Retro

Runtime wrapper for [[03 - Skills & Rules/Rules/playbook-retro|playbook-retro]]. Three-phase metacognitive reflection on the session that just ended.

## When to use
Triggers: `retro`, `do a retro`, `close the loop`, `what did we learn`, `end-of-session reflection`, `session retro`, `debrief`.

## Load
- `03 - Skills & Rules/Rules/playbook-retro.md` - full doctrine (canonical source)
- `03 - Skills & Rules/Rules/engineering-doctrine.md` - where global lessons land
- `03 - Skills & Rules/Rules/vault-conventions.md` - where vault-specific lessons land
- Current session's Activity Log row(s) for context

## Run

Three phases per playbook-retro:

### Phase 0 - Session analysis
Walk every turn from initial request to now. Capture:
- **Successes** - what core patterns produced efficient, correct outcomes?
- **Failures & user corrections** - where did the approach fail? Pinpoint Andy's corrections.
- **Actionable lessons** - what's transferable to future sessions?

(Chat only, not in report yet.)

### Phase 1 - Lesson distillation
Filter ruthlessly. A lesson qualifies only if:
- Universal & reusable (not a one-off)
- Abstracted (general principle, not session-specific)
- High-impact (prevents failures or significantly improves efficiency)

Categorize each surviving lesson:
- **Global doctrine** -> `engineering-doctrine.md` or style/playbook rule
- **Vault doctrine** -> `vault-conventions.md` or `5S_STANDARD.md`
- **Agent-specific** -> the relevant agent's `.md` or its memory file

### Phase 2 - Apply
Edit the target doctrine file(s). Each edit is one durable lesson. Quote Andy's correction or paraphrase the trigger that surfaced the lesson.

## Output

Write a session retro to `00 - Chats/retros/<MM-DD-YY>-<slug>.md`:

```markdown
---
type: retro
created: <MM-DD-YY>
session_topic: <one-line>
lessons_landed: <count>
tags: [retro]
---

# Retro -- <topic>

## Successes
- <pattern that worked>

## Failures & corrections
- <what broke> -> <Andy's correction or the realization>

## Lessons landed
| Lesson | Type | File updated |
|---|---|---|
| <durable principle> | global / vault / agent | <path> |

## Lessons rejected (didn't pass the filter)
- <session-specific thing that's not worth doctrine>
```

## After
1. Append Activity Log row
2. Provide `[Open retro](computer://...)` link
3. If any doctrine file was edited, list the edits in the response

## Don't
- Don't land session-specific lessons as global doctrine - the filter exists for a reason
- Don't skip the rejected list - it's evidence the filter ran
- Don't run retro on trivial sessions (under ~5 substantive turns) - low signal