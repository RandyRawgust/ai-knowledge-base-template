---
type: memory-universal
agent: Auditor
last_consolidated: 2026-05-13
---

# Auditor — Universal Memory

Cross-project facts I load every invocation.

## Andy's accounts / handles

- **GitHub:** `<YOUR-GH-HANDLE>` (NOT `<YOUR-OLD-GH-HANDLE>` — common mistake; email prefix is misleading). All Andy's project repos: `github.com/<YOUR-GH-HANDLE>/<project>`. Drift check: any rule/note/doc referencing `<YOUR-OLD-GH-HANDLE>/` should be flagged.
- **Email:** <YOUR-EMAIL> · **Website:** <YOUR-PERSONAL-SITE>.dev

## What drift looks like in this vault

Patterns I've observed and now watch for proactively:

- **Ghost specialists** — dept-head `delegates_to:` lists naming files that don't exist on disk. Found 6 such cases in the May 13 audit; all stubbed out.
- **Template residue** — files where the project-template scaffold was left on top of real content. `Dashboard.md` had this before the May 13 cleanup.
- **Frontmatter drift** — `type: project` on files that aren't projects. Breaks Dataview queries.
- **Phantom redirects** — Obsidian sometimes creates stub redirect files when wikilinks fail. `fundamentals-of-coding.md` at vault root is one example.
- **Empty memory layer** — pre-Phase-8, every memory file was an empty stub. Activated 2026-05-13.
- **Stale ROADMAP** — went 5 phases without an update before the May 13 refresh. Easy to let drift.
- **Stale pending tasks** — tasks pending months after the underlying issue resolved. Habit: prune the task list when phases roll over.

## Routine cadence

- **Sunday 9 AM** — Inbox sweep (sort_inbox.py via Windows Task Scheduler).
- **Sunday (planned)** — Weekly summary digest via [[Specialists/weekly-summarizer]].
- **Quarterly** — Full vault drift audit via [[Specialists/drift-watcher]] (this exact pattern).
- **As triggered** — when Andy says "audit X" or "what needs updating".

## 5S enforcement points

- **Sort** — delete duplicates, old installers, stale exports. Don't archive what's actually dead.
- **Set in Order** — one home per file type. Inbox-by-type catches the rest.
- **Shine** — Sunday sweep.
- **Standardize** — [[5S_STANDARD]] is the law.
- **Sustain** — me. The whole point.

## Anti-patterns

- Don't propose deletes without Andy's explicit OK. List, don't act.
- Don't audit while Andy is actively coding/writing in the vault — wait for a natural break.
- Don't gold-plate the audit report. Surface the worst, in priority order, with paths and reasons.

## What "healthy" looks like for this vault

- Frontmatter on every md, valid types.
- No ghost references in `delegates_to:` / `uses_skills:` / `uses_rules:`.
- ROADMAP within one phase of reality.
- Daily Notes have at least one entry per active week.
- Activity Log gets a row when an agent does real work.
- Memory files non-empty (post-Phase 8).
