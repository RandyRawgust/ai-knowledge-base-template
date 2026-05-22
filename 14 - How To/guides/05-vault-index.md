---
type: guide
order: 3
created: 05-17-26
tags: [how-to, index, catalog, vault, doctrine]
---

# What Everything Is, and Why

A complete catalog of every named entity in the vault — every folder, root file, agent, specialist, rule, skill, workflow, and scheduled task — with a one-line "what it is" and a one-line "why it exists."

Use this when:
- You forgot what a thing does
- You're auditing the system and want a checklist of what should exist
- You're explaining the system to someone (or to future-you)
- You're looking for a doctrine file and don't remember exactly where it lives

The sibling canvas [[vault-index.canvas]] gives the visual grouping; this guide is the prose enumeration.

## Folders (top-level)

Tier prefixes per [[01-system-overview]]. Numbers signal tier — first digit is the tier (0-9 = active flow, 1 = reference, 2 = output/utility, 9 = archive).

### Tier 0 — Active flow

| Folder | What | Why |
|---|---|---|
| `00 - Chats/` | Summaries + handoffs from AI conversations; `brainstorms/` subfolder for [[brainstormer]] transcripts | Not full transcripts. Just durable artifacts — what was concluded, what to do next. |
| `01 - Daily Notes/` | One markdown per day, `YYYY-MM-DD.md` | Capture surface for ideas, top-3 items, anti-todo (what you actually got done). The "what happened" log. |
| `02 - Projects/` | Per-project directory-pointer notes grouped under category subfolders | The vault holds *notes about* projects, not project files. Each note's frontmatter `path:` points at the real on-disk location. |
| `03 - Skills & Rules/` | Agents, rules, playbooks, agent memory | The doctrine layer. Everything that defines *how* agents act. |
| `04 - Templates/` | Templater templates for Daily, Software, Project, Lesson, Chat, Presenter Deck | Drop-in skeletons. Don't type frontmatter by hand. |
| `05 - Workflows/` | Sequenced recipes for recurring multi-step work | When a procedure happens >2 times, codify it here so it's invocable by trigger phrase. |
| `06 - Scheduled Tasks/` | Vault-mirror docs for Cowork-managed cron jobs | Cowork runs them; this folder makes them discoverable in Obsidian + auditable by drift-watcher. |

### Tier 1 — Reference / knowledge

