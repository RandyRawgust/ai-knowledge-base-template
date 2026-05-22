<#
.SYNOPSIS
    Phase 10.4: Wire up the GitHub MCP server in .claude/settings.json.

.DESCRIPTION
    Adds `@modelcontextprotocol/server-github` to the project's mcpServers config.
    Lets agents read repo state, list issues, check workflow runs etc. without
    shelling out to `gh`.

    REQUIREMENT: a GitHub Personal Access Token stored as env var
    GITHUB_PERSONAL_ACCESS_TOKEN. Create one at:
        https://github.com/settings/tokens
    Recommended scopes: repo (read), read:org, read:user, workflow.

.NOTES
    Run AFTER the token env var is set:
        [Environment]::SetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "ghp_xxx", "User")
    Then close + reopen PowerShell so the var is visible.
#>
[CmdletBinding()]
param(
    [string]$VaultRoot = "E:\Projects\AI Knowledge Base"
)

$SettingsDir  = Join-Path $VaultRoot ".claude"
$SettingsPath = Join-Path $SettingsDir "settings.json"
New-Item -ItemType Directory -Force -Path $SettingsDir | Out-Null

# Warn if PAT env var is missing
$tokenSet = [Environment]::GetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "User")
if (-not $tokenSet) {
    Write-Host "WARN: GITHUB_PERSONAL_ACCESS_TOKEN env var not set." -ForegroundColor Yellow
    Write-Host "      Create a token at https://github.com/settings/tokens (scopes: repo, read:org, read:user, workflow)" -ForegroundColor Yellow
    Write-Host "      Then run:" -ForegroundColor Yellow
    Write-Host "          [Environment]::SetEnvironmentVariable('GITHUB_PERSONAL_ACCESS_TOKEN', 'ghp_xxx', 'User')" -ForegroundColor Yellow
    Write-Host "      Close + reopen PowerShell, then re-run this script." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Continuing - the MCP server entry will be added with an env-var placeholder."
    Write-Host ""
}

# Load existing settings or start fresh
if (Test-Path $SettingsPath) {
    $settings = Get-Content $SettingsPath -Raw | ConvertFrom-Json
    Write-Host "[merge] existing settings.json" -ForegroundColor Cyan
} else {
    $settings = [PSCustomObject]@{}
    Write-Host "[create] new settings.json" -ForegroundColor Cyan
}

# Ensure mcpServers exists
if (-not $settings.PSObject.Properties['mcpServers']) {
    $settings | Add-Member -MemberType NoteProperty -Name 'mcpServers' -Value ([PSCustomObject]@{})
}

# GitHub MCP entry. Token comes from env var so the settings.json stays committable.
$githubEntry = [PSCustomObject]@{
    command = "npx"
    args = @("-y", "@modelcontextprotocol/server-github")
    env = [PSCustomObject]@{
        GITHUB_PERSONAL_ACCESS_TOKEN = "`${GITHUB_PERSONAL_ACCESS_TOKEN}"
    }
}

if ($settings.mcpServers.PSObject.Properties['github']) {
    Write-Host "[skip] github MCP already registered" -ForegroundColor Yellow
} else {
    $settings.mcpServers | Add-Member -MemberType NoteProperty -Name 'github' -Value $githubEntry
    Write-Host "[add] github MCP registered" -ForegroundColor Green
}

$json = $settings | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($SettingsPath, $json, [System.Text.UTF8Encoding]::new($false))
Write-Host ""
Write-Host "Settings written: $SettingsPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Test: restart Claude Code, then run:    /mcp" -ForegroundColor Yellow
Write-Host "      You should see 'github' in the connected MCP servers list." -ForegroundColor Yellow
