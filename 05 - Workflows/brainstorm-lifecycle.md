---
type: workflow
project: AI-OS-Setup
name: brainstorm-lifecycle
status: active
created: 2026-05-18
updated: 2026-05-18
agents: [Writer, Specialists/brainstormer]
skills: [brainstorm]
triggers: ["start the brainstorm lifecycle", "carry this brainstorm forward", "refine the chat brainstorm", "where does this brainstorm go"]
tags: [workflow, brainstorm, capture, lifecycle, chat-bridge]
---

# Workflow — Brainstorm Lifecycle (Chat → Cowork → Build)

**When to invoke:** any idea worth pushing on. The lifecycle is the canonical path from "I had a thought" to "this is a real project."

The point: ideas are most valuable when they're fluid. Phone Chat captures the spark; Cowork's brainstormer specialist refines it; the Builder turns the survivors into projects. Each stage strips away ideas that can't earn their keep.

## Stage 1 — Capture in Chat (web or phone)

**Where:** Claude.ai Chat, ideally with a **"Brainstorming"** Project configured per [[../03 - Skills & Rules/Rules/chat-vault-bridge|chat-vault-bridge]] (optional but recommended — saves you from re-explaining the format every session).

**Trigger:** Andy says "brainstorm this" (or any brainstormer trigger phrase) inside Chat.

**Behavior** (per [[../03 - Skills & Rules/Agents/Specialists/brainstormer|brainstormer specialist]] doctrine):

1. Three-phase shape: surface (2-5 turns) → push (3-8 turns) → land (1-3 turns)
2. One question at a time. No flattery.
3. At wrap, Chat outputs the brainstorm in the canonical markdown format from [[../03 - Skills & Rules/Rules/chat-vault-bridge|chat-vault-bridge]] — frontmatter + TL;DR + conversation + threads + next — inside a fenced code block so Andy can copy in one motion.
4. Andy copies the block, creates `00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md` in the vault, pastes, saves.

Phone-friendly. Voice-friendly. Pure manual capture — no scripts, no Connectors, no auto-sync. The one-copy-paste step is the buffer between Chat's draft and the vault's authoritative state.

## Stage 2 — Refine in Cowork

**Where:** Cowork (desktop), in the main vault.

**Trigger:** Andy says any of:
- `/brainstorm <topic>` (slash command — fresh session, no Stage 1)
- "let's refine the X brainstorm" (after Andy has manually pasted a Stage 1 capture)
- "carry this brainstorm forward"

**Behavior:**

1. The Cowork brainstormer reads the Stage 1 file (if one exists) directly from `00 - Chats/brainstorms/`. No script step needed — the brainstorm is just a vault file. If Andy referenced topics or sources in the Stage 1 brainstorm and they're not in the vault yet, the brainstormer can offer to stub them in `10 - Topics/` and `11 - Sources/` as part of the refinement.
2. Invoke the [[../03 - Skills & Rules/Agents/Specialists/brainstormer|brainstormer specialist]] (via `/brainstorm` skill). The Cowork brainstormer has full vault access — it can read the Stage 1 brainstorm, related topic stubs, prior brainstorms on the same theme, and project pointer notes.
3. Brainstormer pushes the idea further with vault context the phone Chat didn't have:
   - "This rhymes with [[X brainstorm from two weeks ago]] — combine or separate?"
   - "Topic [[Y]] already covers half of this — is the rest worth a new project?"
   - "Source [[Z]] you collected last month addresses the open question you raised."
4. Stage 2 outputs are appended to the original brainstorm note OR forked into a new note (`<MM-DD-YY>-<slug>-stage2.md`). Andy decides.
5. Land at one of: build-now / save-for-later / not-pursuing / duplicate.

## Stage 3 — Build (optional, only for build-now outcomes)

**Where:** Cowork, in the relevant project folder (existing or new).

**Trigger:** Stage 2 landed at "build-now." Andy says any of:
- "scaffold this as a project"
- "let's start building this"
- "make this real"

**Behavior:**

1. Builder dept head takes over (`@Builder` or just keep going — Cowork routes naturally).
2. Builder invokes [[../03 - Skills & Rules/Agents/Specialists/project-scaffolder|project-scaffolder]] via `/project-scaffolder`.
3. Project scaffold uses the Stage 1+2 brainstorm as its initial README + ROADMAP material.
4. Brainstorm note gets a `handoff:` frontmatter pointing to the new project; the brainstorm is now the project's origin story.

## State diagram

```
[idea] ──"brainstorm this"──► Stage 1: Chat brainstorm
                              (output as paste-ready markdown)
                                       │
                                       │ copy/paste once to
                                       │ 00 - Chats/brainstorms/
                                       ▼
                                  [vault file exists]
                                       │
                                       │ "refine X" / /brainstorm
                                       ▼
                              Stage 2: Cowork brainstormer refines
                                       │
              ┌────────────────────────┼────────────────────────┐
              ▼                        ▼                        ▼
       build-now              save-for-later             not-pursuing
              │                        │                  / duplicate
              │                        │                        │
              ▼                        ▼                        ▼
       Stage 3: Build         (stays in brainstorms)    (link to existing /
       project scaffolds       periodic /forge sweep    delete after 6 mo)
       with brainstorm as       can resurface it later
       origin story
```

## Anti-patterns

- **Don't skip Stage 2.** Phone Chat captures are inherently shallow — they don't have vault context. Going from Stage 1 directly to Stage 3 means building on an unrefined idea.
- **Don't over-refine.** Stage 2 isn't a planning session, it's a refinement pass. If Stage 2 starts feeling like Stage 3, hand off explicitly.
- **Don't auto-promote.** Andy decides when a brainstorm moves between stages. Skills propose; he approves.
- **Don't lose the threads-worth-pulling.** Each stage's "Threads" list compounds. By Stage 3, you have a backlog of follow-ups for related work.

## See also

- [[../03 - Skills & Rules/Rules/chat-vault-bridge|chat-vault-bridge]] — the manual capture format spec (what Chat outputs for paste)
- [[../03 - Skills & Rules/Agents/Specialists/brainstormer|brainstormer specialist]] — what runs at both Stage 1 (via Project custom-instructions) and Stage 2 (via Cowork)
- [[../03 - Skills & Rules/Skills/brainstorm|/brainstorm skill]] — the Cowork invocation surface
- [[../14 - How To/guides/04-brainstorm-to-project|04-brainstorm-to-project]] — older guide, covers similar ground
