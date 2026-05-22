---
type: rule
created: 2026-05-13
updated: 2026-05-13
kind: feature-registry
applies_to: [all-agents]
tags: [rule, claude-features, slash-commands, awareness]
---

# Claude / Cowork Feature Registry

A living list of slash commands, built-in tools, MCP servers, and product features available across Claude Code, Cowork, and the Claude apps. Each entry says **what it does** and **when to suggest using it**.

**Update cadence:** This file is updated when:
- Andy explicitly mentions a new feature ("I want to use /goal")
- [[Specialists/weekly-summarizer]] surfaces a feature gap in its Sunday digest
- An agent encounters a feature gap during work and adds an entry
- Anthropic ships notable features (manual update)

When unsure if a feature exists, **check first, don't assume**. If a slash command or capability is mentioned and not in this registry, search Anthropic docs (or Andy's mention history) before suggesting it.

## Suggestion etiquette

**Suggest when:**
- The user is doing manually what a feature could do automatically
- A new session would benefit from setting up a feature (e.g., `/goal` at session start)
- A persistent pattern in the conversation matches a feature's use case

**Don't suggest when:**
- The user is mid-task and the suggestion would disrupt
- The feature is for niche cases unrelated to current work
- The user has already declined this feature recently
- You're unsure the feature exists in the current product (Claude Code vs Cowork vs Claude.ai differ)

**How to suggest:**
- One line, contextual. "→ `/goal` could run this cleanup autonomously with a judge verifying — useful when the success state is clear but the path takes 30+ minutes."
- Not "would you like me to suggest..." (per [[style-no-sycophancy]]).
- Mention as an aside, not a roadblock.

---

## Claude Code slash commands

