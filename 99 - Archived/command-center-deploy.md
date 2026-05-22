---
type: workflow
project: AI-OS-Setup
name: command-center-deploy
status: archived
archived_on: 05-17-26
archived_reason: Python Command Center was retired in favor of `_Command Center.canvas` (native Obsidian). No deploy step exists for the canvas — it's read on open.
created: 2026-05-13
updated: 2026-05-13
agents: [Builder]
triggers: []  # cleared on archive so it no longer competes for "deploy CC" requests
tags: [workflow, deploy, command-center, archived]
---

# Workflow — Command Center Deploy (ARCHIVED 05-17-26)

> **ARCHIVED.** This workflow deployed the retired Python Command Center (`command_center.py`, port 8080). It was retired alongside the Python CC on 05-17-26 — see [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra]] registry. The current Command Center is [[_Command Center.canvas]] and requires no deployment.
>
> Triggers cleared so this file no longer routes "deploy CC" requests. Body preserved below for historical reference only.

---

## Original workflow (historical)

**When to invoke:** after editing `command_center.py` (either in the outputs sandbox or in `~/Documents/`), to push the new version into runtime and restart the server.

## Inputs
- Source: `~/Documents/command_center.py` (canonical source, edited by an agent)
- Target: `~/Tools/command-center/command_center.py` (runtime location)
- Port: 8080

## Steps

1. **[Builder]** Confirm the source file compiles: `python -m py_compile ~/Documents/command_center.py`. If it fails, halt and report.
2. **[Builder]** Kill any running server on port 8080:
   ```powershell
   Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue |
     Select-Object -ExpandProperty OwningProcess -Unique |
     ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }
   ```
3. **[Builder]** Copy source to runtime:
   ```powershell
   Copy-Item "$HOME\Documents\command_center.py" `
             "$HOME\Tools\command-center\command_center.py" -Force
   ```
4. **[Builder]** Start the server. Choose mode:
   - **Hidden background** (default for trusted deploys):
     ```powershell
     Start-Process -WindowStyle Hidden -FilePath "py" `
       -ArgumentList "$HOME\Tools\command-center\command_center.py" `
       -WorkingDirectory "$HOME\Tools\command-center"
     ```
   - **Foreground with visible output** (when debugging or first-time deploy of a risky change):
     ```powershell
     cd "$HOME\Tools\command-center"
     py command_center.py
     ```
5. **[Builder]** Wait ~2 seconds, then open `http://localhost:8080` in Chrome. *If foreground mode, Andy runs this from a separate window.*
6. **[Builder]** Hard refresh (Ctrl+Shift+R) once to bust cached HTML.
7. **[Builder]** Verify: dashboard populates, no `--` placeholders persist past 5 seconds, log shows `INFO: Uvicorn running on http://127.0.0.1:8080`.
8. **[Builder]** Append a row to [[Activity Log]] noting the deploy.

## Outputs
- Updated runtime `command_center.py`
- Running server on :8080
- Activity Log entry

## Status markers
- ✅ — deployed and verified
- ⚠️ — deployed with caveat (Chrome cached old HTML, autoplay issue, GPU not detected, etc.)
- 🚧 — failed deploy (compile error, port stuck, etc.)

## Anti-patterns

- **Don't deploy without compiling first.** Lost at least 3 sessions to deploys that crashed on startup (find_claude_cli orphan, JS top-level await, backtick-in-logo). The `py -m py_compile` step is non-negotiable.
- **Don't use background mode for risky changes.** Foreground shows tracebacks; background swallows them.
- **Don't forget the hard refresh.** Browsers aggressively cache the inlined GIFs and JS.
- **Don't deploy from `~/Downloads/`** — that path had mount permission weirdness; canonical source is `~/Documents/command_center.py`.

## Retrospective
> Append durable lessons after notable deploys.

- [2026-05-12] Phase 6 R3.1: logo crashed because figlet "Big" font uses backticks → terminates JS template literal. Pre-deploy compile check would have caught it (it parses Python fine but not JS). Consider adding a JS lint step.
- [2026-05-12] Phase 7.1: Strip pass left orphan `find_claude_cli()` call in `/state` endpoint. Deploy worked, page stayed empty. Lesson: after big strip passes, run the endpoint manually before redeploy.
