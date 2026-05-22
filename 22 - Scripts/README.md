---
type: readme
folder: 22 - Scripts
created: 05-17-26
tags: [readme, scripts, runtime, setup]
---

# Scripts

Runnable scripts that operate against the **AI OS / Knowledge Base**. PowerShell setup utilities, Python audit tools, runtime hooks.

> **Scope:** scripts here apply to the vault itself or to cross-project AI OS workflows. **Project-specific scripts stay with their project** on disk (e.g., TerraWatt-only build scripts live at `F:\Game Dev\Projects\TerraWatt\scripts\`, not here).

## Quick reference

| Script | What | When to run |
|---|---|---|
| [Setup — agents](#setup-claude-agentsps1) | Generates `.claude/agents/` sub-agent definitions for the 5 dept heads + 2 promoted specialists | After any dept-head doctrine change; once on fresh machine |
| [Setup — skills](#setup-claude-skillsps1) | Generates `.claude/skills/` slash-command definitions | After any skill change; once on fresh machine |
| [Setup — hooks](#setup-claude-hooksps1) | Writes `.claude/settings.json` PostToolUse hook config | Once; after any hook script path change |
| [Setup — plugin](#setup-claude-pluginps1) | Generates `.claude-plugin/plugin.json` for portability | After significant doctrine changes; before sharing the vault as a plugin |
| [Setup — GitHub MCP](#setup-github-mcpps1) | Wires the GitHub MCP server into `.claude/settings.json` | Once on fresh machine; after token rotation |
| [Git bootstrap](#git-bootstrapps1) | Init git, write .gitignore, first commit, create GH repo, push | Starting version control on any project for the first time |
| [Hook — log edit](#hook-log-editps1) | PostToolUse hook: appends Activity Log stub row on Edit/Write/MultiEdit | Auto-runs (don't invoke manually) |
| [Audit — projects](#audit-projectspy) | Validates every `02 - Projects/<Category>/*.md` against the project-readme rule | Manually; folded into drift-watcher-quarterly |
| [Make template](#make-templateps1) | Generate a sanitized, friend-shareable template from this vault | Before pushing the template repo / sharing with someone |
| [Bootstrap for new user](#bootstrap-for-new-userps1) | Personalize a freshly-cloned template for a new user | Friend runs this once after cloning the template repo |

## Setup scripts

### `setup-claude-agents.ps1`

Generates `.claude/agents/<agent>.md` files for the 5 dept heads (Orchestrator, Builder, Writer, Archivist, Auditor) plus 2 promoted specialists (`weekly-summarizer`, `drift-watcher-quarterly`). Each generated file is a thin runtime registration that points at the canonical agent in `03 - Skills & Rules/Agents/`.

```powershell
cd "E:\Projects\AI Knowledge Base"
.\"22 - Scripts"\setup-claude-agents.ps1
```

Re-run whenever you update dept-head doctrine (color, model, description). Idempotent — overwrites.

### `setup-claude-skills.ps1`

Generates `.claude/skills/<skill>/SKILL.md` for all custom slash commands (`/brainstorm`, `/daily-note-writer`, `/commit-message-writer`, `/course-builder`, `/lesson-content-writer`, `/deck-builder`, `/project-scaffolder`, `/git-bootstrap`, `/workflow-author`, `/specialist-creator`, `/drift-fix`). Each skill is a thin runtime wrapper that points at canonical doctrine in the vault.

```powershell
cd "E:\Projects\AI Knowledge Base"
.\"22 - Scripts"\setup-claude-skills.ps1
```

Re-run after adding new skills or changing existing definitions. Idempotent.

### `setup-claude-hooks.ps1`

Writes `.claude/settings.json` to register the PostToolUse hook that fires after `Edit`/`Write`/`MultiEdit` and invokes `hook-log-edit.ps1`. Run once on a fresh machine, or after the hook script path changes (e.g., today's `.scripts/` → `22 - Scripts/` move).

```powershell
cd "E:\Projects\AI Knowledge Base"
.\"22 - Scripts"\setup-claude-hooks.ps1
```

### `setup-claude-plugin.ps1`

Generates `.claude-plugin/plugin.json` — the manifest that packages the whole AI OS for `claude plugin install` on a fresh machine. Run after significant doctrine changes or before sharing the vault as a plugin.

```powershell
cd "E:\Projects\AI Knowledge Base"
.\"22 - Scripts"\setup-claude-plugin.ps1
```

### `setup-github-mcp.ps1`

Wires `@modelcontextprotocol/server-github` into `.claude/settings.json` using the `$env:GITHUB_PERSONAL_ACCESS_TOKEN` for auth. Run once on a fresh machine, or after token rotation.

```powershell
cd "E:\Projects\AI Knowledge Base"
.\"22 - Scripts"\setup-github-mcp.ps1
```

## One-shot utilities

### `git-bootstrap.ps1`

Initializes git on a project: `.gitignore` check, first commit, `gh repo create`, push. Idempotent — skips git init if already a repo, skips repo creation if the GitHub repo exists.

```powershell
# Bootstrap the vault itself
.\"22 - Scripts"\git-bootstrap.ps1

# Bootstrap TerraWatt
.\"22 - Scripts"\git-bootstrap.ps1 -Path "F:\Game Dev\Projects\TerraWatt" -Name "terrawatt"

# Bootstrap a course as public
.\"22 - Scripts"\git-bootstrap.ps1 -Path "E:\Projects\AI Knowledge Base\13 - Courses\fundamentals-of-coding" -Public
```

PowerShell 5.1 compatible. Captures 3 PS5.1 quirks (BOM-less Windows-1252 decoding, `ErrorActionPreference="Stop"` vs native stderr, `try/catch` vs native non-zero exits) — see the script comments + the [[05 - Workflows/git-bootstrap]] workflow.

### `audit-projects.py`

Validates every `02 - Projects/<Category>/*.md` against the [[03 - Skills & Rules/Rules/project-readme|project-readme rule]]: required frontmatter fields, `path:` points at something real on disk, no orphan project notes. Drift-watcher-quarterly folds these checks in; run manually anytime.

```powershell
python "22 - Scripts/audit-projects.py"
```

### `make-template.ps1`

Generates a **sanitized, shareable template** of this vault at a sibling on-disk path (default `E:\Projects\AI Knowledge Base Template\`). Strips personal data (chats, daily notes, project notes, Activity Log content, agent recent.md), replaces personal identifiers (GitHub handle, email, paths, project names) with placeholders, and writes a friend-facing README. Designed to be pushed as a separate public GitHub repo (`ai-knowledge-base-template`).

```powershell
.\"22 - Scripts"\make-template.ps1                # safe — refuses to overwrite
.\"22 - Scripts"\make-template.ps1 -Force         # refresh existing template
.\"22 - Scripts"\make-template.ps1 -TemplateOut "E:\Projects\KB Template"
```

Re-run with `-Force` whenever you want to refresh the template after making doctrine changes you want to share.

### `bootstrap-for-new-user.ps1`

**Lives inside the template repo**, not the live vault. A friend runs this after cloning the template. Prompts for their name, GitHub handle, email, vault path; substitutes placeholders across all doctrine files; runs all the Claude Code setup scripts in order. End-to-end "make this vault yours" in about 60 seconds.

```powershell
cd <THEIR-VAULT-PATH>
.\"22 - Scripts"\bootstrap-for-new-user.ps1
```

In the *live* vault, this script is a reference copy; it's not meant to be run here.

### `generate-skill-docs.ps1`

Scans `.claude/skills/` and writes one vault doc per skill to `03 - Skills & Rules/Skills/<name>.md`. Bridges the runtime layer and the Obsidian sidebar / README catalog. Chained at the end of `setup-claude-skills.ps1`, so you rarely need to invoke it directly. Re-run if you ever add a skill manually without using the setup script.

## Runtime hooks (don't invoke manually)

### `hook-log-edit.ps1`

PostToolUse hook invoked by Claude Code after every `Edit`/`Write`/`MultiEdit` tool call inside watched directories (`03 - Skills & Rules/`, `05 - Workflows/`, `06 - Scheduled Tasks/`, `02 - Projects/`). Appends a stub row to `03 - Skills & Rules/Agents/Activity Log.md` so nothing slips through unlogged.

Path is referenced by absolute Windows path in `.claude/settings.json`. If you move this script, re-run `setup-claude-hooks.ps1` to update the settings.

## Conventions

- **PowerShell 5.1 compatible.** All `.ps1` scripts work on Windows's built-in `powershell`, not just PS7+ (`pwsh`). The git-bootstrap doctrine captures three PS 5.1 quirks worth knowing.
- **Idempotent setups.** All `setup-*.ps1` scripts overwrite their outputs cleanly. Re-running is always safe.
- **Pure ASCII source.** Em-dashes and other non-ASCII characters get mis-decoded by PS 5.1 reading BOM-less files as Windows-1252. Keep scripts plain.
- **No project-specific logic here.** Project-only scripts live with the project on disk. This folder is AI OS / vault only.

## Adding a new script

1. Drop it here (or wherever it belongs if project-specific)
2. Add a row to the Quick Reference table at the top of this file
3. Add a section below describing what it does, when to run, example invocation
4. If it's a setup script, name it `setup-<thing>.ps1`
5. If it needs to be invoked from `.claude/settings.json` (hook, etc.), update `setup-claude-hooks.ps1` to write that config

## See also

- [[14 - How To/guides/05-vault-index|vault-index]] — full catalog of every entity
- [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra]] — what's been retired
- [[03 - Skills & Rules/Agents/Activity Log|Activity Log]] — auto-populated by `hook-log-edit.ps1`