| Command | What it does | Suggest when |
|---|---|---|
| `/help` | Lists available commands | User asks how to do X and you're not sure if a command exists |
| `/init` | Generates a CLAUDE.md for the current repo | First time working in a project that lacks one |
| `/clear` | Clears context window | Conversation hit a context wall; starting a fresh topic |
| `/compact` | Compacts current context | Long session, context getting heavy, but Andy wants continuity |
| `/exit` or `/quit` | End session | Clean shutdown after a major milestone |
| `/login`, `/logout` | Auth flow | Auth errors, switching accounts |
| `/permissions` | View / edit tool permissions | Tool denied something; need to grant `Write`, `Edit`, `Bash`, etc. for current path |
| `/cost` | Show token usage | User asks about token spend, or after a heavy session |
| `/memory` | Manage agent memory files | Adding to / clearing CLAUDE.md memory |
| `/model` | Switch models | Need Opus for hard reasoning; need Haiku for cheap triage |
| `/agents` | List configured subagents | Setting up multi-agent flows |
| `/mcp` | Manage MCP servers | Adding/inspecting connected MCPs |
| `/review` | Review a PR | Andy wants a code review of pending changes |
| `/security-review` | Security pass on pending changes | After significant changes, before merge |
| `/bug` | Report a bug to Anthropic | A real Claude/Cowork bug surfaces |
| `/release-notes` | See what's new in this version | After Claude updates, or when Andy wonders what changed |
| `/goal` | **Goal-state autonomous loop with a judge in a different language model.** Give it an objective in ≤4000 chars; primary agent works, judge sub-agent verifies; loops until judge confirms terminal state. Minutes to ~1 hour depending on complexity. See [Autonomous mechanisms](#autonomous-mechanisms-goal--loop--hooks) below. | Bulk refactor / cleanup / iterative refinement where the success state is clear but the path isn't. **Andy actively wants to use this.** |
| `/loop` | **Time-based recurring execution.** Re-runs a command every N minutes/hours while session is open. Composable with `/goal` (e.g., `/loop 30m /goal <objective>`) for persistent background maintenance. | Continuous low-level maintenance during active sessions — drift watching, inbox sweeping, anything you'd otherwise wait until Sunday for. |
| `/plan` (plan mode) | Switch to plan-only mode (no edits until plan approved) | Big architectural change, or when Andy wants the plan before any mutation |

## Cowork-specific

| Feature | What | When to suggest |
|---|---|---|
| `request_cowork_directory` | Ask Andy to grant access to a folder | Need to work in a folder we don't have access to |
| `AskUserQuestion` tool | Multi-choice prompt for the user | Need to clarify intent across 2-4 options; don't use for simple yes/no |
| Visual artifacts | `mcp__visualize__show_widget` for inline SVG/HTML | When a chart/diagram/widget would help explain |
| Scheduled tasks | `mcp__scheduled-tasks__create_scheduled_task` | Recurring work ("every day at 9am", "every Sunday") |
| Persistent artifacts | `mcp__cowork__create_artifact` | Live page that re-renders from MCP data each open — dashboards, trackers |
| MCP registry | `search_mcp_registry` + `suggest_connectors` | User mentions an external service (Slack, Asana, etc.) we don't yet have |
| Plugins | `search_plugins` + `suggest_plugin_install` | User asks "is there a skill for X" |

## Autonomous mechanisms: /goal + /loop + hooks

Three native Claude Code mechanisms for running work without manual orchestration. They compose.

### /goal — goal-state loop with cross-model judge

Give a goal in ≤4000 chars. The primary agent works in a loop; a judge sub-agent **in a different language model** (devil's advocate) verifies after each iteration. Loops until judge confirms terminal state. Takes minutes to ~1 hour.

**Five archetypes** (from the canonical demo):

1. **CLEAN** — bulk reduce / consolidate. "Take this skills folder of 47 files and consolidate to ≤20 by archiving redundant ones."
2. **SHARPEN** — rubric-driven iterative improvement. Pre-write `rubric.md` with success criteria; `/goal` iterates against it.
3. **REVIVE** — scan dormant projects, propose resurrection plans from git activity + remaining tests.
4. **FORGE** — mine session transcripts for prompting patterns recurring 3+ times; propose new skills/rules.
5. **MAINTAIN** — `/loop 30m /goal "keep vault drift at zero"` — persistent self-healing.

**When to suggest:** Andy has a fuzzy success criterion ("clean this up", "consolidate these", "find the patterns"), success is verifiable, and the path is iterative. Don't suggest for single-shot tasks where a direct edit is faster.

### /loop — time-based recurring execution

Re-runs the wrapped command every N minutes/hours while the Claude Code session is open. Composes with `/goal`. Example: `/loop 30m /goal "check 02 - Projects/ for new dormant projects and surface them"`. Different from scheduled tasks: scheduled tasks fire on cron whether you're working or not; `/loop` only fires while you're in-session.

**When to suggest:** continuous lightweight maintenance during a working session. Drift correction, inbox sweeping, status checks.

### hooks — event-triggered autonomous execution

Already in use: `.claude/settings.json` hooks fire on `PostToolUse` and append the Activity Log via `22 - Scripts/hook-log-edit.ps1`. Other event types: `PreToolUse`, `Stop`, `SessionStart`. Set up via the hooks editor or by editing `settings.json` directly.

**When to suggest:** there's a deterministic side effect that should happen on every event of a specific type — logging, validation, notification.

### The judge pattern (broader than /goal)

The video's key architectural insight: separating the agent that DOES work from the agent that VERIFIES the work, and running them in *different* language models. Reduces shared blind spots. Applicable wherever quality matters more than speed: audits, code reviews, drift detection, refactors. Implementable today via the Task tool — dispatch the primary agent in one model, then dispatch the verifier in another, before committing the primary's output. See [[Auditor]] for the canonical implementation.

## Anthropic platform

| Feature | When |
|---|---|
| Projects (in Claude.ai) | Recurring work with shared context — different from this vault but complementary |
| Voice chat (mobile/desktop) | "Call presenter" pattern (Phase 7) lives here |
| Computer use | Heavy multi-app work where Claude needs to drive UI |
| Memory (Claude.ai) | The product memory feature, separate from our per-agent memory rule |

## Known unknowns

Features rumored / partial knowledge:
- New tools may have shipped since the last update of this file (knowledge cutoff: May 2026)
- Cowork plugins ecosystem is growing — search before assuming

When in doubt, check `/release-notes` or ask Andy.

## Integration with weekly digest

[[Specialists/weekly-summarizer]] runs a "feature gap" pass during the Sunday digest:

1. Read this registry
2. Read the last 7 days of conversation + Activity Log
3. Identify patterns where a feature could have helped but wasn't used
4. Surface in the weekly recap as a "consider trying this" section

Example:
> "Last week you set up the Command Center across 6 sessions. Pinning `/goal "Phase 6 polish"` at session start might have kept Claude on-thread instead of drifting into War Room debates. Worth trying next session."

## Manual additions log

Each time this file changes, note what + why:

- [2026-05-13] Initial creation. Andy flagged `/goal` as one he specifically wants to start using. Full registry seeded from current Claude Code + Cowork knowledge.
