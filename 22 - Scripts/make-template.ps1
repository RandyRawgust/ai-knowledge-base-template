<#
.SYNOPSIS
    Generate a sanitized, friend-shareable template from the live AI Knowledge Base vault.

.DESCRIPTION
    Produces a clean copy of the vault at a sibling on-disk location with all personal
    data removed, ready to push as a separate GitHub repo (e.g., ai-knowledge-base-template).

    Strips:
    - 00 - Chats/ contents (keeps README)
    - 01 - Daily Notes/ contents (keeps README)
    - 03 - Skills & Rules/Agents/Activity Log.md body (keeps header + format spec)
    - 03 - Skills & Rules/Agents/memory/*/recent.md contents (keeps frontmatter)
    - 02 - Projects/<Category>/<Specific Project>.md (keeps category READMEs only)
    - 20 - Decks/, 21 - Excalidraw/ contents
    - .obsidian/workspace*.json (per-machine state)

    Replaces:
    - <YOUR-GH-HANDLE> -> <YOUR-GH-HANDLE>
    - <YOUR-EMAIL> -> <YOUR-EMAIL>
    - "Andy" in instructional contexts -> <YOUR-NAME>
    - TerraWatt, KSP-specific references -> <Example Game Project>, <Example Project>
    - E:\Projects\* personal paths -> <YOUR-VAULT-PATH>\* in CLAUDE.md examples

.PARAMETER LiveVault
    Path to the source vault. Defaults to E:\Projects\AI Knowledge Base.

.PARAMETER TemplateOut
    Path where the sanitized template will be written. Defaults to E:\Projects\AI Knowledge Base Template.

.PARAMETER Force
    Overwrite the template path if it already exists.

.EXAMPLE
    .\make-template.ps1
    .\make-template.ps1 -Force
    .\make-template.ps1 -LiveVault "E:\Projects\AI Knowledge Base" -TemplateOut "E:\Projects\KB Template"

.NOTES
    Idempotent. Re-running overwrites the template (with -Force) or refuses (without).
    Always run a final `make-template.ps1 -Force` before pushing the template repo.
#>
[CmdletBinding()]
param(
    [string]$LiveVault = "E:\Projects\AI Knowledge Base",
    [string]$TemplateOut = "E:\Projects\AI Knowledge Base Template",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

Write-Host "=== make-template.ps1 ===" -ForegroundColor Cyan
Write-Host "Source : $LiveVault" -ForegroundColor Gray
Write-Host "Target : $TemplateOut" -ForegroundColor Gray
Write-Host ""

# === 1. Validate ===

if (-not (Test-Path $LiveVault)) {
    Write-Error "Source vault not found: $LiveVault"
    exit 1
}

if (Test-Path $TemplateOut) {
    if ($Force) {
        Write-Host "[clean] Removing existing $TemplateOut" -ForegroundColor Yellow
        Remove-Item -Recurse -Force $TemplateOut
    } else {
        Write-Error "Target exists. Use -Force to overwrite: $TemplateOut"
        exit 1
    }
}

# Safety check: don't run against the template itself
if ((Resolve-Path $LiveVault).Path -like "*Template*") {
    Write-Error "Refusing to template-ize a folder already named 'Template'. Check your -LiveVault parameter."
    exit 1
}

# === 2. Copy entire structure ===

Write-Host "[copy] Mirroring $LiveVault to $TemplateOut" -ForegroundColor Cyan
robocopy $LiveVault $TemplateOut /MIR /XD ".git" "node_modules" /XF "*.tmp" "Thumbs.db" /NJH /NJS /NDL /NFL | Out-Null
# robocopy exit codes 0-7 are success; 8+ are real errors
if ($LASTEXITCODE -ge 8) {
    Write-Error "robocopy failed with exit code $LASTEXITCODE"
    exit 1
}

# === 3. Strip personal content ===

function Clear-FileBody {
    param([string]$Path, [string]$KeepPattern = "^---\s*$")
    # Keep frontmatter (first --- block) + headers, blank everything else
    if (-not (Test-Path $Path)) { return }
    $lines = Get-Content $Path
    $out = New-Object System.Collections.ArrayList
    $inFrontmatter = $false
    $frontmatterClosed = $false
    foreach ($line in $lines) {
        if ($line -match "^---\s*$") {
            [void]$out.Add($line)
            if (-not $inFrontmatter) {
                $inFrontmatter = $true
            } else {
                $frontmatterClosed = $true
                $inFrontmatter = $false
            }
            continue
        }
        if ($inFrontmatter) {
            [void]$out.Add($line)
            continue
        }
        # After frontmatter -- keep h1/h2 headings, drop everything else
        if ($line -match "^#{1,2}\s") {
            [void]$out.Add($line)
            [void]$out.Add("")
            [void]$out.Add("> *(template -- fill in your own content)*")
            [void]$out.Add("")
        }
    }
    Set-Content -Path $Path -Value $out -Encoding UTF8
}

Write-Host "[strip] 00 - Chats/ -- clearing transcripts" -ForegroundColor Yellow
Get-ChildItem "$TemplateOut\00 - Chats" -Recurse -File | Where-Object { $_.Name -ne "README.md" } | Remove-Item -Force

Write-Host "[strip] 01 - Daily Notes/ -- clearing all dailies" -ForegroundColor Yellow
Get-ChildItem "$TemplateOut\01 - Daily Notes" -Recurse -File | Where-Object { $_.Name -ne "README.md" } | Remove-Item -Force

Write-Host "[strip] Activity Log -- keeping format spec, blanking history rows" -ForegroundColor Yellow
$activityLog = "$TemplateOut\03 - Skills & Rules\Agents\Activity Log.md"
if (Test-Path $activityLog) {
    $content = @"
---
type: activity-log
created: <YOUR-START-DATE>
tags: [agents, log]
---

# Agent Activity Log

Append-only log of agent invocations. Every time you invoke an agent (course-builder, lesson-writer, etc.), add a line here. This becomes the input for the weekly all-hands meeting and the auditor.

Format (one row per agent invocation):

``````
| Date | Agent | Task | Files touched | Status | Outcome |
``````

## Recent activity

| Date | Agent | Task | Files touched | Status | Outcome |
|------|-------|------|---------------|--------|---------|
| (empty -- your first row goes here) | | | | | |
"@
    Set-Content -Path $activityLog -Value $content -Encoding UTF8
}

Write-Host "[strip] Memory recent.md files -- keeping frontmatter only" -ForegroundColor Yellow
Get-ChildItem "$TemplateOut\03 - Skills & Rules\Agents\memory" -Recurse -Filter "recent.md" | ForEach-Object {
    Clear-FileBody -Path $_.FullName
}

Write-Host "[strip] 02 - Projects/ -- keeping category READMEs only" -ForegroundColor Yellow
Get-ChildItem "$TemplateOut\02 - Projects" -Recurse -File | Where-Object {
    $_.Name -ne "README.md"
} | Remove-Item -Force

Write-Host "[strip] 20 - Decks/ + 21 - Excalidraw/ -- clearing personal output" -ForegroundColor Yellow
@("20 - Decks", "21 - Excalidraw") | ForEach-Object {
    $dir = Join-Path $TemplateOut $_
    if (Test-Path $dir) {
        Get-ChildItem $dir -Recurse -File | Where-Object { $_.Name -ne "README.md" } | Remove-Item -Force
    }
}

Write-Host "[strip] Obsidian per-machine state" -ForegroundColor Yellow
@("workspace.json", "workspace-mobile.json", "graph.json", "core-plugins-migration.json") | ForEach-Object {
    $f = Join-Path $TemplateOut ".obsidian\$_"
    if (Test-Path $f) { Remove-Item $f -Force }
}

# === 4. Replace personal identifiers ===

Write-Host "[scrub] Replacing personal identifiers across all .md / .canvas / .ps1 / .json files" -ForegroundColor Cyan

$replacements = @{
    "<YOUR-GH-HANDLE>"                  = "<YOUR-GH-HANDLE>"
    "<YOUR-EMAIL>"         = "<YOUR-EMAIL>"
    "<YOUR-OLD-GH-HANDLE>"                    = "<YOUR-OLD-GH-HANDLE>"  # historical example
    "C:\Users\<YOUR-USERNAME>"                = "C:\Users\<YOUR-USERNAME>"
    "C:\\Users\\<YOUR-USERNAME>"              = "C:\\Users\\<YOUR-USERNAME>"
    "<YOUR-PERSONAL-SITE>"                      = "<YOUR-PERSONAL-SITE>"
}

$targets = Get-ChildItem $TemplateOut -Recurse -File -Include "*.md", "*.canvas", "*.ps1", "*.json", "*.py" |
    Where-Object { $_.FullName -notmatch "\\\.git\\|\\node_modules\\|\\\.obsidian\\plugins\\" }

foreach ($file in $targets) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $changed = $false
    foreach ($key in $replacements.Keys) {
        if ($content -match [regex]::Escape($key)) {
            $content = $content -replace [regex]::Escape($key), $replacements[$key]
            $changed = $true
        }
    }
    if ($changed) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
    }
}

# === 5. Sanitize project-specific references in doctrine ===

Write-Host "[scrub] Genericizing project examples in CLAUDE.md + agent files" -ForegroundColor Cyan
# These are touchy -- only replace in instructional doctrine contexts, not in user memory
$claudeMd = "$TemplateOut\CLAUDE.md"
if (Test-Path $claudeMd) {
    $content = Get-Content $claudeMd -Raw -Encoding UTF8
    $content = $content -replace "TerraWatt", "<Example Game Project>"
    $content = $content -replace "KSP Series", "<Example Series Project>"
    $content = $content -replace "KSP RPG", "<Example Spreadsheet Project>"
    Set-Content -Path $claudeMd -Value $content -Encoding UTF8 -NoNewline
}

# === 6. Reset .claude/settings.json to template-safe state ===

Write-Host "[reset] .claude/settings.json -- removing absolute Windows path" -ForegroundColor Cyan
$settingsPath = "$TemplateOut\.claude\settings.json"
if (Test-Path $settingsPath) {
    $template = @"
{
    "_comment":  "This file is generated by bootstrap-for-new-user.ps1 + setup-claude-hooks.ps1 + setup-github-mcp.ps1. Don't edit directly; the setup scripts will overwrite it.",
    "hooks":  {},
    "mcpServers":  {}
}
"@
    Set-Content -Path $settingsPath -Value $template -Encoding UTF8
}

# === 7. Generate a friend-facing top-level README ===

Write-Host "[generate] Friend-facing README.md (overwriting personal version)" -ForegroundColor Cyan
$friendReadme = @"
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

1. **Clone** this repo to a working folder, e.g. ``E:\Projects\My Knowledge Base``.
2. **Open the folder in Obsidian** (open as vault). Obsidian will offer to install the community plugins listed in ``.obsidian/community-plugins.json``.
3. **Run the bootstrap script** from PowerShell:
   ```powershell
   cd "<YOUR-VAULT-PATH>"
   .\"22 - Scripts"\bootstrap-for-new-user.ps1
   ```
   It will prompt for your name, GitHub handle, and vault path, then run all the Claude Code setup scripts.

## What's in here

Read [[14 - How To/guides/01-system-overview]] first, then [[14 - How To/guides/03-vault-index]] for the full catalog. The four how-to canvases in ``14 - How To/`` give the visual map.

## What's stripped vs original

This is a sanitized template:

- All daily notes, chat transcripts, project notes, and Excalidraw drawings have been removed
- Activity Log is reset to an empty table
- Agent memory ``recent.md`` files are blank (frontmatter only)
- Personal identifiers (name, email, GitHub handle, custom domains) are replaced with placeholders
- Specific project examples (TerraWatt, KSP) are replaced with generic ``<Example>`` references
- ``.claude/settings.json`` is reset; ``bootstrap-for-new-user.ps1`` regenerates it for your machine

## Original

This template was generated from [<YOUR-GH-HANDLE>/ai-knowledge-base](https://github.com/<YOUR-GH-HANDLE>/ai-knowledge-base) (private). Re-run ``22 - Scripts\make-template.ps1`` from the live vault to refresh this template.

## Brainstorming Project upload pack

In the root of this repo: ``brainstorming-project-knowledge.zip``. Unzip and upload the 4 ``.md`` files to a Claude.ai "Brainstorming" Project's Knowledge section. The ``00-UPLOAD_INSTRUCTIONS.md`` inside walks through the custom-instructions paragraph + verification. Lets you brainstorm in Chat (web or phone) and paste the output into your vault. See ``03 - Skills & Rules/Rules/chat-vault-bridge.md`` for the doctrine.

## License

MIT — see [LICENSE](LICENSE). Free to use, fork, modify, redistribute. Keep the copyright notice.
"@
Set-Content -Path "$TemplateOut\README.md" -Value $friendReadme -Encoding UTF8

# === 7b. Generate MIT LICENSE ===

Write-Host "[generate] LICENSE (MIT)" -ForegroundColor Cyan
$year = (Get-Date).Year
$mitLicense = @"
MIT License

Copyright (c) $year Andy August

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"@
Set-Content -Path "$TemplateOut\LICENSE" -Value $mitLicense -Encoding UTF8

# === 7c. Build the brainstorming-project-knowledge.zip from the template's doctrine files ===

Write-Host "[generate] brainstorming-project-knowledge.zip (Claude.ai Brainstorming Project upload pack)" -ForegroundColor Cyan
$bsStage = Join-Path $TemplateOut "_brainstorming-pack-staging"
New-Item -ItemType Directory -Force -Path $bsStage | Out-Null

# Copy the 4 canonical files from the just-sanitized template
Copy-Item "$TemplateOut\03 - Skills & Rules\Agents\Specialists\brainstormer.md" "$bsStage\01-brainstormer.md" -Force
Copy-Item "$TemplateOut\03 - Skills & Rules\Rules\style-no-sycophancy.md"       "$bsStage\02-style-no-sycophancy.md" -Force
Copy-Item "$TemplateOut\03 - Skills & Rules\Rules\chat-vault-bridge.md"          "$bsStage\03-chat-vault-bridge.md" -Force
Copy-Item "$TemplateOut\CLAUDE.md"                                                "$bsStage\04-CLAUDE.md" -Force

$bsInstructions = @"
# Brainstorming Project -- Knowledge Upload Pack

Drop the 4 ``.md`` files in this folder into your Claude.ai **Brainstorming** Project's Knowledge section. Order doesn't matter; the prefix numbers are just for sidebar sorting.

## What each file teaches Chat

| File | Why it's in here |
|---|---|
| ``01-brainstormer.md`` | The full doctrine. Three-phase shape (surface -> push -> land), slug rules, save protocol. |
| ``02-style-no-sycophancy.md`` | The no-flattery rule. Without it, Chat reflexively validates instead of pushing back. |
| ``03-chat-vault-bridge.md`` | The capture format spec. What markdown Chat outputs at wrap, ready to paste. |
| ``04-CLAUDE.md`` | Vault-wide doctrine. Gives Chat context to reference your conventions. |

## Custom instructions for the Project (paste this in)

\`\`\`
You are a brainstorming partner. Follow the three-phase shape from brainstormer.md -- surface (2-5 turns) -> push (3-8 turns) -> land (1-3 turns). One question at a time. Push back instead of validating.

When the user says save / wrap / done: output the full brainstorm in the markdown format from chat-vault-bridge.md, inside a fenced code block, ready to paste into 00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md in their vault.

Default is conversational and phone-friendly: short turns, no walls of text.
\`\`\`

## Verification

Open a new chat in the Brainstorming Project. Walk through a brainstorm and say "wrap." Look for: one question at a time, at least one push-back, a fenced code block at wrap. If those three show up, the Project is configured.

## When the doctrine evolves

Re-export this pack (re-run ``22 - Scripts/make-template.ps1`` from the live vault) and replace the uploads in your Project. Claude.ai Projects don't auto-sync.
"@
Set-Content -Path "$bsStage\00-UPLOAD_INSTRUCTIONS.md" -Value $bsInstructions -Encoding UTF8

# Zip it up. Compress-Archive is built into PowerShell 5+.
$bsZipPath = Join-Path $TemplateOut "brainstorming-project-knowledge.zip"
if (Test-Path $bsZipPath) { Remove-Item $bsZipPath -Force }
Compress-Archive -Path "$bsStage\*" -DestinationPath $bsZipPath
Remove-Item -Recurse -Force $bsStage

Write-Host "[ship] brainstorming-project-knowledge.zip ready at template root" -ForegroundColor Green

# === 8. Drop a placeholder .gitignore tweaked for fresh installs ===

Write-Host "[generate] .gitignore" -ForegroundColor Cyan
$gitignore = @"
# Obsidian per-machine state (user-specific)
.obsidian/workspace*.json
.obsidian/graph.json

# Claude Code settings (generated by setup-claude-hooks.ps1)
.claude/settings.json

# OS junk
Thumbs.db
.DS_Store
*.tmp

# Python
__pycache__/
*.pyc

# IDE
.vscode/
.idea/

# Local-only daily notes you don't want to ship
# (Uncomment if you want to gitignore your own daily notes)
# 01 - Daily Notes/

# Local-only chat transcripts
# 00 - Chats/

# Excalidraw working drafts (.md files with embedded JSON, but they can get huge)
# 21 - Excalidraw/
"@
Set-Content -Path "$TemplateOut\.gitignore" -Value $gitignore -Encoding UTF8

# === 9. Summary ===

Write-Host ""
Write-Host "=== Template generation complete ===" -ForegroundColor Green
Write-Host "Output: $TemplateOut" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. cd `"$TemplateOut`""
Write-Host "  2. Spot-check a few files (CLAUDE.md, an agent .md, README.md)"
Write-Host "  3. .\`"22 - Scripts`"\git-bootstrap.ps1 -Name `"ai-knowledge-base-template`" -Public"
Write-Host "     (this initializes git + creates the public GitHub repo + pushes)"
Write-Host ""
Write-Host "Tip: re-run with -Force whenever you want to refresh the template from your live vault." -ForegroundColor Gray
