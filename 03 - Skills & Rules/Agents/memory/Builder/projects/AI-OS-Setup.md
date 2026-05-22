---
type: memory-project
agent: Builder
project: AI-OS-Setup
created: 2026-05-10
last_consolidated: 2026-05-13
---

# Builder memory — AI-OS-Setup

What I know specifically about this project.

## What I've shipped

- **Vault skeleton** (Phase 2) — 02 - Projects/, 10 - Topics/, 13 - Courses/, 01 - Daily Notes/, 00 - Chats/, 11 - Sources/, 12 - Software Map/, 03 - Skills & Rules/, 04 - Templates/, 20 - Decks/. (Original `_System Map.canvas` retired 05-17-26 → replaced by `14 - How To/system-overview.canvas`.)
- **Skills & Rules subsystem** (Phase 3, expanded through 05-18-26) — 18 custom slash-command Skills (project-scaffolder, brainstorm, course-builder, lesson-content-writer, deck-builder, drift-fix, git-bootstrap, commit-message-writer, daily-note-writer, workflow-author, specialist-creator, handoff, audit, sweep-inbox, compile-topic, retro, forge, revive) + 6 Anthropic-provided (docx/pdf/pptx/xlsx/schedule/skill-creator). 15 doctrine Rules including the TCE compression codec (added 05-18-26). Agents: 5 dept heads + 11 specialists (all built) + TerraWatt-specific roster lives under that project.
- **Fundamentals of Coding** (Phase 3) — course scaffold + lesson 01 HTML interactive.
- **Command Center v1/v2/v3** (Phase 4-6-7, retired Phase 10 on 05-17-26) — single-file Python FastAPI dashboard. Grew, got voice features, stripped back to dashboard-only, then superseded entirely by the native Obsidian canvas (`[[_Command Center.canvas]]`). Historical detail preserved in the registry: [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra]].
- **Presenter specialist** (Phase 7) — Writer-class specialist with HTML deck template.
- **Memory layer** (Phase 8 — current) — seeding the empty memory files.

## Command Center architecture notes (HISTORICAL — Python CC was retired 05-17-26)

> The notes below describe the retired Python implementation. The current Canvas Command Center is markdown-native and has no architecture in this sense — it composes Dataview queries inside an Obsidian canvas. Kept here only for archaeological reference.

- Single file at `E:\Projects\Command Center\command_center.py`. Earlier canonical copy lived in `~\Documents\command_center.py` (also retired).
- FastAPI + uvicorn + psutil + pyyaml. No frontend framework.
- Embedded HTML/CSS/JS in a single `HTML = r"""..."""` constant.
- Polled `/state` every 2s for dashboard refresh.
- `/system/status` every 5s for header pills.
- Ollama integration via stdlib urllib (no httpx).
- Three GIFs (snake idle/strike/move) base64-inlined into the HTML.
- Logo: HTML `<h1>` with Black Ops One Google Font + skewX -12° + 8s rainbow gradient cycle + scanline mask.

## Things to NOT rebuild

- War Room voice/TTS/STT path — stripped in Phase 7, was an audio rabbit hole.
- Task Console chat tab — stripped Phase 7.
- /chat/voice, /chat/call, /tts endpoints — stripped Phase 7.

## Open building threads

- **Phase 9** — scheduled automation. Sunday weekly-summarizer + quarterly drift-watcher.
- **Repos panel rethink** — see Phase 8.5 plan: GitHub repos with agent-color folder highlights.
- **Course lessons 02-12** — only stubs exist. Build as Andy completes prior weeks.
