---
type: workflow
project: AI-OS-Setup
name: audit-pass
status: active
created: 2026-05-13
updated: 2026-05-13
agents: [Auditor, Specialists/drift-watcher]
triggers: ["audit the vault", "what's drifted", "vault check", "drift audit", "what needs updating"]
tags: [workflow, audit, sunday-routine]
---

# Workflow — Vault Audit Pass

**When to invoke:** Andy asks for an audit, or [[Specialists/drift-watcher]] runs its quarterly sweep.

## Inputs
- Date range (default: since last audit, or last 90 days)
- Optional: specific area to focus on (e.g., "just check the agents folder")

## Steps

1. **[Auditor]** Read [[5S_STANDARD]] and [[03 - Skills & Rules/Rules/vault-conventions|vault-conventions]] — these are the laws being checked.
2. **[Auditor]** Run a structural scan: `find . -name "*.md" -type f` and `find . -maxdepth 3 -type d` to map current state.
3. **[Auditor]** Check for **ghost references**:
   - For every `delegates_to:` entry, confirm the target file exists
   - For every `uses_rules:` entry, confirm the rule exists
   - For every `uses_skills:` entry, confirm the skill exists
4. **[Auditor]** Check for **unfinished content**: files < 500 bytes, files with `TODO`, `TBD`, `stub`, `placeholder`, `coming soon`, or `not yet`.
5. **[Auditor]** Check for **frontmatter drift**: missing `type`, `created`, or `tags`; wrong `type` for the file's actual purpose.
6. **[Auditor]** Check for **stale content**: files unchanged in 90+ days with `status: active`; daily notes gaps.
7. **[Auditor]** Check for **doctrine ↔ disk mismatch**: every specialist named in CLAUDE.md exists; every wikilink in CLAUDE.md resolves.
8. **[Auditor]** Compose the audit report: 🔴 critical (ghost refs), 🟠 unfinished, 🟡 stale, 🟢 informational — in that order. Include paths and specific line numbers.
9. **DON'T fix anything yet.** *Present the report to Andy; wait for approval before any changes.*
10. **[Auditor]** On Andy's approval: execute the fixes per the [[playbook-request]] phases (recon, plan, execute, verify, self-audit, report).
11. **[Auditor]** Append a row to [[Activity Log]] summarizing the audit.

## Outputs
- Audit report in chat (priority-grouped, with paths)
- (After approval) Fixed vault state
- Activity Log entry

## Status markers used in this workflow
- ✅ — issue resolved
- ⚠️ — fix applied with caveats (e.g., partial fix, deferred sub-issue)
- 🚧 — found, not yet fixed (awaiting decision)

## Anti-patterns

- **Don't propose deletes without Andy's OK** — list, don't act.
- **Don't audit while Andy is actively coding** — wait for a natural break.
- **Don't gold-plate the report** — surface the worst in priority order. No "here are 47 minor things".
- **Don't touch `G:\DJ Music` or `G:\media\video`** — explicitly off-limits.

## Retrospective
> Append durable lessons after major runs.

- [2026-05-13] First formal run found 6 ghost specialists, ROADMAP 5 phases behind, Dashboard.md with project-template residue, one undeletable redirect file (`fundamentals-of-coding.md`). Lesson: audit-passes should run at every phase boundary, not just when asked.
