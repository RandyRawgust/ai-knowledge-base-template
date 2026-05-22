---
type: rule
created: 05-17-26
kind: style
applies_to: [all-agents]
tags: [rule, style, transparency, status-flip, dashboard]
---

# Style — Announce Role

**Law for all conversations in this vault.** Per Andy (05-18-26): the frontmatter update is **absolute** — every turn, no exceptions. The header and footer are required whenever the response is long enough to warrant them. Andy always wants to know who and what is active.

Three outputs of one protocol. Andy can see at a glance: who's working, what skill/playbook they're using, what got changed, and when it happened — both inside the conversation and on the Obsidian Dashboard.

## When this rule fires

| Turn type | Frontmatter flip? | Header? | Footer? |
|---|---|---|---|
| Constructive work (file creates/edits, multi-step task) | **Always** | **Always** | **Always** (if any file was touched) |
| Audit, research, summary (reads + analysis, no files edited) | **Always** | **Always** | No (read-only) |
| Substantive question / explanation (≥ ~3 sentences or required tool use) | **Always** | **Always** | No (read-only) |
| Trivial reply ("got it", "thanks", yes/no confirm, < ~3 sentences, no tool use) | **Always** | Skip | Skip |

**The frontmatter flip is non-negotiable on every turn**, including trivial ones — set `status: active` at start, `last_active: <YYYY-MM-DD HH:mm>` , `current_task:` (even for "responding to confirmation"), then flip `status: idle` at end. If you don't know which agent is on duty, route via [[Orchestrator]] and flip Orchestrator's frontmatter.

The header/footer threshold is "long enough" — interpret generously. Over-announcing is fine; under-announcing hides drift.

## The protocol

### Step 1 — On constructive turn start (FIRST action)

Before any other tool use:

