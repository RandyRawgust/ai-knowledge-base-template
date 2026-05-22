---
type: memory-project
agent: Orchestrator
project: AI-OS-Setup
created: 2026-05-10
last_consolidated: 2026-05-13
---

# Orchestrator memory — AI-OS-Setup

What I know specifically about this project. Loaded when working it.

## Phase tracker

Through Phase 7 done. Phase 8 (memory layer activation) in flight as of 2026-05-13. Phase 9 (scheduled automation) is next.

## Where work happens

- **This vault** (`E:\Projects\AI Knowledge Base`) — markdown layer, agent definitions, doctrine. The Canvas Command Center (`[[_Command Center.canvas]]`) lives here and is the live dashboard as of 05-17-26.
- **`E:\Projects\Command Center\`** — retired Python FastAPI dashboard (`command_center.py`, port 8080). Kept on disk as historical reference; superseded by the canvas.

## Routing patterns I've seen

- Andy starts with a casual ask, often without naming an agent. I route based on verb.
- "fix X" → diagnose first (often me), don't refactor.
- "build X" → Builder + relevant specialist.
- "review X" or "audit X" → Auditor + drift-watcher.
- "call presenter" in voice chat → Writer → Presenter (decks).
- Big multi-thread asks → I (Orchestrator) handle directly; specialists are too narrow.

## Frequent collaborators

- Andy + Cowork (this conversation flow) — most common.
- Andy + Claude voice chat with Presenter — for casual review.
- Andy + Claude Code CLI — for actual file work on his machine.
