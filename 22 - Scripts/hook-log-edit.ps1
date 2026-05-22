<#
.SYNOPSIS
    Claude Code PostToolUse hook - auto-append stub row to Activity Log when
    Edit/Write/MultiEdit touches 03 - Skills & Rules/, 05 - Workflows/, 06 - Scheduled Tasks/,
    or Agents/ files.

.DESCRIPTION
    Wired up via .claude/settings.local.json. Reads tool input JSON from stdin
    (Claude Code passes the tool call as JSON), extracts the file_path, and if
    it's inside one of the watched directories, appends a stub row to
    03 - Skills & Rules/Agents/Activity Log.md.

    The stub row reads:
        | YYYY-MM-DD | (auto-hook) | Edit/Write: <relative path> | <path> | 🚧 stub | _Fill in this row_ |

    Next time anyone opens the Activity Log they'll see the stub and can flesh
    it out. Stops the "I forgot to log it" failure mode.

.NOTES
    Returns "ok" on success, "skipped: <reason>" otherwise. Never errors out
    (hooks blocking Claude Code is bad).
#>
$ErrorActionPreference = "Continue"

try {
    # Read tool input JSON from stdin
    $raw = [Console]::In.ReadToEnd()
    if (-not $raw) { Write-Host "skipped: no input"; exit 0 }
    $payload = $raw | ConvertFrom-Json -ErrorAction Stop

    # Tool name + file path
    $toolName = $payload.tool_name
    $filePath = $payload.tool_input.file_path
    if (-not $filePath) { Write-Host "skipped: no file_path"; exit 0 }

    # Only log edits inside the watched dirs (vault meta-content)
    $vault = "E:\Projects\AI Knowledge Base"
    $watched = @(
        "$vault\Skills & Rules",
        "$vault\Workflows",
        "$vault\Scheduled Tasks",
        "$vault\Projects"
    )
    $isWatched = $false
    foreach ($w in $watched) {
        if ($filePath -like "$w*") { $isWatched = $true; break }
    }
    if (-not $isWatched) { Write-Host "skipped: outside watched dirs"; exit 0 }

    # Don't log the Activity Log itself (would infinite-loop)
    if ($filePath -like "*Activity Log.md") { Write-Host "skipped: log file itself"; exit 0 }

    # Build the stub row
    $today = Get-Date -Format "yyyy-MM-dd"
    $rel = $filePath.Substring($vault.Length).TrimStart('\').Replace('\', '/')
    $row = "| $today | (auto-hook) | ${toolName}: ${rel} | ${rel} | 🚧 stub | _Fill in this row_ |"

    # Append after the table header (look for "|------|" line, insert after it)
    $logPath = "$vault\03 - Skills & Rules\Agents\Activity Log.md"
    if (-not (Test-Path $logPath)) { Write-Host "skipped: log not found"; exit 0 }

    $lines = Get-Content $logPath -Encoding UTF8
    $insertAt = -1
    for ($i = 0; $i -lt $lines.Length; $i++) {
        if ($lines[$i] -match '^\|[-\s|]+\|$') { $insertAt = $i + 1; break }
    }
    if ($insertAt -lt 0) { Write-Host "skipped: no table header"; exit 0 }

    $newLines = $lines[0..($insertAt-1)] + $row + $lines[$insertAt..($lines.Length-1)]
    [System.IO.File]::WriteAllLines($logPath, $newLines, [System.Text.UTF8Encoding]::new($false))
    Write-Host "ok: logged $rel"
} catch {
    Write-Host "skipped: error $($_.Exception.Message)"
}
exit 0
