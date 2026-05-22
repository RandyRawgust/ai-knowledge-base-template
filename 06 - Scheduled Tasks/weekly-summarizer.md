---
type: scheduled-task
task-id: weekly-summarizer
agent: weekly-summarizer (Auditor specialist)
schedule: Sundays 8 AM
cron: "0 8 * * 0"
created: 2026-05-15
status: live
tags: [scheduled-task, weekly, auditor, recap]
---

# Weekly Summarizer

Fires every Sunday at 8 AM local time. Reads the prior 7 days of work, writes a recap, and surfaces missed Claude features.

## What it does

1. **Status flip — active.** Open `03 - Skills & Rules/Agents/Specialists/weekly-summarizer.md` and set frontmatter: `status: active`, `current_task: weekly recap (week of <Mon-date>)`, `last_active: <YYYY-MM-DD> <HH:mm>`. Same for parent `Auditor.md`. (This is what makes the CC dashboard show the run.)
2. Loads context: [[CLAUDE]], [[Specialists/weekly-summarizer]], Auditor's pinned + universal memory, and these rules — engineering-doctrine, playbook-retro, style-no-sycophancy, style-announce-role, claude-features, superseded-infra.
3. Reads [[03 - Skills & Rules/Agents/Activity Log|Activity Log]] for rows in the last 7 days. Identifies themes (most active agents, what got built/refactored/audited), blockers, and the highest-leverage thing accomplished.
4. Scans the week's work for **feature gaps** per the [[03 - Skills & Rules/Rules/claude-features|claude-features rule]] — instances where `/goal`, `/plan`, `/review`, a scheduled task, or a workflow would have helped. Surfaces 1-3 highest-impact.
5. **Light drift sweep** — invoke [[03 - Skills & Rules/Agents/Specialists/drift-watcher|drift-watcher]] in fast-path mode: only the 🔴 and 🟠 checks (broken wikilinks, ghost specialists, superseded-infra references in active docs). Skip the slower stale-file and frontmatter-completeness sweeps — those run quarterly. Findings are appended to the recap under a "## Drift Watch (light)" section. If there are zero findings, write "Clean — no drift detected."
6. Writes the recap to `01 - Daily Notes/<YYYY-MM-DD> - Weekly Recap.md`.
7. Appends an Activity Log row.
8. **Self-cleanup (prevent context rot + stuck status).** Per the [[03 - Skills & Rules/Rules/style-announce-role|style-announce-role rule]] every constructive turn flips an agent's frontmatter `status: active` then back to `idle` at end-of-turn. When a session cuts off mid-work the flip-back never happens. Scan all agent files in `03 - Skills & Rules/Agents/` and `03 - Skills & Rules/Agents/Specialists/`: any file with `status: active` AND `last_active:` older than 24 hours gets flipped to `status: idle` and `current_task:` cleared (the agent is stuck, not actually running). Also: trim each dept head's `recent.md` to entries from the last 30 days (promote durable facts to `universal.md` or `projects/<slug>.md` before dropping). Cap at 100 lines per the [[03 - Skills & Rules/Rules/memory|memory rule]]. Bump `last_consolidated:` to today. Scan for stale `*.canvas.bak` / `*.md.bak` files older than 30 days and surface in the recap's drift-watch section.
9. **Status flip — idle.** Set both `weekly-summarizer.md` and `Auditor.md` frontmatter `status: idle`. Clear `current_task:` to blank. Always end here, success or failure.

## Output

`E:\Projects\AI Knowledge Base\01 - Daily Notes\<date> - Weekly Recap.md`

Frontmatter: `type: daily-note`, `subtype: weekly-recap`, tags: `[recap, weekly, auditor]`.

## Modify

- **Prompt:** `C:\Users\<YOUR-USERNAME>\OneDrive\Documents\Claude\Scheduled\weekly-summarizer\SKILL.md` (or via `mcp__scheduled-tasks__update_scheduled_task`)
- **Schedule:** `update_scheduled_task` with new `cronExpression`
- **Disable:** `update_scheduled_task` with `enabled: false`

## Tone directive (embedded in prompt)

Direct, no padding. No "great week!" preamble. Andy wants signal, not flattery.

## See also

- [[Specialists/weekly-summarizer]] — agent definition
- [[03 - Skills & Rules/Rules/claude-features|claude-features]] — rule driving the gap check
- [[03 - Skills & Rules/Agents/Activity Log|Activity Log]] — input source
- [[06 - Scheduled Tasks/README|Scheduled Tasks index]]
