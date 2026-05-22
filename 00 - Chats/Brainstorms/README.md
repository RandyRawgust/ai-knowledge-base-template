---
type: readme
folder: 00 - Chats/brainstorms
created: 05-17-26
tags: [readme, brainstorm, chats]
---

# Brainstorms

Saved transcripts from [[03 - Skills & Rules/Agents/Specialists/brainstormer|brainstormer]] sessions. Each file captures one conversation where a half-formed idea got pushed around. Three to twenty minutes typical. Phone or PC.

Brainstorms captured in Claude.ai Chat (web or phone) get manually pasted into this folder as `<MM-DD-YY>-<slug>.md`. Format spec lives in [[../../03 - Skills & Rules/Rules/chat-vault-bridge|chat-vault-bridge]].

## Files

```
00 - Chats/brainstorms/
├─ README.md                          ← this file
├─ <MM-DD-YY>-<slug>.md               ← one per brainstorm session
└─ ...
```

Filename format: `<MM-DD-YY>-<topic-slug>.md`. Slug is 2-4 lowercase-hyphenated words derived from the topic. If two brainstorms happen on the same day with the same topic kernel, the second gets a `-2` suffix.

## What's in each file

Per the brainstormer save protocol (see [[03 - Skills & Rules/Agents/Specialists/brainstormer|specialist doctrine]]):

- **Frontmatter** — `type: brainstorm`, `created`, `topic`, `outcome` (build-now | save-for-later | not-pursuing | duplicate), `handoff` link if any, `tags`
- **TL;DR** — one paragraph: idea, where it landed, why
- **Conversation** — compressed turns; the moves that mattered
- **Threads worth pulling** — open questions, adjacent ideas, vault things the brainstorm rhymed with
- **Next** — concrete action, or "save and forget"

## How to start one

Three ways:

| Surface | How |
|---|---|
| **Phone (Cowork chat)** | Type `/brainstorm` or just `let's brainstorm about <topic>` |
| **PC (Cowork chat)** | Same — `/brainstorm` or `@brainstormer` |
| **PC (Claude Code)** | `@brainstormer` (sub-agent invocation) |

Brainstormer will guide the conversation, then save at the end when you say wrap / done / save.

## Outcomes

Each brainstorm ends with one of:

| Outcome | Means |
|---|---|
| `build-now` | Worth pursuing immediately — hands off to `@Builder` via the [[14 - How To/guides/04-brainstorm-to-project\|brainstorm → project lifecycle]] |
| `save-for-later` | Worth kee