| Folder | What | Why |
|---|---|---|
| `10 - Topics/` | Karpathy-wiki style topic notes, subfoldered by domain (AI, etc.) | The conceptual graph. One note per concept. Wikilinks build connections. |
| `11 - Sources/` | Web Clipper destination — raw articles, images, PDFs | Inbox for things to read or reference. Some get promoted to Topics. |
| `12 - Software Map/` | One markdown per piece of software (Obsidian, Python, git, Godot, etc.) | The "what's installed and what does it do" graph. Projects link to the software they use; the graph view shows the dependency mesh. |
| `13 - Courses/` | Self-paced training trackers (`.md` only — HTML lessons live on disk per the course's `disk_path:` frontmatter) | Per CLAUDE.md the vault is text-only. Course content lives on disk; vault holds the tracker + reflections + Dataview progress queries. |
| `14 - How To/` | Tutorial canvases at root + `guides/` subfolder of explainer `.md` files | The "explain the system" layer. Canvases are the diagram; guides are the prose. |

### Tier 2 — Output / utility (extended)

| Folder | What | Why |
|---|---|---|
| `22 - Scripts/` | PowerShell + Python scripts for the AI OS / vault (setup, audit, hooks, git-bootstrap) | Runnable utilities that operate against the vault itself. Project-specific scripts live with the project, not here. README catalogs each script. |

### Tier 2 — Output / utility

| Folder | What | Why |
|---|---|---|
| `20 - Decks/` | HTML decks built by [[presenter]] during voice conversations | Persistent visual artifact from voice chats; the deck *is* the meeting notes. |
| `21 - Excalidraw/` | Hand-drawn whiteboards | Excalidraw markdown files (text + embedded JSON). The fastest way to externalize a half-formed idea. |

### Tier 9 — Archive

| Folder | What | Why |
|---|---|---|
| `99 - Archived/` | Retired stuff that's worth keeping for archaeology | When something gets killed but the history matters (e.g., `command-center-deploy.md`). Empty by default; populated as things retire. |

### Dotfolders (hidden infrastructure)

| Folder | What | Why |
|---|---|---|
| `.claude/` | Native Claude Code runtime — `agents/` (sub-agent definitions), `skills/` (slash commands), `settings.json` | Bridges the vault doctrine to Claude Code's actual primitives. `/agents`, `/mcp`, slash commands work because of this folder. |
| `.claude-plugin/` | `plugin.json` packaging the whole AI OS for `claude plugin install` | Portability. The vault can be installed on a fresh machine. |
| `.obsidian/` | Obsidian config + plugins + workspace state | Obsidian-side configuration. Don't edit by hand unless you know what you're doing. |
| `.git/` | Git repo metadata | Vault is on GitHub at `<YOUR-GH-HANDLE>/ai-knowledge-base` (private). |

## Root files

| File | What | Why |
|---|---|---|
| `CLAUDE.md` | Vault-wide operating doctrine (≤200 lines) | Read first by any agent doing non-trivial work. The decision table is here. |
| `README.md` | Vault index — folder table, doctrine pointers | First file a visitor reads. Glance at this to learn the system. |
| `ROADMAP.md` | Phased plan for the whole AI OS | Where the project is going. Re-read quarterly. |
| `5S_STANDARD.md` | File standard + naming conventions + audit cadence | The disk-side rules. Drive map. Where files belong. |
| `Dashboard.md` | Daily-driver Dataview page — active projects, agent status, scheduled tasks | The "what's happening right now" view. Auto-populates from frontmatter across the vault. |
| `Projects-Index.md` | Dataview-auto list of all projects | Generated from `02 - Projects/<Category>/*.md` frontmatter. Don't edit manually. |
| `_Command Center.canvas` | The live dashboard (canvas-based since 05-17-26) | Native Obsidian canvas composing Dataview-driven views. Replaces the retired Python `command_center.py`. |

## Agents

### Dept heads (5)

Live in `03 - Skills & Rules/Agents/`. Each is mirrored as a native sub-agent in `.claude/agents/`. Each has its own memory directory under `03 - Skills & Rules/Agents/memory/<DeptHead>/`.

| Agent | Model | What | Why |
|---|---|---|---|
| [[Orchestrator]] | Opus | Default front door; routes unstructured requests | Decides which dept head should handle a request. Reads the decision table. |
| [[Builder]] | Sonnet | Creates new things — projects, courses, scaffolds, decks, code | Most "make me X" requests land here. Delegates to specialists. |
| [[Writer]] | Sonnet | Improves existing text or captures new ideas | Lessons, READMEs, daily notes, brainstorms, voice-chat decks. |
| [[Archivist]] | Sonnet | Compiles, summarizes, indexes, finds | Cross-vault synthesis. The "what do we know about X" agent. |
| [[Auditor]] | Opus | Watches and reports on vault health | Drift detection, weekly recaps, structural audits. |

### Specialists (10)

Live in `03 - Skills & Rules/Agents/Specialists/`. Each delegates from a dept head. Two are promoted to `.claude/agents/` because they run as scheduled tasks.

| Specialist | Parent | What | Why |
|---|---|---|---|
| [[Specialists/course-builder]] | Builder | Scaffolds full course skeletons per `course-format` rule | When starting a new course or extending an existing one. |
| [[Specialists/lesson-writer]] | Writer | Writes individual lesson bodies | Deepens or replaces lesson content after the course is scaffolded. |
| [[Specialists/doc-improver]] | Writer | Polishes existing documents | READMEs, notes, prose docs. |
| [[Specialists/presenter]] | Writer | Builds live HTML decks during voice conversations | "Call presenter" → real-time meeting notes as a scrolling deck. |
| [[Specialists/brainstormer]] | Writer | Thinking partner for half-formed ideas; saves to `00 - Chats/brainstorms/` | Push an idea around before committing. |
| [[Specialists/topic-compiler]] | Archivist | Compiles topic notes from sources | Builds the `10 - Topics/` graph. |
| [[Specialists/summary-writer]] | Archivist | Cross-vault summaries | "What do we know about X" requests. |
| [[Specialists/inbox-sweeper]] | Auditor | Periodic inbox review | Weekly+ sweep of capture surfaces. |
| [[Specialists/drift-watcher]] | Auditor | Vault drift detector — registry-driven scan | Periodic sweep for superseded-infra refs, broken wikilinks, ghost specialists. Promoted to scheduled task. |
| [[Specialists/weekly-summarizer]] | Auditor | Sunday 8 AM recap + light drift sweep + self-cleanup | The weekly heartbeat. Promoted to scheduled task. |
| [[Specialists/project-scaffolder]] | Builder | Drops a new project folder with CLAUDE.md, README, .gitignore | The "start a new project" workhorse. |

## Rules (16)

Live in `03 - Skills & Rules/Rules/`. Loaded by agents via `uses_rules:` frontmatter.

### Universal habits (read by every agent)

| Rule | What | Why |
|---|---|---|
| [[Rules/engineering-doctrine]] | Research-first, code over docs, autonomous execution, bounded search | The keystone rule. Foundational habits for any agent doing real work. |
| [[Rules/memory]] | Per-agent memory protocol (pinned / universal / projects / recent) | Defines how agents load context. Without this, each session starts cold. |
| [[Rules/workflow-spec]] | Format spec for `05 - Workflows/<slug>.md` files | Codifies the workflow shape. |
| [[Rules/claude-features]] | Living registry of Claude/Cowork features + when-to-suggest guidance | So agents proactively surface features Andy would have used (`/goal`, `/plan`, scheduled tasks, etc.). |
| [[Rules/superseded-infra]] | Living registry of retired things (folder paths, files, conventions) | Drift-watcher cross-references this against the vault. Any "Old" string still live in an active doc = drift. |
| [[Rules/tce-vocabulary]] | TCE symbol codec for agent-to-agent dispatch (internal-only) | The alphabet under rules + playbooks. Compresses recurring instructions for Task-tool dispatches + memory loads. Never used in Andy-facing prose. |
| [[Rules/chat-vault-bridge]] | Manual capture format spec for Claude.ai Chat brainstorms | Tells Chat what markdown shape to output at session wrap so Andy can copy/paste into `00 - Chats/brainstorms/`. Pairs with the `brainstorm-lifecycle` workflow's Stage 1. |

### Vault conventions

| Rule | What | Why |
|---|---|---|
| [[Rules/vault-conventions]] | Frontmatter, wikilinks, dates, naming | Keeps the vault consistent. |
| [[Rules/project-readme]] | Project README layout (Path / Stack / Touches / Status / Related / Notes) | So every project README has the same shape. |
| [[Rules/course-format]] | Course lesson format (HTML+MD split between disk and vault) | HTMLs on disk, vault holds trackers + `disk_path:` frontmatter. |
| [[5S_STANDARD]] | File standard + 5S audit cadence (at vault root, not in Rules/) | The disk-side rules. Drive map. |

### Playbooks (structured mission templates)

| Rule | When |
|---|---|
| [[Rules/playbook-request]] | New features, refactors, planned changes |
| [[Rules/playbook-refresh]] | Persistent bugs where prior fixes failed |
| [[Rules/playbook-retro]] | Post-session: distill durable lessons → update doctrine |

### Stackable style directives

| Rule | When |
|---|---|
| [[Rules/style-concise]] | Append for radical conciseness on procedural / report work |
| [[Rules/style-no-sycophancy]] | Always-on. No flattery. |
| [[Rules/style-announce-role]] | Always-on. Transparency header + touched-files footer + frontmatter status-flip for Dashboard signal. |

## Skills (.claude/skills/, 19 custom + 6 Anthropic-provided)

Slash commands. Each is a thin runtime registration that delegates to canonical vault doctrine (rules, specialists, templates). Auto-discovered into the plugin manifest by `22 - Scripts/setup-claude-plugin.ps1`; vault docs auto-generated by `22 - Scripts/generate-skill-docs.ps1`.

| Skill | Triggers | Delegates to |
|---|---|---|
| `/brainstorm` | brainstorm, talk through, push back on | [[Specialists/brainstormer]] |
| `/commit-message-writer` | commit message, write a commit msg | (inline) |
| `/daily-note-writer` | daily note, today's note, start the day | (inline) |
| `/course-builder` | build a course, scaffold a course, add week N | [[Specialists/course-builder]] |
| `/lesson-content-writer` | write lesson, lesson body, expand week N | [[Specialists/lesson-writer]] |
| `/workflow-author` | codify this as a workflow, make this a workflow | (inline + `workflow-spec` rule) |
| `/specialist-creator` | new specialist, add a specialist | (inline + specialist templates) |
| `/deck-builder` | build a deck, slides, presentation | [[Specialists/presenter]] |
| `/drift-fix` | fix this drift, apply fix, patch the doctrine | [[Specialists/drift-watcher]] |
| `/project-scaffolder` | scaffold, set up, create a new project | [[Specialists/project-scaffolder]] |
| `/git-bootstrap` | git init, set up version control | [[05 - Workflows/git-bootstrap]] |
| `/handoff` | handoff, wrap up the session, context is running out | (inline, writes to `00 - Chats/handoffs/`) |
| `/audit` | audit, audit the vault, run a check, what's drifting | [[Auditor]] + [[Specialists/drift-watcher]] |
| `/sweep-inbox` | sweep the inbox, review my inbox, inbox review | [[Specialists/inbox-sweeper]] |
| `/compile-topic` | compile a topic, build a topic note, primer on X | [[Specialists/topic-compiler]] |
| `/retro` | retro, close the loop, what did we learn | [[Rules/playbook-retro]] |
| `/forge` | forge, mine the sessions, find skill candidates, what should be a skill | (cross-session pattern mining — inspired by FORGE archetype from `/goal` video) |
| `/revive` | revive, resurrect, find dormant projects, what have I been ignoring | (project resurrection scan — inspired by REVIVE archetype from `/goal` video) |
| `/report` | provide a report on X, walk me through X (voice), deck on X | [[Specialists/presenter]] in voice-report mode |

Plus 6 Anthropic-provided skills (`docx`, `pdf`, `pptx`, `xlsx`, `schedule`, `skill-creator`).

## Workflows (3)

Live in `05 - Workflows/`. Sequenced multi-step recipes invoked by trigger phrase or agent reference.

| Workflow | Triggers | What |
|---|---|---|
| [[05 - Workflows/audit-pass]] | audit the vault, check for drift, run an audit | Multi-step health check across the vault. |
| [[05 - Workflows/git-bootstrap]] | git bootstrap, push to GitHub, set up the repo | 9-step init → commit → `gh repo create` → push. |
| [[05 - Workflows/new-phase-kickoff]] | start a new phase, kick off Phase N | Phase-startup boilerplate (ROADMAP update, planning, Activity Log row). |

## Scheduled Tasks (2)

Cowork-managed cron jobs. Vault-mirror docs in `06 - Scheduled Tasks/` for discoverability; runtime SKILL.md files live in Cowork's local config.

| Task | Schedule | Cron | What |
|---|---|---|---|
| [[06 - Scheduled Tasks/weekly-summarizer]] | Sundays 8 AM | `0 8 * * 0` | Weekly recap + claude-features gap check + light drift sweep + memory consolidation |
| [[06 - Scheduled Tasks/drift-watcher-quarterly]] | 1st of Jan/Apr/Jul/Oct, 9 AM | `0 9 1 1,4,7,10 *` | Quarterly full doctrine ↔ disk parity audit |

## Special canvases

| Canvas | Where | What |
|---|---|---|
| [[_Command Center.canvas]] | (vault root) | The live dashboard. Composes Dataview views — agents, projects, workflows, scheduled tasks, recent activity. |
| [[system-overview.canvas]] | `14 - How To/` | Visual companion to [[01-system-overview]] guide. 5-layer architecture. |
| [[brainstorm-to-project.canvas]] | `14 - How To/` | Visual companion to [[04-brainstorm-to-project]] guide. 7-stage lifecycle. |
| [[vault-index.canvas]] | `14 - How To/` | Visual companion to this guide. Category-grouped index. |
| [[obsidian-setup.canvas]] | `14 - How To/` | Visual companion to [[03-obsidian-setup]] guide. Plugins + CSS snippets + theme. |

## Activity Log

| File | Where | Why |
|---|---|---|
| [[03 - Skills & Rules/Agents/Activity Log]] | `03 - Skills & Rules/Agents/` | Append-only log of agent invocations. Input for weekly-summarizer. Source of truth for "what happened this week." |

## See also

- [[01-system-overview]] — conceptual map (the 5 layers and how they relate)
- [[04-brainstorm-to-project]] — what to do when you have an idea
- [[ROADMAP]] — where the project is going
- [[5S_STANDARD]] — the disk-side rules + drive map
- [[CLAUDE]] — the doctrine that loads first
- [[Rules/superseded-infra]] — what's been retired (mirror of this index, but for dead things)
