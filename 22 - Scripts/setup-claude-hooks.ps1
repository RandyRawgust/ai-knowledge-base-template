<#
.SYNOPSIS
    Phase 10.3: Wire up the Activity Log auto-hook in .claude/settings.json.

.DESCRIPTION
    Creates or merges into .claude/settings.json at the vault root, registering
    a PostToolUse hook that fires after Edit/Write/MultiEdit and invokes
    22 - Scripts/hook-log-edit.ps1.

    Idempotent. If the hook is already present, no-op.
#>
[CmdletBinding()]
param(
    [string]$VaultRoot = "E:\Projects\AI Knowledge Base"
)

$SettingsDir = Join-Path $VaultRoot ".claude"
$SettingsPath = Join-Path $SettingsDir "settings.json"
$HookScript = Join-Path $VaultRoot "22 - Scripts\hook-log-edit.ps1"

if (-not (Test-Path $HookScript)) {
    Write-Host "FAIL: hook script not found at $HookScript" -ForegroundColor Red
    exit 1
}

New-Item -ItemType Directory -Force -Path $SettingsDir | Out-Null

# Load existing settings or start fresh
if (Test-Path $SettingsPath) {
    $settings = Get-Content $SettingsPath -Raw | ConvertFrom-Json
    Write-Host "[merge] existing settings.json found" -ForegroundColor Cyan
} else {
    $settings = [PSCustomObject]@{}
    Write-Host "[create] new settings.json" -ForegroundColor Cyan
}

# Build the hook entry. Hook command runs PowerShell, passes stdin through.
$hookCommand = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$HookScript`""

$hookEntry = [PSCustomObject]@{
    matcher = "Edit|Write|MultiEdit"
    hooks = @(
        [PSCustomObject]@{
            type = "command"
            command = $hookCommand
        }
    )
}

# Ensure hooks.PostToolUse exists, and append our entry if not already present
if (-not $settings.PSObject.Properties['hooks']) {
    $settings | Add-Member -MemberType NoteProperty -Name 'hooks' -Value ([PSCustomObject]@{})
}
if (-not $settings.hooks.PSObject.Properties['PostToolUse']) {
    $settings.hooks | Add-Member -MemberType NoteProperty -Name 'PostToolUse' -Value @()
}

# Dedup: skip if a hook with this command already exists
$exists = $false
foreach ($entry in $settings.hooks.PostToolUse) {
    foreach ($h in $entry.hooks) {
        if ($h.command -eq $hookCommand) { $exists = $true; break }
    }
    if ($exists) { break }
}

if ($exists) {
    Write-Host "[skip] hook already registered" -ForegroundColor Yellow
} else {
    $settings.hooks.PostToolUse = @($settings.hooks.PostToolUse) + $hookEntry
    Write-Host "[add] hook registered" -ForegroundColor Green
}

# Write back without BOM
$json = $settings | ConvertTo-Json -Depth 10
[System.IO.File]::WriteAllText($SettingsPath, $json, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "Settings written: $SettingsPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Test it: edit any file in 03 - Skills & Rules/, 05 - Workflows/, 06 - Scheduled Tasks/, or 02 - Projects/" -ForegroundColor Yellow
Write-Host "         then check Activity Log - a stub row should appear at the top." -ForegroundColor Yellow
