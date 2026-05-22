<#
.SYNOPSIS
    Personalize a freshly-cloned ai-knowledge-base-template for a new user.

.DESCRIPTION
    Run this AFTER cloning the template repo, but BEFORE opening Obsidian for the
    first time. It prompts for your details (name, GitHub handle, vault path),
    substitutes placeholders across all files, and runs the Claude Code setup
    scripts so /agents, /mcp, hooks, and skills are wired in.

    Idempotent -- re-running re-prompts and re-substitutes. Safe to run multiple
    times if you change your mind.

.PARAMETER VaultRoot
    Path to the cloned template. Defaults to the current directory.

.EXAMPLE
    cd "E:\Projects\My Knowledge Base"
    .\"22 - Scripts"\bootstrap-for-new-user.ps1

.NOTES
    Prereqs: PowerShell 5.1+, git, gh CLI, Claude Code installed, Python 3.10+.
    Runs all of: setup-claude-agents.ps1, setup-claude-skills.ps1,
    setup-claude-hooks.ps1, setup-claude-plugin.ps1, setup-github-mcp.ps1.
#>
[CmdletBinding()]
param(
    [string]$VaultRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  AI Knowledge Base -- Bootstrap" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# === 1. Validate location ===

if (-not (Test-Path "$VaultRoot\CLAUDE.md")) {
    Write-Error "Doesn't look like an AI Knowledge Base vault root: $VaultRoot (no CLAUDE.md found)"
    exit 1
}

if (-not (Test-Path "$VaultRoot\22 - Scripts")) {
    Write-Error "22 - Scripts/ folder missing. This script needs the setup scripts as siblings."
    exit 1
}

Write-Host "[detected] Vault at: $VaultRoot" -ForegroundColor Gray
Write-Host ""

# === 2. Prereq checks ===

function Test-Command {
    param([string]$Name)
    return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

Write-Host "[prereqs] Checking..." -ForegroundColor Cyan
$missing = @()
foreach ($cmd in @("git", "gh", "python")) {
    if (Test-Command $cmd) {
        Write-Host "  [OK] $cmd" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $cmd" -ForegroundColor Red
        $missing += $cmd
    }
}
# Claude Code is optional but recommended
if (Test-Command "claude") {
    Write-Host "  [OK] claude (Claude Code)" -ForegroundColor Green
} else {
    Write-Host "  [optional] claude (Claude Code) -- install from https://docs.claude.com/claude-code if you want native sub-agent invocation" -ForegroundColor Yellow
}

if ($missing.Count -gt 0) {
    Write-Host ""
    Write-Error "Required tools missing: $($missing -join ', '). Install and re-run."
    exit 1
}
Write-Host ""

# === 3. Collect user info ===

Write-Host "[prompt] Personalize your vault -- these substitute placeholders across all doctrine files." -ForegroundColor Cyan
Write-Host ""
$userName     = Read-Host "Your first name (e.g., 'Alex')"
$userGhHandle = Read-Host "Your GitHub handle (e.g., 'alexsmith')"
$userEmail    = Read-Host "Your email (used in commit signatures, agent context)"
$userVaultPath = Read-Host "Vault on-disk path (e.g., 'E:\Projects\My Knowledge Base') [default: current location]"
if (-not $userVaultPath) { $userVaultPath = $VaultRoot }

Write-Host ""
Write-Host "[review] Will substitute these placeholders:" -ForegroundColor Cyan
Write-Host "  <YOUR-NAME>        -> $userName" -ForegroundColor Gray
Write-Host "  <YOUR-GH-HANDLE>   -> $userGhHandle" -ForegroundColor Gray
Write-Host "  <YOUR-EMAIL>       -> $userEmail" -ForegroundColor Gray
Write-Host "  <YOUR-VAULT-PATH>  -> $userVaultPath" -ForegroundColor Gray
Write-Host "  <YOUR-USERNAME>    -> $env:USERNAME (auto-detected)" -ForegroundColor Gray
Write-Host ""
$confirm = Read-Host "Proceed? [Y/n]"
if ($confirm -and $confirm -notmatch "^[Yy]") {
    Write-Host "Aborted." -ForegroundColor Yellow
    exit 0
}
Write-Host ""

# === 4. Substitute placeholders ===

Write-Host "[scrub] Substituting placeholders across all .md / .canvas / .ps1 / .json files" -ForegroundColor Cyan

$substitutions = @{
    "<YOUR-NAME>"        = $userName
    "<YOUR-GH-HANDLE>"   = $userGhHandle
    "<YOUR-EMAIL>"       = $userEmail
    "<YOUR-VAULT-PATH>"  = $userVaultPath
    "<YOUR-USERNAME>"    = $env:USERNAME
}

$targets = Get-ChildItem $VaultRoot -Recurse -File -Include "*.md", "*.canvas", "*.ps1", "*.json", "*.py" |
    Where-Object { $_.FullName -notmatch "\\\.git\\|\\node_modules\\|\\\.obsidian\\plugins\\" }

$touched = 0
foreach ($file in $targets) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $changed = $false
    foreach ($key in $substitutions.Keys) {
        if ($content -match [regex]::Escape($key)) {
            $content = $content -replace [regex]::Escape($key), $substitutions[$key]
            $changed = $true
        }
    }
    if ($changed) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        $touched++
    }
}
Write-Host "  [done] Substituted in $touched files" -ForegroundColor Green
Write-Host ""

