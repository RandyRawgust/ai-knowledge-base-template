# AI Knowledge Base -- Template

A markdown-based AI operating system built on Obsidian + Claude Code + Cowork. Comes with:

- **5 dept-head agents** (Orchestrator, Builder, Writer, Archivist, Auditor) + **11 specialists** (sub-agents that can run in parallel via the Task tool)
- **16 doctrine rules** covering engineering practice, playbooks, style, vault conventions, the TCE vocabulary codec, and the Chat-vault bridge architecture
- **19 custom slash commands** (Skills) for daily-driver workflows -- handoff, audit, retro, brainstorm, course-builder, forge (mine sessions for patterns), revive (resurrect dormant projects), report (voice + HTML project briefings), and more
- **4 workflows** + **2 scheduled tasks** (weekly recap, quarterly drift audit)
- **A registry-driven drift watcher** that catches retired infrastructure still referenced as live
- **Per-agent memory** + **status flip + transparency rules** so the agent layer is visible at every turn
- **TCE codec** for internal agent-to-agent dispatch token compression
- **Manual chat-capture format** so phone/web brainstorms in Claude.ai land in the vault with one copy-paste

## Setup (5 minutes)

Prereqs: Obsidian, Claude Code, PowerShell 5.1+, git, [gh CLI](https://cli.github.com/), Python 3.10+.

1. **Clone** this repo to a working folder, e.g. `E:\Projects\My Knowledge Base`.
2. **Open the folder in Obsidian** (open as vault). Obsidian will offer to install the community plugins listed in `.obsidian/community-plugins.json`.
3. **Run the bootstrap script** from PowerShell:
   `powershell
   cd "<YOUR-VAULT-PATH>"
   .\"22 - Scripts"\bootstrap-for-new-user.ps1
   `
   It will prompt for your name, GitHub handle, and vault path, then run all the Claude Code setup scripts.

## What's in here

Read [[14 - How To/guides/01-system-overview]] first, then [[14 - How To/guides/03-vault-index]] for the full catalog. The four how-to canvases in `14 - How To/` give the visual map.

## What's stripped vs original

This is a sanitized template:

- All daily notes, chat transcripts, project notes, and Excalidraw drawings have been removed
- Activity Log is reset to an empty table
- Agent memory `recent.md` files are blank (frontmatter only)
- Personal identifiers (name, email, GitHub handle, custom domains) are replaced with placeholders
- Specific project examples (TerraWatt, KSP) are replaced with generic `<Example>` references
- `.claude/settings.json` is reset; `bootstrap-for-new-user.ps1` regenerates it for your machine

## Original

This template was generated from [<YOUR-GH-HANDLE>/ai-knowledge-base](https://github.com/<YOUR-GH-HANDLE>/ai-knowledge-base) (private). Re-run `22 - Scripts\make-template.ps1` from the live vault to refresh this template.

## Brainstorming Project upload pack

In the root of this repo: `brainstorming-project-knowledge.zip`. Unzip and upload the 4 `.md` files to a Claude.ai "Brainstorming" Project's Knowledge section. The `00-UPLOAD_INSTRUCTIONS.md` inside walks through the custom-instructions paragraph + verification. Lets you brainstorm in Chat (web or phone) and paste the output into your vault. See `03 - Skills & Rules/Rules/chat-vault-bridge.md` for the doctrine.

## License

MIT — see [LICENSE](LICENSE). Free to use, fork, modify, redistribute. Keep the copyright notice.
