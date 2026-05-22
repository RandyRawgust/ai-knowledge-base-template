---
type: scheduled-task
task-id: drift-watcher-quarterly
agent: drift-watcher (Auditor specialist)
schedule: 1st of Jan/Apr/Jul/Oct, 9 AM
cron: "0 9 1 1,4,7,10 *"
created: 2026-05-15
status: live
tags: [scheduled-task, quarterly, auditor, drift]
---

# Drift Watcher (quarterly)

Fires on the 1st day of each quarter at 9 AM local time (next: **2026-07-01**). Audits the vault for discrepancies between what the doctrine says and what's on disk.

## What it does

1. **Status flip — active.** Open `03 - Skills & Rules/Agents/Specialists/drift-watcher.md` and set frontmatter: `status: active`, `current_task: quarterly drift audit`, `last_active: <YYYY-MM-DD> <HH:mm>`. Same for parent `Auditor.md`. (CC dashboard reads this.)
2. Run the audit (checks listed below).
3. Write the report to `01 - Daily Notes/<YYYY-MM-DD> - Quarterly Drift Audit.md`.
4. Append Activity Log row.
5. **Self-cleanup (quarterly heavy lift).** Archive Activity Log rows older than 90 days to `01 - Daily Notes/Activity Log Archive <YYYY>-Q<N>.md`. Consolidate each dept head's `recent.md` (drop >30-day entries, promote durable facts first, cap 100 lines). Trim `pinned.md` if over 30 lines. Remove stale `*.canvas.bak` / `*.md.bak` files older than 30 days (list for Andy to confirm). Reset stale `status: active` flags + non-blank `current_task:` fields. Append any newly-discovered "Old → Current" entries to [[03 - Skills & Rules/Rules/superseded-infra]].
6. **Status flip — idle.** Set both `drift-watcher.md` and `Auditor.md` frontmatter `status: idle`. Clear `current_task:` to blank.

## What it checks

### Doctrine ↔ disk parity

- **Ghost specialists** — dept-head `delegates_to:` entries with no file on disk
- **Memory completeness** — each dept head should have pinned + universal + recent + projects/<project>.md for each active project
- **`uses_rules:` accuracy** — every rule named must exist in `03 - Skills & Rules/Rules/`
- **Superseded-infra registry sweep** — cross-reference [[03 - Skills & Rules/Rules/superseded-infra]] "Old" strings against active vault docs per the drift-watcher heuristic

### Content health

- **CLAUDE.md line budget** — must stay ≤200 lines
- **ROADMAP currency** — completed phases marked, current phase reflects reality
- **Activity Log freshness** — significant work that didn't get a row
- **Stale references** — registry-driven (see drift-watcher.md superseded-infra heuristic). Examples: outdated paths, wrong GitHub handle, refs to deleted files, references to retired infrastructure (Python CC, `_System Map.canvas`, etc.)
- **Broken wikilinks** — `[[name]]` where the target doesn't exist

### External state

- **Git status of all tracked repos** — vault, command-center, etc. Any diverged main? Any uncommitted work older than 14 days?

## Output

`E:\Projects\AI Knowledge Base\01 - Daily Notes\<date> - Quarterly Drift Audit.md`

Each finding categorized: 🔴 critical / 🟡 worth fixing / ⚪ note. For each: file paths, what's wrong, suggested fix (or a [[03 - Skills & Rules/Rules/playbook-refresh|playbook-refresh]] invocation if it's a real bug).

Summary at top with counts. If nothing's drifted: one line — "Vault is clean as of <date>. Next audit in 3 months."

## Modify

- **Prompt:** `C:\Users\a