1. **Flip own frontmatter to active.** Open the agent's `.md` file (e.g., `03 - Skills & Rules/Agents/Builder.md` or `03 - Skills & Rules/Agents/Specialists/<name>.md`). Set:
   - `status: active`
   - `current_task: <one-line description of what you're about to do>`
   - `last_active: <YYYY-MM-DD HH:mm>` (24-hour, local time; this is the **one frontmatter exception** to the doctrine's `MM-DD-YY` rule — sort-order requirement for Dataview)
2. **Emit transparency header** as the first line of the response.
3. If a specialist is active alongside the dept head: flip both files' frontmatter.

### Step 2 — Do the work

Follow the named playbook (per [[engineering-doctrine]] routing table). Use whichever tools the work requires.

### Step 3 — On turn end (LAST action)

After all work is done:

1. **Emit transparency footer** if any files were created or edited this turn. Skip if read-only.
2. **Flip own frontmatter to idle.** Reopen the agent's `.md` file. Set:
   - `status: idle`
   - `current_task: ` (cleared / blank)
   - `last_active:` keep the same start-of-turn timestamp (don't overwrite — it's "last seen working" not "last completed")
3. If a specialist was active, flip its file too.

## Header format

```
🟢 **<Role>** · skill: `/<skill-or-"none">` · playbook: `<playbook-or-"no playbook">`
```

When a dept head + specialist pair is active:

```
🟢 **<DeptHead> + <specialist-name>** · skill: `/<skill>` · playbook: `<playbook>`
```

### Role colors

| Agent | Emoji | Hex |
|---|---|---|
| Orchestrator | 🟦 | (blue square — front-door router) |
| Builder | 🟢 | (green — creator) |
| Writer | 🟣 | (purple — `#9b59b6`, matches frontmatter) |
| Archivist | 🟡 | (yellow — index/catalog) |
| Auditor | 🔴 | (red — health/alert) |

Specialists inherit the parent's color: a Writer specialist still shows 🟣.

### Skill notation

- Slash-command skill active: `skill: /brainstorm`
- Multiple skills: `skill: /lesson-content-writer + /deck-builder`
- No skill, doctrine-direct work: `skill: none`

### Playbook notation

- Active playbook: `playbook: playbook-request`
- No playbook applies (trivial/single-file/conversation): `playbook: no playbook`
- Multiple playbooks (rare): list comma-separated

## Footer format

```
— Touched: <file1>, <file2>, ... (with brief annotation if needed)
```

Examples:

```
— Touched: brainstormer.md (new), Writer.md (delegates_to), CLAUDE.md (decision table)
```

```
— Touched: 22 - Scripts/README.md, vault-index.canvas
```

```
— Touched: superseded-infra.md (registry row flipped), drift-watcher.md (heuristic rewrite)
```

### What counts as "touched"

- **Yes:** files created, edited, or deleted via Write/Edit/MultiEdit/bash
- **Yes:** scheduled tasks updated via `mcp__scheduled-tasks__update_scheduled_task`
- **No:** files read for context
- **No:** the agent's own frontmatter status-flip edits (they'd appear on every constructive turn and add noise — they're implied by the header)

Use relative paths from vault root. If a file is outside the vault (e.g., `E:\Projects\Courses\fundamentals-of-coding\02-...html`), include the absolute path.

## Examples

### Constructive build

```
🟢 **Builder** · skill: none · playbook: `playbook-request`

[response body — research, builds files, runs tools]

— Touched: brainstormer.md (new), Writer.md (delegates_to), CLAUDE.md (decision table)
```

### Specialist invocation

```
🟣 **Writer + lesson-writer** · skill: `/lesson-content-writer` · playbook: `playbook-request`

[response body — builds the lesson]

— Touched: 02-files-paths-and-vs-code.html (new), 02-files-paths-and-vs-code.md (updated)
```

### Audit pass

```
🔴 **Auditor + drift-watcher** · skill: none · playbook: `playbook-refresh`

[response body — survey + findings]
```

(No footer — audit pass was read-only.)

### Meta-conversation

```
🟦 **Orchestrator** · skill: none · playbook: `no playbook`

[short conversational reply]
```

(No footer — read-only / chat.)

### Trivial turn

```
Got it.
```

(No header, no footer in the chat — but frontmatter still flips active→idle silently. The Dashboard must always reflect reality.)

## Edge cases

### Mid-session role switch

If the agent realizes mid-turn it should be a different role (e.g., started as Writer but the work is structural and should be Builder), update the header in-line and flip frontmatter for both agents (set the original to idle, set the new one to active). Note the switch:

```
🟢 **Builder** · skill: none · playbook: `playbook-request`  *(switched from Writer — work is structural)*
```

### Session ends mid-work

If the conversation cuts off (context limit, user leaves), the agent's `status: active` will be stuck. The [[06 - Scheduled Tasks/weekly-summarizer|weekly-summarizer]] self-cleanup step (Sundays 8 AM) catches agents stuck `active` for >24 hours and flips them to idle. Worst-case staleness: one week.

### Multiple sub-agents in one turn

When a parent dispatches multiple sub-agents (e.g., parallel audit + build), each sub-agent that runs should flip its own frontmatter. The parent's header lists the lead agent; the footer lists files touched by all.

## Trivial-turn handling — the gray zone

Some turns are genuinely brief. The split rule:

- **Frontmatter flip:** always. No gray zone. Even "got it" flips active→idle so the Dashboard never lies.
- **Header/footer:** apply when the response is "long enough" — substantive question, multi-sentence explanation, anything requiring research or tool use. Skip only for true one-liners (acknowledgments, yes/no, "thanks").

When in doubt on header/footer: include them. The cost of over-announcing is one extra line; the cost of under-announcing is invisible drift. drift-watcher flags both missing headers on substantive turns AND missing frontmatter flips on any turn.

## Why this exists

Three problems this rule solves:

1. **Conversation transparency.** Andy can see which agent + skill + playbook is running without having to ask. Surfaces drift (e.g., "Builder should be using `playbook-request` here but isn't").
2. **Dashboard accuracy.** Obsidian's Dataview queries over agent frontmatter actually show real-time status. No more all-idle dashboard.
3. **Change audit trail.** The footer is a per-turn diff summary — easy to scan a chat and see what changed without scrolling through every tool call.

Without this rule, all three signals are missing. The Dashboard becomes decoration; agents work invisibly; drift accumulates.

## Related

- [[engineering-doctrine]] — keystone rule; the playbook routing table this rule surfaces
- [[playbook-request]], [[playbook-refresh]], [[playbook-retro]] — the playbooks themselves
- [[style-no-sycophancy]], [[style-concise]] — sibling style rules
- [[Dashboard]] — where the status frontmatter shows up live
- [[06 - Scheduled Tasks/weekly-summarizer]] — the stale-active recovery mechanism
