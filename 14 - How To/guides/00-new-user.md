---
type: guide
created: 05-18-26
audience: new-user-from-template
tags: [guide, onboarding, new-user]
---

# New User Guide — Getting Started

Welcome. This is an Obsidian-based AI operating system: 5 dept-head agents + 11 specialists, 18 slash-command skills, and a doctrine layer that keeps everything coherent. This guide gets you from "cloned the repo" to "your first useful session" in about 20 minutes.

If you only read one other document after this, read [[01-system-overview]].

## What you just got

Open the vault in Obsidian and look at the sidebar. The folders are tier-prefixed:

- **00-09** — active flow (daily-driver folders)
- **10-19** — reference / knowledge
- **20-29** — output / utility
- **99** — archive / reserved

The two folders you'll interact with most:
- `01 - Daily Notes/` — one note per day, lowest-friction capture
- `02 - Projects/` — pointer notes for everything you're actively working on

The folder that runs the system:
- `03 - Skills & Rules/` — agents, rules, playbooks, skill catalogs

## Setup — 5 minutes

**Prerequisites:** Obsidian, Claude Code, PowerShell 5.1+, git + gh CLI (with `gh auth login` complete), Python 3.10+.

1. **Clone the repo** to where you want your vault (e.g., `E:\Projects\My Knowledge Base\`).
2. **Open the folder as a vault** in Obsidian. It'll offer to install the community plugins listed in `.obsidian/community-plugins.json`. Accept.
3. **Run the bootstrap script** from PowerShell:
   ```powershell
   cd "<YOUR-VAULT-PATH>"
   .\"22 - Scripts"\bootstrap-for-new-user.ps1
   ```
   It prompts for your name, GitHub handle, email, vault path; substitutes placeholders across all doctrine files; runs the Claude Code setup scripts.

Don't fight the script. Let it ask its questions. ~60 seconds end-to-end.

## Your first session — 10 minutes

Open Cowork (or Claude Code) in the vault folder. Then try one of these openers:

- **"What's in this vault?"** — gets a tour from the Archivist.
- **"/brainstorm I have an idea"** — opens a brainstorming session with the brainstormer specialist.
- **"/daily-note-writer"** — drops today's daily note from a template.
- **"audit the vault"** — runs the Auditor's cross-model judge pass.

Whatever you say, watch for the **transparency header** at the top of Claude's reply — a colored emoji + role name + skill + playbook (e.g., `🟦 Orchestrator · skill: none · playbook: no playbook`). That's how you know which agent picked up your request. The header is non-optional doctrine; if you never see it, something's wrong with the setup.

## Customize — your first 30 minutes

Three places you'll want to personalize:

### 1. CLAUDE.md (vault root)

The vault-wide operating doctrine. Read this fully — it's intentionally under 200 lines. Update it when your conventions diverge from the template's defaults. Don't add history here; that's what `01 - Daily Notes/` and `03 - Skills & Rules/Agents/Activity Log.md` are for.

### 2. Agent pinned memories

`03 - Skills & Rules/Agents/memory/<DeptHead>/pinned.md` for each of Orchestrator / Builder / Writer / Archivist / Auditor. These are the "always remember" directives that agent loads every turn. Replace the template's pre-seeded lines with your own. Examples:

- *Writer:* "Never use the word 'genuinely.'"
- *Builder:* "Default to TypeScript with strict mode."
- *Archivist:* "ISO dates only — `YYYY-MM-DD`."

### 3. Your projects

Drop a pointer note in `02 - Projects/<Category>/<project>.md` for each project you're working on. Frontmatter must include `type: project`, `status: active|dormant|archived|done`, `path:` (where the project actually lives on disk). The Dashboard's "Active projects" query reads this.

## Optional integrations

- **Excalidraw** (optional Obsidian plugin) — for hand-drawn whiteboards/diagrams. The vault works without it; install if you want sketching.
- **Web Clipper** (browser extension) — clips web articles to `11 - Sources/`. Highly recommended.
- **GitHub MCP** — if your projects are on GitHub, enable this so agents can read repo state.
- **Claude.ai "Brainstorming" Project** (optional, web/phone) — see [[../../03 - Skills & Rules/Rules/chat-vault-bridge|chat-vault-bridge]] for the setup. Lets you brainstorm in Chat anywhere (phone, browser), then manually paste the output into `00 - Chats/brainstorms/`. No auto-sync; one copy/paste per session.

## The two-stage brainstorm pattern

This is one of the most-used flows. Worth knowing on day one.

- **Stage 1 (anywhere):** On your phone or in a browser, open Claude.ai (ideally with a "Brainstorming" Project configured). Say "brainstorm this" + your half-formed idea. Chat runs the brainstormer doctrine; at the end it outputs the brainstorm as paste-ready markdown. Copy it into `00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md` in your vault.
- **Stage 2 (at your desk):** In Cowork, say "let's refine the X brainstorm." The brainstormer specialist runs again with full vault context (related topics, prior brainstorms, projects already in motion) and pushes the idea further.

Full doctrine: [[../../05 - Workflows/brainstorm-lifecycle|brainstorm-lifecycle workflow]].

## Where to look when something feels off

- **Dashboard.md** (vault root) — live agent status, project status, recent activity. If an agent shows `status: active` for more than a day, something didn't close out.
- **Activity Log** at `03 - Skills & Rules/Agents/Activity Log.md` — every substantive change to the vault. If you wonder "when did I add X," grep here.
- **drift-watcher** runs quarterly via `06 - Scheduled Tasks/drift-watcher-quarterly.md`. You can also run `/audit` on demand any time.

## What to read next

In order:
1. [[01-system-overview]] — five operational layers, agents, rules, workflows, scheduled tasks
2. [[04-brainstorm-to-project]] — full lifecycle of an idea into a working project
3. [[05-vault-index]] — every folder, agent, rule, skill, with one-line "what" and "why"
4. [[03-obsidian-setup]] — Obsidian plugins + CSS snippets + theme conventions

## Things that will trip you up

- **Frontmatter is law.** Every note has `type:` + `created:` + `tags:` minimum. If you skip them, Dataview queries don't see the note and it goes invisible on the Dashboard.
- **Wikilinks for vault refs, markdown links for external paths.** `[[note-name]]` for vault, `[label](file:///...)` for disk.
- **Don't store binaries in the vault.** PNG / JPG / SVG / MP4 / PDF / ZIP / HTML are external. Reference them by `file:///` link. (One approved exception: `04 - Templates/Presenter Deck Template.html`.)
- **Re-run the setup scripts after pulling changes.** If you `git pull` and the doctrine files changed, re-run `22 - Scripts/setup-claude-skills.ps1` and `setup-claude-plugin.ps1` to refresh runtime artifacts.

## You're set

Open Cowork or Claude Code, drop into the vault folder, and start a session. The system surfaces what you need. When in doubt: `/audit` to see what's drifting, or just talk to the Orchestrator ("what should I be working on?").

Welcome aboard.
