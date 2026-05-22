# _scan-installed.ps1
# Enumerates installed Windows software and writes a clean inventory to
# _scan-output.txt in this folder. Run from any PowerShell prompt:
#
#     cd "E:\Projects\AI Knowledge Base\12 - Software Map"
#     powershell -ExecutionPolicy Bypass -File .\_scan-installed.ps1
#
# Sources covered:
#   1. Registry uninstall keys (HKLM 64-bit, HKLM 32-bit, HKCU) - desktop apps
#   2. Microsoft Store / UWP apps (Get-AppxPackage)
#   3. Steam library (parses appmanifest_*.acf files on F:\Games\Steam if present)
#   4. winget list (if winget is installed)
#
# Output: _scan-output.txt next to this script. No network calls, no admin needed.

$ErrorActionPreference = "SilentlyContinue"
$out  = Join-Path $PSScriptRoot "_scan-output.txt"
$sb   = New-Object System.Text.StringBuilder

function Add-Line($text) { [void]$sb.AppendLine($text) }
function Add-Header($text) {
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("============================================================")
    [void]$sb.AppendLine("  $text")
    [void]$sb.AppendLine("============================================================")
}

Add-Line "Software inventory scan"
Add-Line "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Add-Line "Host: $env:COMPUTERNAME / User: $env:USERNAME"

# --- 1. Registry uninstall keys ---
Add-Header "1. Registry (desktop apps)"
$uninstallPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
)
$apps = foreach ($p in $uninstallPaths) {
    Get-ItemProperty $p | Where-Object {
        $_.DisplayName -and -not $_.SystemComponent -and -not $_.ParentKeyName
    } | Select-Object DisplayName, DisplayVersion, Publisher, InstallLocation
}
$apps = $apps | Sort-Object DisplayName -Unique
Add-Line "Count: $($apps.Count)"
Add-Line ""
foreach ($a in $apps) {
    $line = "{0,-55} | {1,-15} | {2,-30} | {3}" -f `
        ($a.DisplayName), ($a.DisplayVersion), ($a.Publisher), ($a.InstallLocation)
    Add-Line $line
}

# --- 2. Microsoft Store / UWP ---
Add-Header "2. Microsoft Store / UWP apps"
$uwp = Get-AppxPackage | Where-Object { -not $_.IsFramework -and $_.SignatureKind -ne "System" } |
    Select-Object Name, Publisher, Version | Sort-Object Name -Unique
Add-Line "Count: $($uwp.Count)"
Add-Line ""
foreach ($u in $uwp) {
    $line = "{0,-50} | {1,-15} | {2}" -f $u.Name, $u.Version, $u.Publisher
    Add-Line $line
}

# --- 3. Steam library ---
Add-Header "3. Steam library"
$steamRoots = @(
    "F:\Games\Steam\steamapps",
    "C:\Program Files (x86)\Steam\steamapps",
    "D:\Steam\steamapps",
    "E:\Steam\steamapps"
) | Where-Object { Test-Path $_ }

if ($steamRoots.Count -eq 0) {
    Add-Line "No Steam steamapps folder found in common locations."
} else {
    foreach ($root in $steamRoots) {
        Add-Line "Steam root: $root"
        Add-Line ""
        Get-ChildItem $root -Filter "appmanifest_*.acf" | ForEach-Object {
            $txt = Get-Content $_.FullName -Raw
            if ($txt -match '"name"\s+"([^"]+)"') {
                $name = $matches[1]
                if ($txt -match '"appid"\s+"(\d+)"') { $appid = $matches[1] } else { $appid = "?" }
                Add-Line ("  [{0,-10}] {1}" -f $appid, $name)
            }
        }
        Add-Line ""
    }
}

# --- 4. winget ---
Add-Header "4. winget list"
$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
    Add-Line (winget list --accept-source-agreements 2>&1 | Out-String)
} else {
    Add-Line "winget not installed."
}

# --- Write output ---
$sb.ToString() | Set-Content -Path $out -Encoding UTF8
Write-Host ""
Write-Host "Wrote: $out"
Write-Host "Total length: $($sb.Length) characters"
