<#
.SYNOPSIS
    Generate one vault doc per skill in 03 - Skills & Rules/Skills/ by scanning .claude/skills/.

.DESCRIPTION
    Bridges the gap between the RUNTIME layer (.claude/skills/<name>/SKILL.md, what Claude
    actually invokes) and the VAULT DOC layer (03 - Skills & Rules/Skills/<name>.md, what
    shows up in the Obsidian sidebar and feeds the README catalog).

    For each skill found under .claude/skills/<name>/SKILL.md, generates a vault doc with:
      - Frontmatter (type, kind, description, trigger, related)
      - One-paragraph summary
      - Wikilink to canonical SKILL.md location
      - When-to-use triggers extracted from the SKILL.md description
      - If the skill wraps a specialist, link to the specialist

    Idempotent: re-running overwrites existing vault docs. Skills removed from .claude/skills/
    leave their vault doc behind (manual cleanup — generator does not delete).

.NOTES
    Run after setup-claude-skills.ps1. Or hook this into setup-claude-skills.ps1 to keep
    runtime + docs auto-synced going forward.
#>
[CmdletBinding()]
param(
    [string]$VaultRoot = "E:\Projects\AI Knowledge Base"
)

$SkillsRuntime = Join-Path $VaultRoot ".claude\skills"
$SkillsDocs = Join-Path $VaultRoot "03 - Skills & Rules\Skills"

if (-not (Test-Path $SkillsRuntime)) {
    Write-Error "No runtime skills found at $SkillsRuntime. Run setup-claude-skills.ps1 first."
    exit 1
}

New-Item -ItemType Directory -Force -Path $SkillsDocs | Out-Null

# Map skill name -> specialist file path (if the skill wraps a specialist)
$skillToSpecialist = @{
    "brainstorm"       = "03 - Skills & Rules/Agents/Specialists/brainstormer"
    "sweep-inbox"      = "03 - Skills & Rules/Agents/Specialists/inbox-sweeper"
    "compile-topic"    = "03 - Skills & Rules/Agents/Specialists/topic-compiler"
    "course-builder"   = "03 - Skills & Rules/Agents/Specialists/course-builder"
    "lesson-content-writer" = "03 - Skills & Rules/Agents/Specialists/lesson-writer"
    "deck-builder"     = "03 - Skills & Rules/Agents/Specialists/presenter"
    "project-scaffolder" = "03 - Skills & Rules/Agents/Specialists/project-scaffolder"
}

# Map skill name -> the rule/playbook it loads (if any)
$skillToRule = @{
    "audit"   = "03 - Skills & Rules/Agents/Auditor"
    "handoff" = ""
    "retro"   = "03 - Skills & Rules/Rules/playbook-retro"
    "drift-fix" = "03 - Skills & Rules/Rules/playbook-refresh"
}

$today = Get-Date -Format "MM-dd-yy"
$generated = 0
$skipped = 0

Get-ChildItem -Path $SkillsRuntime -Directory | Sort-Object Name | ForEach-Object {
    $skillName = $_.Name
    $skillMd = Join-Path $_.FullName "SKILL.md"

    if (-not (Test-Path $skillMd)) {
        Write-Host "  [skip] $skillName -- no SKILL.md" -ForegroundColor Yellow
        $skipped++
        return
    }

    # Skip manually-imported vault docs (preserves hand-written contradiction notes,
    # overlap analysis, etc., for skills sourced from external repos like mattpocock/skills).
    $existingDocPath = Join-Path $SkillsDocs "$skillName.md"
    if (Test-Path $existingDocPath) {
        $existingContent = Get-Content $existingDocPath -Raw
        if ($existingContent -match '(?ms)^---\s*\n.*?generated_by:\s*manual import.*?\n.*?---') {
            Write-Host "  [skip] $skillName.md -- manual import, preserving" -ForegroundColor DarkYellow
            $skipped++
            return
        }
    }

    # Parse frontmatter description from SKILL.md
    $content = Get-Content $skillMd -Raw
    $description = ""
    if ($content -match '(?ms)^---\s*\n.*?description:\s*(.+?)\n.*?---') {
        $description = $matches[1].Trim()
    }

    # Build the related-links block
    $relatedLinks = @()
    if ($skillToSpecialist.ContainsKey($skillName)) {
        $relatedLinks += "- Wraps: [[$($skillToSpecialist[$skillName])]] specialist"
    }
    if ($skillToRule.ContainsKey($skillName) -and $skillToRule[$skillName]) {
        $relatedLinks += "- Loads: [[$($skillToRule[$skillName])]]"
    }
    $relatedLinks += "- Runtime: ``.claude/skills/$skillName/SKILL.md``"
    $relatedSection = $relatedLinks -join "`n"

    # Build the doc
    $docPath = Join-Path $SkillsDocs "$skillName.md"
    $doc = @"
---
type: skill-doc
kind: slash-command
skill_name: $skillName
description: $description
generated_by: 22 - Scripts/generate-skill-docs.ps1
last_generated: $today
tags: [skill, slash-command]
---

# /$skillName

$description

## Where it lives

| Layer | Location |
|---|---|
| Runtime (what Claude invokes) | ``.claude/skills/$skillName/SKILL.md`` |
| Vault doc (this file) | ``03 - Skills & Rules/Skills/$skillName.md`` |
| Plugin manifest | ``.claude-plugin/plugin.json`` (auto-discovered) |

## Related

$relatedSection

## Source of truth

The runtime SKILL.md is what Claude actually reads when invoking. This vault doc is a human-readable index entry — do not edit it by hand. To change the skill, edit ``22 - Scripts/setup-claude-skills.ps1``, re-run it, then re-run ``22 - Scripts/generate-skill-docs.ps1`` to refresh this file.

> Auto-generated by ``22 - Scripts/generate-skill-docs.ps1`` on $today.
"@

    [System.IO.File]::WriteAllText($docPath, $doc, [System.Text.UTF8Encoding]::new($false))
    Write-Host "  [gen] $skillName.md" -ForegroundColor Green
    $generated++
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
Write-Host "Generated: $generated vault docs" -ForegroundColor Green
if ($skipped -gt 0) {
    Write-Host "Skipped:   $skipped (no SKILL.md)" -ForegroundColor Yellow
}
Write-Host "Location:  $SkillsDocs" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next: refresh Obsidian (Ctrl+R) to see new docs in the sidebar." -ForegroundColor Yellow
