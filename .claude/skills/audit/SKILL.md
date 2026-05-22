---
name: audit
description: Invoke Auditor + drift-watcher on demand to scan the vault for drift, broken refs, stale infra, and rule violations. Use when Andy says audit, audit the vault, run a check, what's drifting, find broken stuff, health check.
---

# Audit

On-demand wrapper for [[03 - Skills & Rules/Agents/Auditor|Auditor]] + [[03 - Skills & Rules/Agents/Specialists/drift-watcher|drift-watcher]]. Quarterly scheduled audits already exist via `drift-watcher-quarterly`; this is the same logic, on-demand.

## When to use
Triggers: `audit`, `audit the vault`, `run a check`, `what's drifting`, `find broken stuff`, `health check`, `vault audit`, `check for drift`.

## Load
- `03 - Skills & Rules/Agents/Auditor.md` - dept-head spec
- `03 - Skills & Rules/Agents/Specialists/drift-watcher.md` - drift heuristics
- `03 - Skills & Rules/Rules/superseded-infra.md` - registry of retired things to flag
- `CLAUDE.md` + `5S_STANDARD.md` - rules to check compliance against

## Run

Flip Auditor + drift-watcher to `status: active`. Then sweep:

1. **Superseded-infra registry sweep** - every "Old" string in the registry, ripgrep the active vault. Any hit outside `99 - Archived/`, daily notes, Activity Log, or chats = 🔴 finding.
2. **Broken wikilinks** - find `[[X]]` where X has no matching file (excluding placeholder examples).
3. **Ghost specialists** - any dept-head's `delegates_to:` entry that has no matching `Specialists/<name>.md`.
4. **CLAUDE.md size** - over 200 lines = 🟡.
5. **Frontmatter coverage** - active projects without `skills:` / `rules:` / `agents:` arrays = 🟡 (would hide them from Dashboard queries).
6. **Stuck status flags** - any agent `status: active` for >24h (frontmatter timestamp check) = 🟡.

## Judge protocol (required for substantive audits)

Per [[03 - Skills & Rules/Agents/Auditor#Judge protocol cross-model verification|Auditor's judge protocol]]: after the primary 6-pass produces findings, **dispatch a judge sub-agent in a different model** before committing the report.

Pattern:
1. Primary audit runs in current model. Produces findings + severities.
2. Dispatch judge via Task tool, in different model (if running Sonnet, judge on Opus; or vice versa). Include the TCE preamble.
3. Judge brief: `⊙ ⧉(audit_findings) - run ⧉ ∂ ⊗ attacks. What's missed/overstated/misrated?`
4. Integrate judge response: add missed findings, re-examine disputed ones.
5. Only then write the report. Include a "Judge findings integrated" section.

Skip judge only when total findings <5 or speed-critical.

## Report
Write findings to `01 - Daily Notes/<YYYY-MM-DD> - Vault Audit.md` (or append to today's daily note under `## Audit` section). Use the same 🔴/🟡/⚪ severity scheme as quarterly drift report.

Each finding includes: file path, line number if applicable, suggested fix. End the report with a `## Judge findings integrated` section noting what the judge added, downgraded, or removed.

## After
Suggest invoking `/drift-fix` to apply the fixes. Don't auto-apply.

## Don't
- Don't fix during audit - audit is read-only, separation of concerns
- Don't suppress 🟡 / ⚪ findings - they're the early warning system
- Don't skip the Activity Log row even if zero findings
- Don't skip the judge protocol on substantive audits - that's the integrity gate