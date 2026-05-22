---
type: rule
created: 05-18-26
updated: 05-22-26
kind: capture-format
applies_to: [Writer, brainstormer]
tags: [rule, capture, brainstorm, manual]
---

# Chat → Vault Capture Format

Claude.ai Chat (web + mobile) has no filesystem access to the vault. So when you brainstorm in Chat, the output has to be **manually pasted** into a new file in `00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md`.

This rule specifies the exact markdown format Chat should output at the end of a brainstorm session, so the paste is one motion and the file is immediately vault-shaped.

(An earlier version of this doctrine described a GitHub-backed auto-sync via a separate capture repo. That approach was retired 05-22-26 in favor of manual capture — fewer moving parts, no Connector setup, no script to forget to run.)

## When this fires

At the **wrap** of a Chat brainstorm session — when Andy says "save," "wrap," "done," "good for now," or similar.

The brainstormer doctrine in [[../Agents/Specialists/brainstormer|brainstormer]] is what teaches Chat the three-phase shape. THIS rule is what teaches Chat the *output format* at the end.

## The output Chat produces

One markdown block, ready to copy:

```markdown
---
type: brainstorm
created: <MM-DD-YY>
captured_from: claude.ai-chat  # or "claude.ai-mobile"
topic: <one-line summary>
outcome: build-now | save-for-later | not-pursuing | duplicate
slug: <lowercase-hyphenated, 2-4 words>
sources_referenced: [<url or vault topic ref>, ...]
topics_referenced: [<topic-slug>, ...]
handoff: <link if handed off to a project, else empty>
tags: [brainstorm, from-chat]
---

# Brainstorm — <topic>

**Date:** <MM-DD-YY>  **Captured in:** Claude.ai Chat  **Outcome:** <outcome>

## TL;DR
One paragraph: what the idea was, where it landed, why.

## Conversation
> **Andy:** <opening prompt>
> **Claude:** <reply>
(compressed turns — favor distillation over transcription)

## Threads worth pulling
- <open question or adjacent idea>

## Sources referenced
- <URL> — <one-line what it was>
- <vault topic or note> — <how it informed the brainstorm>

## Next
- <concrete action if any>
```

## What Andy does with it

1. Copy the whole markdown block (Chat presents it inside a code fence so it's selectable).
2. In Obsidian or any editor, create a new file at `00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md`.
3. Paste. Save.
4. Cowork picks it up on the next session — the brainstormer specialist can then refine it (Stage 2 of [[../../05 - Workflows/brainstorm-lifecycle|brainstorm-lifecycle]]).

That's it. No sync script, no GitHub repo, no Connector setup.

## Setting up the Chat side (optional, recommended)

If Andy wants Chat to reliably output this format without re-explaining each time, set up a **Brainstorming** Project in Claude.ai (web or app):

- **Custom instructions** (paragraph that runs every chat in this Project):

  > "You are a brainstorming partner for Andy. Follow the three-phase shape from `brainstormer.md` — surface (2-5 turns) → push (3-8 turns) → land (1-3 turns). One question at a time. Push back instead of validating. When Andy says save/wrap/done, output the full brainstorm in the markdown format from `chat-vault-bridge.md` inside a fenced code block, ready for him to paste into `00 - Chats/brainstorms/`."

- **Project Knowledge uploads**: drop these vault files in:
  - `brainstormer.md` (the doctrine)
  - `style-no-sycophancy.md` (no-flattery rule)
  - `chat-vault-bridge.md` (this file — has the format spec)
  - `CLAUDE.md` (vault-wide doctrine for context)

No Connector needed. No write access to anything. Chat is purely a thinking partner that produces paste-ready output.

## Anti-patterns

- **Don't auto-paste.** This is intentionally manual — gives Andy a moment to skim the captured brainstorm before it lands in the vault. Catches the obvious "actually this was just venting, delete" cases before they pollute the vault.
- **Don't fight the format.** If Chat outputs something slightly different (e.g., missing a frontmatter field), fill it in during paste. Don't ask Chat to redo the whole brainstorm.
- **Don't paste without slug.** The slug determines the filename. If Chat didn't pick one, pick one yourself before saving.

## See also

- [[../Agents/Specialists/brainstormer|brainstormer specialist]] — the three-phase doctrine
- [[../../05 - Workflows/brainstorm-lifecycle|brainstorm-lifecycle workflow]] — Stage 1 (Chat) → Stage 2 (Cowork refine) → Stage 3 (Build)
- [[style-no-sycophancy]] — the no-flattery rule that makes brainstormer worth invoking