# === 5. Run setup scripts in order ===

Write-Host "[setup] Running Claude Code setup scripts..." -ForegroundColor Cyan
$scripts = @(
    "setup-claude-agents.ps1",
    "setup-claude-skills.ps1",
    "setup-claude-hooks.ps1",
    "setup-claude-plugin.ps1"
)

foreach ($s in $scripts) {
    $script = Join-Path $VaultRoot "22 - Scripts\$s"
    if (Test-Path $script) {
        Write-Host "  [run] $s" -ForegroundColor Yellow
        & $script -VaultRoot $VaultRoot
    } else {
        Write-Host "  [skip] $s (not found)" -ForegroundColor Yellow
    }
}

# GitHub MCP is optional -- only run if user provided a PAT
$ghMcpScript = Join-Path $VaultRoot "22 - Scripts\setup-github-mcp.ps1"
if (Test-Path $ghMcpScript) {
    Write-Host ""
    Write-Host "[optional] GitHub MCP server -- wires Claude Code to your GitHub" -ForegroundColor Cyan
    Write-Host "  Requires GITHUB_PERSONAL_ACCESS_TOKEN environment variable." -ForegroundColor Gray
    if ($env:GITHUB_PERSONAL_ACCESS_TOKEN) {
        Write-Host "  [detected] GITHUB_PERSONAL_ACCESS_TOKEN is set" -ForegroundColor Green
        $runGh = Read-Host "  Run setup-github-mcp.ps1? [Y/n]"
        if (-not $runGh -or $runGh -match "^[Yy]") {
            & $ghMcpScript -VaultRoot $VaultRoot
        }
    } else {
        Write-Host "  [skip] GITHUB_PERSONAL_ACCESS_TOKEN not set -- skipping GitHub MCP. Set the env var + re-run this script later if you want it." -ForegroundColor Yellow
    }
}

Write-Host ""

# === 6. First-run orientation ===

Write-Host "======================================" -ForegroundColor Green
Write-Host "  Bootstrap complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "What's next:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. Open this folder in Obsidian as a vault" -ForegroundColor White
Write-Host "     - File -> Open vault -> $VaultRoot"
Write-Host "     - Obsidian will offer to install the 11 community plugins. Accept."
Write-Host "     - Install the 'GitHub Theme' from Settings -> Appearance"
Write-Host "     - Enable both CSS snippets from Settings -> Appearance -> CSS snippets"
Write-Host ""
Write-Host "  2. Read these in order:" -ForegroundColor White
Write-Host "     - CLAUDE.md (vault doctrine, 200 lines)"
Write-Host "     - 14 - How To/guides/01-system-overview.md (how the system fits together)"
Write-Host "     - 14 - How To/guides/03-vault-index.md (catalog of every entity)"
Write-Host "     - 14 - How To/guides/04-obsidian-setup.md (Obsidian-side plugins + CSS)"
Write-Host ""
Write-Host "  3. Try a workflow:" -ForegroundColor White
Write-Host "     - In Cowork, type: /brainstorm"
Write-Host "     - Or in Claude Code: claude -> /agents -> see your 5 dept heads + scheduled tasks"
Write-Host ""
Write-Host "  4. Optional: bootstrap a new git repo for your vault" -ForegroundColor White
Write-Host "     - .\`"22 - Scripts`"\git-bootstrap.ps1 -Path `"$VaultRoot`" -Name `"my-knowledge-base`""
Write-Host ""
Write-Host "Welcome." -ForegroundColor Cyan
