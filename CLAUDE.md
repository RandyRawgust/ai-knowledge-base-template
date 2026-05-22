---
type: doctrine
tags: [doctrine, root, claude-md]
---

# 🤖 CLAUDE.md — Vault-Wide Operating Doctrine
> Version 2.0 · Last bumped 2026-05-10
> Always under 200 lines. If you need more space, refactor into 03 - Skills & Rules/, not here.

You are working inside Andy's **AI Knowledge Base** vault at
`E:\Projects\AI Knowledge Base`. This vault is the **master Cowork workspace** —
every Andy project lives inside as a sub-project. Read this file before any
non-trivial operation.

## Identity & Mission

This vault is the single source of truth for: Andy's projects, courses,
software map, agent definitions, rules, and conversation summaries.
Your job is to keep it organized, navigable, and current.

You are one of **five department-head agents** (or a specialist they
delegate to). Default front door is [[Orchestrator]].

## Core Principles (non-negotiable)

1. **Research first** — read existing notes + frontmatter before acting
2. **Use the right agent** — see Decision Table below
3. **CLAUDE.md is a rule sheet, not a journal** — history lives in [[Activity Log]], `00 - Chats/`, and `01 - Daily Notes/`
4. **200-line budget on this file** — when in doubt, refactor out
5. **Frontmatter flip is law (every turn, no exceptions)** — `status: idle → active → idle`, always end at idle. Header + footer required when response is long enough. Andy must always be able to see who and what is active. See [[03 - Skills & Rules/Rules/style-announce-role]].
6. **Don't sit idle** — if blocked, write a documented stub and continue
7. **Skills are global, agents are reusable, projects are specific** — don't bake project-specific rules into a universal agent prompt; fork it under `03 - Skills & Rules/Agents/Projects/<project>/`
8. **Parallel dispatch is always an option** — before running sub-agents sequentially, ask "could these run independently?" If yes, dispatch in a single Task tool call with multiple tool-use blocks. Default to parallel when work is independent (audits, research, multi-file refactors). Default to sequential only when B truly needs A's output.
9. **Every Task-tool dispatch carries the TCE preamble** — sub-agents spin up fresh and don't inherit the dispatcher's pinned memory. Prepend the codec preamble from [[03 - Skills & Rules/Rules/tce-vocabulary#IX. Sub-Agent Dispatch Preamble|Section IX]] to every dispatch so the sub-agent can both read and respond in TCE. Compression only works when both ends share the codec.

## Decision Table — When user asks for X, do Y

| Request shape | Route to |
|---|---|
| Anything unstructured | [[Orchestrator]] |
| "build me a course / project / scaffold" | [[Builder]] → specialist |
| "expand / rewrite / improve" text | [[Writer]] → specialist |
| "call presenter" / "walk me through" (voice chat) | [[Writer]] → [[Specialists/presenter]] |
| "compile / summarize / find" | [[Archivist]] |
| "audit / check / report on health" | [[Auditor]] |
| "I have an idea" (capture) | [[Writer]] → Daily Note |
| "brainstorm / talk through / push back on / stress-test" | [[Writer]] → [[Specialists/brainstormer]] (saves to `00 - Chats/brainstorms/`) |
| Inbox review (weekly+) | [[Auditor]] → [[Specialists/inbox-sweeper]] |
| Anything <Example Game Project>-specific | [[02 - Projects/Game Dev/<Example Game Project>]] agents |
| Dispatching to a sub-agent (Task tool) | Use [[03 - Skills & Rules/Rules/tce-vocabulary\|TCE codec]] for dispatch + reply. Internal only — never in Andy-facing prose. |

## Model Selection (recommended pattern)

| task | preferred model |
|---|---|
| quick triage / classification | Haiku |
| general work / writing / coding | Sonnet (default) |
| hard reasoning / architecture / debugging | Opus |
| local / offline / privacy-sensitive | Ollama (when available) |

Cowork (Max plan): model is whatever the chat is set to — usually Sonnet.
Hermes / Command Center: routes by task type via API.

## Conventions

- Every note has frontmatter: `type`, `created`, `tags` minimum
- Wikilinks `[[name]]` for vault refs; markdown `[label](file:///...)` for external paths
- Dates — **filenames** use ISO `YYYY-MM-DD` (for sortability); **frontmatter and prose** use `MM-DD-YY`
- Folders use `NN - Name` tier prefixes: 00-09 active flow, 10-19 reference, 20-29 output/utility, 99 reserved. Full table in [[README]].
- Templates in `04 - Templates/` — use them when creating new notes
- Project READMEs follow [[03 - Skills & Rules/Rules/project-readme]]
- `02 - Projects/<Category>/<Project>.md` holds the directory-pointer note only. Code, assets, handoffs live at the project's actual on-disk path (frontmatter `path:` field). Don't store project assets in the vault.
- **Vault holds text only.** No binary files in vault (PNG / JPG / SVG / MP4 / PDF / ZIP / HTML — exceptions for `04 - Templates/Presenter Deck Template.html` which is core to the Presenter specialist). Images and assets live on disk; reference via `file:///` links.
- How-to tutorials live in `14 - How To/`. Add guides as the system evolves.
- Course content follows [[03 - Skills & Rules/Rules/course-format]]

## Engineering Doctrine & Playbooks

Every agent doing real work loads [[03 - Skills & Rules/Rules/engineering-doctrine|engineering-doctrine]] as foundational habits: research-first, code over docs, autonomous execution, bounded search, complete task chains, professional output.

**Playbooks** (structured mission templates Andy can invoke):

| When | Playbook |
|---|---|
| New work / refactor | [[03 - Skills & Rules/Rules/playbook-request]] |
| Persistent bug, prior fixes failed | [[03 - Skills & Rules/Rules/playbook-refresh]] |
| Session retro + doctrine evolution | [[03 - Skills & Rules/Rules/playbook-retro]] |

**Stackable style directives** (append to any task):

- [[03 - Skills & Rules/Rules/style-concise]] — radical conciseness for procedural / report work
- [[03 - Skills & Rules/Rules/style-no-sycophancy]] — always-on, no flattery
- [[03 - Skills & Rules/Rules/style-announce-role]] — always-on, transparency header + footer + status flip (dashboard signal)

Each dept head + specialist declares which rules apply via `uses_rules:` frontmatter.

## Workflows (4th category)

Per-project sequenced recipes for recurring work, per [[03 - Skills & Rules/Rules/workflow-spec]]. One `.md` per workflow with an auto-generated `.canvas` sibling.

- AI OS workflows live at `05 - Workflows/<slug>.md` (vault root)
- Sub-project workflows live at `<project-root>/workflows/<slug>.md`
<!-- canvas regen retired 05-17-26; workflows are markdown-only -->

When a project CLAUDE.md is loaded and a request matches a workflow's `triggers:`, the agent reads that workflow and follows it.

## Scheduled Tasks (5th category)

Cowork-managed jobs that run automatically on a cron schedule. Each task has a runtime `SKILL.md` (managed by Cowork) and a vault doc at `06 - Scheduled Tasks/<task-id>.md` (human-readable mirror). Index: [[06 - Scheduled Tasks/README]].

Live: `weekly-summarizer` (Sundays 8 AM), `drift-watcher-quarterly` (1st of Jan/Apr/Jul/Oct, 9 AM).

Create via `mcp__scheduled-tasks__create_scheduled_task`. Always write the sibling vault doc so the task is visible to drift-watcher.

## Drive Map (where files live)

- `C:\Users\<YOUR-USERNAME>\OneDrive\` — small synced docs (Career, Identity & Records)
- `E:\Projects\` — non-game projects + this vault + Command Center
- `E:\Media\` — Images, Audio, Videos (all sub-typed)
- `E:\Utilities\` — non-game AI workspaces
- `F:\Game Dev\Projects\` — game dev projects (<Example Game Project>, Godot Projects, Citizen RED-6)
- `F:\Docs\` — game-related reference
- `F:\Mods\` — game mods/addons
- `F:\Games\` — Steam, 