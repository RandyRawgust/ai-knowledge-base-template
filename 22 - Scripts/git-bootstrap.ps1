<#
.SYNOPSIS
    Bootstrap git on a project root: init, .gitignore check, first commit, create GitHub repo.

.DESCRIPTION
    Runs the steps codified in 05 - Workflows/git-bootstrap.md. Safe to re-run - checks
    for existing repo / commits before acting.

.PARAMETER Path
    Project root to bootstrap. Defaults to the AI Knowledge Base vault.

.PARAMETER Name
    GitHub repo name. Defaults to lowercase-hyphenated folder name.

.PARAMETER User
    GitHub username. Defaults to "<YOUR-GH-HANDLE>".

.PARAMETER Public
    Make the repo public. Default is private.

.EXAMPLE
    # Bootstrap the vault as a private repo at <YOUR-GH-HANDLE>/ai-knowledge-base
    # (run from within PowerShell - no `pwsh` prefix needed)
    .\22 - Scripts\git-bootstrap.ps1

.EXAMPLE
    # Bootstrap TerraWatt
    .\22 - Scripts\git-bootstrap.ps1 -Path "F:\Game Dev\Projects\TerraWatt" -Name "terrawatt"

.EXAMPLE
    # Bootstrap the Fundamentals course as public
    .\22 - Scripts\git-bootstrap.ps1 -Path "E:\Projects\AI Knowledge Base\13 - Courses\fundamentals-of-coding" -Public

.NOTES
    Compatible with Windows PowerShell 5.1 (built-in) and PowerShell 7+ (pwsh).
    From cmd.exe:  powershell -ExecutionPolicy Bypass -File .\22 - Scripts\git-bootstrap.ps1
#>
[CmdletBinding()]
param(
    [string]$Path = $PWD.Path,
    [string]$Name,
    [string]$User = "<YOUR-GH-HANDLE>",
    [switch]$Public
)

# Bug fix 05-17-26: $Path used to default to the hardcoded live-vault path,
# which meant the script always operated on the live vault even after
# cd-ing elsewhere. Now defaults to $PWD so `cd <target>; .\git-bootstrap.ps1`
# works as expected. Pass -Path explicitly when invoking from a different
# directory than the target repo.

# Note: NOT setting $ErrorActionPreference = "Stop" globally.
# In PS 5.1, that flag treats any native-command stderr as a terminating error,
# which breaks legitimate checks like `git rev-parse --is-inside-work-tree`
# (which writes to stderr when not in a repo). We use explicit $LASTEXITCODE
# checks and `Fail` (exit 1) instead.

function Step([string]$msg) {
    Write-Host ""
    Write-Host "[git-bootstrap] $msg" -ForegroundColor Cyan
}

function Warn([string]$msg) {
    Write-Host "[git-bootstrap] WARN: $msg" -ForegroundColor Yellow
}

function Fail([string]$msg) {
    Write-Host "[git-bootstrap] FAIL: $msg" -ForegroundColor Red
    exit 1
}

# Resolve path
if (-not (Test-Path $Path)) { Fail "Path not found: $Path" }
$Path = (Resolve-Path $Path).Path
# Push-Location so we restore CWD on exit (lets you chain multiple invocations)
Push-Location $Path
trap { Pop-Location; break }
Step "Working in: $Path"

# Derive name if not provided
if (-not $Name) {
    $Name = (Split-Path $Path -Leaf).ToLower() -replace '[^a-z0-9]+', '-' -replace '^-|-$', ''
    Step "Derived repo name: $Name"
}

# 1. Check tooling
Step "Checking tooling..."
try { $null = git --version } catch { Fail "git not installed or not on PATH" }
try { $null = gh --version } catch { Warn "gh CLI not installed - local init only, no GitHub push" }
Step "  git: $(git --version)"

# 2. Already a repo?
git rev-parse --is-inside-work-tree 2>&1 | Out-Null
$inRepo = ($LASTEXITCODE -eq 0)
if ($inRepo) {
    Warn "Already a git repo at $Path - skipping init."
} else {
    Step "git init"
    git init | Out-Null
    git branch -M main
}

# 3. .gitignore check
if (-not (Test-Path ".gitignore")) {
    Warn "No .gitignore found. Adding a minimal one."
    @"
.DS_Store
Thumbs.db
desktop.ini
__pycache__/
*.pyc
.env
.venv/
node_modules/
"@ | Set-Content ".gitignore" -Encoding UTF8
}

# 4. First commit (or skip if already has commits)
git rev-parse HEAD 2>&1 | Out-Null
$hasCommits = ($LASTEXITCODE -eq 0)
if ($hasCommits) {
    Warn "Already has commits - skipping first commit step."
} else {
    Step "Staging + first commit..."
    git add .
    git config user.email "$User@users.noreply.github.com"
    git config user.name "$User"
    git commit -m "Initial commit - $Name" | Out-Null
    Step "  $(git log -1 --oneline)"
}

# 5. GitHub repo
$hasGh = $false
try { $null = gh --version 2>$null; $hasGh = $true } catch {}
if ($hasGh) {
    # Already a remote?
    git remote get-url origin 2>&1 | Out-Null
    $hasRemote = ($LASTEXITCODE -eq 0)
    if ($hasRemote) {
        Warn "origin remote already set - skipping repo creation."
        Step "  $(git remote -v)"
    } else {
        $visibility = if ($Public) { "--public" } else { "--private" }
        Step "Creating GitHub repo $User/$Name ($visibility)..."
        $createOutput = gh repo create "$User/$Name" $visibility --source=. --remote=origin --push 2>&1
        if ($LASTEXITCODE -eq 0) {
            Step "  Done. View: gh repo view $User/$Name --web"
        } elseif ($createOutput -match "already exists") {
            Warn "GitHub repo $User/$Name already exists - linking + pushing instead."
            # Check if remote already got partially wired
            git remote get-url origin 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) {
                git remote add origin "https://github.com/$User/$Name.git"
            }
            Step "  Pushing to existing repo..."
            git push -u origin main 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Step "  Push OK. View: gh repo view $User/$Name --web"
            } else {
                Warn "Push failed. May need: git pull --rebase origin main, or resolve remote conflicts."
            }
        } else {
            Warn "gh repo create failed: $createOutput"
        }
    }
} else {
    Warn "Skipped GitHub repo creation - install gh CLI and re-run."
}

# 6. Final status
Step "Final status:"
Write-Host ""
git status -sb | Select-Object -First 8
Write-Host ""
git log --oneline -5
Write-Host ""
Write-Host "Bootstrap complete." -ForegroundColor Green

# Restore caller's working directory
Pop-Location
