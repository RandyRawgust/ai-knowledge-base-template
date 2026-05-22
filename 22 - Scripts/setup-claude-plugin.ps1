<#
.SYNOPSIS
    Phase 10.5: Package the AI OS as a Claude Code plugin.

.DESCRIPTION
    Creates a .claude-plugin/ folder at the vault root with a plugin.json
    manifest that registers all the existing .claude/agents/, .claude/skills/,
    and .claude/settings.json content as a single installable bundle.

    Once installed, `claude plugin install <vault-path>` reproduces the entire
    AI OS runtime layer on any machine.

.NOTES
    This packages registration, not content. The canonical role definitions
    still live in 03 - Skills & Rules/Agents/ in the vault. The plugin is the
    portable engine layer.
#>
[CmdletBinding()]
param(
    [string]$VaultRoot = "E:\Projects\AI Knowledge Base"
)

$PluginDir = Join-Path $VaultRoot ".claude-plugin"
$ManifestPath = Join-Path $PluginDir "plugin.json"
New-Item -ItemType Directory -Force -Path $PluginDir | Out-Null

# === Dynamic discovery: scan .claude/agents/ and .claude/skills/ ===
# Self-healing manifest — new agents/skills auto-register on next run.

$AgentsRoot = Join-Path $VaultRoot ".claude\agents"
$SkillsRoot = Join-Path $VaultRoot ".claude\skills"

$discoveredAgents = @()
if (Test-Path $AgentsRoot) {
    $discoveredAgents = Get-ChildItem -Path $AgentsRoot -Filter "*.md" -File |
        Sort-Object Name |
        ForEach-Object { ".claude/agents/$($_.Name)" }
}

$discoveredSkills = @()
if (Test-Path $SkillsRoot) {
    $discoveredSkills = Get-ChildItem -Path $SkillsRoot -Directory |
        Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } |
        Sort-Object Name |
        ForEach-Object { ".claude/skills/$($_.Name)" }
}

Write-Host "[discover] Found $($discoveredAgents.Count) agents, $($discoveredSkills.Count) skills" -ForegroundColor Cyan

# Manifest. Claude Code reads this to discover what the plugin provides.
$manifest = [PSCustomObject]@{
    name = "ai-os"
    version = "1.0.0"
    description = "Andy's AI Operating System. 5 dept-head sub-agents (Orchestrator/Builder/Writer/Archivist/Auditor) + 11 specialists (sub-agents that can run in parallel via the Task tool) backed by a markdown vault. 18 custom slash-command skills covering daily-driver workflows (brainstorm, handoff, audit, retro, forge, revive, and more), 15 doctrine rules including the TCE compression codec for agent-to-agent dispatch, an Activity Log auto-hook, and GitHub MCP integration. Source of truth lives in the vault at 03 - Skills & Rules/."
    author = [PSCustomObject]@{
        name = "Andy August"
        github = "<YOUR-GH-HANDLE>"
    }
    homepage = "https://github.com/<YOUR-GH-HANDLE>/ai-knowledge-base"
    keywords = @("ai-os", "agents", "obsidian", "vault", "command-center")

    # What this plugin provides. Auto-discovered from .claude/ — re-run this script after adding skills/agents.
    agents = $discoveredAgents
    skills = $discoveredSkills

    # Hooks + MCPs referenced from .claude/settings.json
    hooks = ".claude/settings.json"
    mcpServers = ".claude/settings.json"

    # Files that must travel with the plugin (relative to vault root)
    includes = @(
        "CLAUDE.md"
        "03 - Skills & Rules/"
        "05 - Workflows/"
        "06 - Scheduled Tasks/"
        "22 - Scripts/setup-claude-agents.ps1"
        "22 - Scripts/setup-claude-hooks.ps1"
        "22 - Scripts/setup-claude-skills.ps1"
        "22 - Scripts/setup-github-mcp.ps1"
        "22 - Scripts/hook-log-edit.ps1"
        "22 - Scripts/git-bootstrap.ps1"
    )

    # Install instructions for a fresh machine
    install = [PSCustomObject]@{
        prerequisites = @(
            "Windows 10/11 with PowerShell 5.1+"
            "Python 3.11+"
            "git + gh CLI (with `gh auth login` complete)"
            "Claude Code installed"
            "GitHub PAT set as env var GITHUB_PERSONAL_ACCESS_TOKEN (for MCP)"
        )
        steps = @(
            "1. Clone the vault: gh repo clone <YOUR-GH-HANDLE>/ai-knowledge-base"
            "2. cd into the cloned folder"
            "3. .\22 - Scripts\setup-claude-agents.ps1   # registers 5 dept heads"
            "4. .\22 - Scripts\setup-claude-hooks.ps1    # Activity Log auto-hook"
            "5. .\22 - Scripts\setup-claude-skills.ps1   # project-scaffolder + git-bootstrap skills"
            "6. .\22 - Scripts\setup-github-mcp.ps1      # GitHub MCP server"
            "7. Open Claude Code, run /agents - confirm 5 dept heads listed"
        )
    }
}

$json = $manifest | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($ManifestPath, $json, [System.Text.UTF8Encoding]::new($false))

Write-Host "Plugin manifest written: $ManifestPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "The AI OS is now a portable plugin." -ForegroundColor Green
Write-Host ""
Write-Host "On a fresh machine, reproduce with:" -ForegroundColor Yellow
Write-Host "  gh repo clone <YOUR-GH-HANDLE>/ai-knowledge-base" -ForegroundColor Yellow
Write-Host "  cd ai-knowledge-base" -ForegroundColor Yellow
Write-Host "  .\22 - Scripts\setup-claude-agents.ps1" -ForegroundColor Yellow
Write-Host "  .\22 - Scripts\setup-claude-hooks.ps1" -ForegroundColor Yellow
Write-Host "  .\22 - Scripts\setup-claude-skills.ps1" -ForegroundColor Yellow
Write-Host "  .\22 - Scripts\setup-github-mcp.ps1" -ForegroundColor Yellow
Write-Host ""
Write-Host "Or, if you tag a release on GitHub, others could install via Claude Code's plugin marketplace." -ForegroundColor Yellow
