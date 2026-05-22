---
name: revive
description: Scan every project in 02 - Projects/ (and follow path: frontmatter to on-disk location), check git activity, surface dormant projects with one-page resurrection plans. Use when Andy says revive, resurrect, dormant projects, what projects could I pick back up, find stalled work.
---

# Revive

Inspired by the REVIVE archetype from the /goal video. Walks every project in the vault, follows the frontmatter `path:` field to its on-disk location, checks git activity + remaining tests + last-edited dates, and surfaces dormant projects with concrete one-page resurrection plans.

## When to use
Triggers: `revive`, `resurrect`, `dormant projects`, `what projects could I pick back up`, `find stalled work`, `what have I been ignoring`.

Best run quarterly or when Andy is between major sprints and wants to scan for next-up candidates.

## Load
- `02 - Projects/` - all project pointer notes (each has `path:` frontmatter)
- `Projects-Index.md` - the auto-rolled list
- `CLAUDE.md` - drive map for context on where projects live
- For each project: the on-disk folder per `path:` field

## Run

### Phase 0 — Inventory
List every `02 - Projects/<category>/<project>.md` with: status (from frontmatter), category, path on disk.

### Phase 1 — Per-project scan
For each project:
- Read the pointer note
- Visit `path:` location on disk
- `git log -1` for last commit date
- Count files in the project folder (rough scope signal)
- Check for `README.md`, `ROADMAP.md`, `NEXT-SESSION-HANDOFF.md` — these are resurrection material
- Look for tests / scripts that might still run

### Phase 2 — Classify

| Classification | Criteria |
|---|---|
| **Active** | Frontmatter `status: active` AND last commit within 30 days |
| **Recently dormant** | Last commit 30-90 days ago. Easy revival. |
| **Cold dormant** | Last commit 90-365 days ago. Resurrection takes context-loading effort. |
| **Archived** | Frontmatter `status: archived` OR no commits in >1 year. Leave alone unless Andy asks. |
| **Stub** | Pointer note exists but on-disk path is empty / missing. Either delete the stub or scaffold. |

### Phase 3 — Resurrection plan (recently/cold dormant only)

For each dormant candidate, produce a one-paragraph plan:

- **State at pause** — what was the last thing being worked on (from last commit message + latest README/ROADMAP)
- **First move to resume** — the single most useful 30-minute action to get unstuck
- **What's at risk if not revived** — does this depend on something that's bit-rotting?
- **Suggested model + skill** — `/goal` if the resumption is iterative; direct work if it's a single step

## Output

Write a revive report to `01 - Daily Notes/<YYYY-MM-DD> - Revive Report.md`:

```markdown
---
type: revive-report
created: <MM-DD-YY>
projects_scanned: <count>
active: <count>
recently_dormant: <count>
cold_dormant: <count>
archived: <count>
stubs: <count>
tags: [revive, projects]
---

# Revive Report -- <MM-DD-YY>

## Recommended pickups (ordered by ease + value)

### 1. <project-name>
- **Status:** recently dormant (last commit MM-DD-YY)
- **State at pause:** <one line>
- **First move:** <30-min action>
- **Risk:** <low/medium/high>
- **Suggested approach:** <model + skill>

### 2. <project-name>
...

## Cold dormant (revival possible but costly)
- <project>: <reason it might still matter>

## Stubs to resolve
- <project>: pointer note at <path> but on-disk path missing. Delete or scaffold?

## Leave alone (archived)
- <project>: <reason>
```

## After
1. Surface the top 1-3 pickup candidates with their first moves
2. Don't auto-resume — Andy chooses what to pick up
3. If Andy picks a candidate, hand off to `/project-scaffolder` if scaffolding is needed, or just open the project's path
4. Append Activity Log row

## Don't
- Don't propose reviving archived projects unless Andy explicitly asks
- Don't auto-delete stub pointer notes — surface them, let Andy decide
- Don't grade projects by line count — small-but-shipped beats big-but-stalled
- Don't ignore the `path:` frontmatter — projects live on disk, not in the vault
- Don't run on every project list at once if there are >20 — paginate the report