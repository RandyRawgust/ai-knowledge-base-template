---
type: guide
order: 1
created: 05-17-26
tags: [how-to, system, overview, doctrine]
---

# How the System Works

The AI Knowledge Base is a markdown brain. It points at everything else on Andy's disk — projects, courses, software, media — and adds a thin layer of metadata, context, and routing on top. The vault doesn't store the work; it organizes thinking *about* the work.

## What lives where

| Layer | Location | Holds |
|---|---|---|
| **Vault (this file system)** | `E:\Projects\AI Knowledge Base\` | Markdown, canvas, CSS, code-config. Text only — no binaries. |
| **Project files** | `E:\Projects\<name>\` or `F:\Game Dev\Projects\<name>\` | Code, assets, exports, working files. The actual project content. |
| **Media** | `E:\Media\{Images,Audio,Videos}\` | Photo/audio/video libraries, generated and personal. |
| **Reference docs** | `F:\Docs\` | Game-related reference. |
| **Archive / untouched** | `G:\` | DJ Music, Jellyfin video — explicitly hands-off. |

Rule: if it's a `.png`, `.jpg`, `.pdf`, `.mp4`, `.zip`, or any other binary — it does **not** live in the vault. Reference it with a `file:///` link to wherever on disk it actually lives.

## The tier system

Top-level folders are numbered. The number's first digit signals the tier; the second digit is just a sort position within tier.

- **00-09 — Active flow.** Daily-driver folders. Touched constantly. Capture surfaces, project notes, working doctrine.
- **10-19 — Reference / knowledge.** Read more than written. Topic graph, sources, courses, this How-To.
- **20-29 — Output / utility.** Generated content and creative workspace. Decks, drawings.
- **99 — Reserved.** Archive slot; empty by default.

Dotfolders (`.claude/`, `.claude-plugin/`, `.obsidian/`, `.git/`) are vault infrastructure — hidden from the sidebar by Obsidian's default convention. They're not content; they're plumbing. Runnable scripts live in the visible `22 - Scripts/` folder so they're discoverable in Obsidian + invocable from integrated PowerShell.

## The five operational layers

1. **Vault** — markdown brain (this folder)
2. **File system** — code, assets, drives outside the vault
3. **AI tools** — Cowork (chat surface), Claude Code (CLI), Claude Desktop, Cursor, Codex
4. **Agents** — five department heads (Orchestrator, Builder, Writer, Archivist, Auditor) and their delegated specialists, each with per-agent memory
5. **Automation** — Cowork scheduled tasks (weekly-summarizer, drift-watcher-quarterly), Windows Task Scheduler (inbox sort)

## Agents

The five dept heads sit in `03 - Skills & Rules/Agents/` and are mirrored as native sub-agents in `.claude/agents/` so Claude Code can invoke them by `@name`. Each has a description, a model (Opus for routing/audit, Sonnet for build/write), and a memory load protocol (pinned + universal + recent + per-project).

Default front door is `@Orchestrator`. It routes:

- Building → `@Builder` → specialist
- Writing / improving text → `@Writer` → specialist (or `@Presenter` for voice convos)
- Compiling / summarizing / finding → `@Archivist`
- Auditing / health checks → `@Auditor`

Specialists are dept-head delegates. Two are promoted to `.claude/agents/` because they run as scheduled tasks: `weekly-summarizer` and `drift-watcher-quarterly`. The rest stay as in-vault references their dept head reads when needed.

## Rules, Workflows, Scheduled Tasks

Three procedure surfaces, sibling concepts:

- **Rules** (`03 - Skills & Rules/Rules/`) — durable doctrine. Things every agent loads as baseline habits. Engineering doctrine, playbooks, style directives, feature registry. Includes the [[../../03 - Skills %26 Rules/Rules/tce-vocabulary|TCE vocabulary codec]] — the alphabet below rules + playbooks, used for agent-to-agent dispatch compression.
- **Workflows** (`05 - Workflows/`) — sequenced recipes. Numbered steps with optional `[agent-name]` prefixes. Triggered by phrases an agent recognizes in a request. Markdown-only (no canvas siblings).
- **Scheduled Tasks** (`06 - Scheduled Tasks/`) — cron jobs. Cowork-managed; each task has a runtime SKILL.md and a vault-mirror doc.

## Doctrine evolved 05-18-26

Several pieces added today are worth knowing about:

- **CLAUDE.md Core Principles #8 + #9** — parallel-dispatch is always an option to consider; every Task-tool dispatch must carry the TCE preamble so sub-agents can read + respond in the codec.
- **[[../../03 - Skills %26 Rules/Agents/Auditor#Judge protocol cross-model verification|Auditor Judge protocol]]** — substantive audits dispatch a verifier sub-agent in a *different* language model before commit. Same-model self-review shares blind spots; cross-model judging breaks that symmetry.
- **`/loop` opt-in mode for drift-watcher** — see [[../../03 - Skills %26 Rules/Agents/Specialists/drift-watcher#Running on loop opt in during active sessions|drift-watcher]] for the canonical invocation. Continuous in-session drift correction; quarterly scheduled task stays as always-on fallback.
- **Dispatch protocol in [[../../03 - Skills %26 Rules/Rules/engineering-doctrine#Dispatch protocol task tool|engineering-doctrine]]** — mandatory parallel-check + preamble-check before every Task-tool dispatch.

## What NOT to do

- Don't store project files in the vault. Vault holds the note; disk holds the project.
- Don't put PNG / JPG / SVG / MP4 / PDF / HTML in the vault. Approved exception: `04 - Templates/Presenter Deck Template.html` (core to the Presenter specialist).
- Don't use kaomoji in agent text. They leak as garbled UTF-8 and add nothing.
- Don't edit `_System Map.canvas.bak` or any `*.canvas.bak` — they're tombstones, gitignored, slated for deletion.
- Don't bypass agents for vault-modifying work. The agent system writes the Activity Log; ad-hoc edits leak past auditing.

## See also

- [[04-brainstorm-to-project]] — the lifecycle from idea to active project
- [[CLAUDE]] — operating doctrine (rule sheet)
- [[5S_STANDARD]] — file standard + drive map
- [[README]] — folder table + tier scheme
- [[03 - Skills & Rules/README|Agent + rule registry]]
