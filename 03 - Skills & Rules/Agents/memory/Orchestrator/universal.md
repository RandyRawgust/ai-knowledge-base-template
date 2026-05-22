---
type: memory-universal
agent: Orchestrator
last_consolidated: 2026-05-13
---

# Orchestrator — Universal Memory

Cross-project facts I load every invocation. Distilled from session history.

## About Andy

- **GitHub:** `<YOUR-GH-HANDLE>` (NOT `<YOUR-OLD-GH-HANDLE>` — common mistake; email prefix is misleading). Verify with `gh api user --jq .login`.
- **Email:** <YOUR-EMAIL> · **Website:** <YOUR-PERSONAL-SITE>.dev
- Windows user. PowerShell, NOT WSL. Don't suggest Linux-only flows.
- Has a Claude Max plan — `claude --print` subprocesses are free at the margin (don't burn API credits on what Max covers).
- Tier 1 API key (no Opus access). Stick to Sonnet/Haiku when API is unavoidable.
- Communication style: direct, low ceremony. No "great question" preamble. No padding. Bullet points only when they actually help.
- Avoid the words "honestly", "genuinely", "straightforward".
- Prefers showing real work over describing plans. He wants files written, not "here's how I would..."

## System landscape

- Drives:
  - `C:\` system + user profile
  - `E:\` non-game projects + this vault + Media + Command Center
  - `F:\` game-dev projects + game docs + Steam etc.
  - `G:\` archive + DJ music (untouched) + Jellyfin library (untouched)
- Vault root: `E:\Projects\AI Knowledge Base`
- Command Center: `[[_Command Center.canvas]]` at vault root as of 05-17-26 (native Obsidian canvas, no server). Old Python `command_center.py` at `E:\Projects\Command Center\` is superseded — kept on disk for reference only. See [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra]] registry.
- Browser: Chrome (Google ecosystem preference). Don't push Edge unless there's a specific reason.

## Active projects (one-line each)

- **AI OS Setup** — this vault, the Command Center, the agent hierarchy. Phases 0-7 done; Phase 8 (memory) in flight as of 2026-05-13.
- **TerraWatt** — C+Raylib 2D industrial sim. F:\Game Dev\Projects\TerraWatt. Has its own six-role agent stack under `03 - Skills & Rules/Agents/Projects/TerraWatt/`.
- **KSP Series** — long-form video series, E:\Projects\KSP Series.
- **KSP RPG** — Google Sheets space-agency RPG, E:\Projects\KSP RPG.
- **Education / Fundamentals of Coding** — 12-week self-paced course, only lesson 1 built so far.

## How requests typically come in

- Casual: "fix this", "the X is broken" → diagnose first, don't refactor.
- Structural: "audit X", "review Y" → read first, propose plan, ask before changing.
- Building: "make me a Z", "build the next thing" → route to Builder + appropriate specialist.
- Voice review: "call presenter" in Claude voice chat → route to [[Specialists/presenter]].

## Routing reflexes

- "build/scaffold/make" → Builder → specialist
- "expand/rewrite/improve" → Writer → specialist
- "compile/summarize/find" → Archivist
- "audit/check/report" → Auditor
- TerraWatt-anything → 02 - Projects/TerraWatt agents
- Ambiguous → I (Orchestrator) handle it myself or ask.
