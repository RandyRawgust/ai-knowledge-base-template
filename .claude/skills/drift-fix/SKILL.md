---
name: drift-fix
description: Apply fixes from the latest quarterly drift audit report. Use after drift-watcher-quarterly runs and produces a 01 - Daily Notes/<date> - Quarterly Drift Audit.md report.
---

# Drift Fix

## When to use
Triggers: fix the drift, apply the audit, close the drift report, drift-watcher said X is broken.

## Load
1. Find the latest drift report: `01 - Daily Notes/<YYYY-MM-DD> - Quarterly Drift Audit.md`
2. Read it top to bottom
3. `03 - Skills & Rules/Rules/playbook-refresh.md` - for any 🔴 critical findings that are real bugs

## Process

For each finding:

### 🔴 Critical
Apply playbook-refresh: read symptom, identify root cause, fix, verify, log. These usually mean a broken wikilink target file deleted, a CLAUDE.md over 200 lines, or a workflow referenced by trigger that doesn't exist.

### 🟡 Worth fixing
Direct fix per the suggestion in the report. Examples:
- Stale path reference → find/replace
- Ghost specialist → stub the missing file or remove the dangling delegates_to entry

### ⚪ Note
Acknowledge in the report but don't fix unless trivial.

## After fixes
1. Append an Activity Log row noting what got resolved and what was deferred
2. Re-run drift-watcher manually (or wait for next quarter) to confirm fixes held

## Don't
- Don't bulk-fix without reading each finding - drift can be wrong
- Don't `git rm` files flagged as orphans without checking they're truly unused
- Don't skip the activity-log row - audit closures need history