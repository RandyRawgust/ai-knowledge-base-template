---
type: rule
created: 2026-05-13
kind: playbook
applies_to: [Auditor, Specialists/weekly-summarizer, all-agents-at-session-end]
source: "Adapted from aashari's retro.md metacognitive loop"
tags: [rule, playbook, retro, self-improvement, doctrine-evolution]
---

# Playbook — Retro (Metacognitive Self-Improvement)

Use at the end of a substantive session to capture durable lessons and improve the underlying doctrine. This is how the system gets smarter over time.

Andy invokes this explicitly ("let's do a retro", "use the retro playbook", "close the loop"). Auditor / weekly-summarizer should also run a lightweight version of this on Sundays.

## Mission structure (3 phases)

### Phase 0 — Session analysis (internal reflection)

Review every turn of the conversation from initial request to now. Self-critical analysis of your own behavior.

Output (chat only, not in final report yet):

- **Successes** — what core principles or patterns led to efficient, correct outcomes?
- **Failures & user corrections** — where did your approach fail? Absolute root cause? Pinpoint Andy's feedback that corrected the trajectory.
- **Actionable lessons** — most critical, transferable lessons from this session that could prevent future failures or replicate successes.

### Phase 1 — Lesson distillation & abstraction

Filter findings into durable universal principles. Ruthless filtering.

**Quality filter — a lesson is durable only if:**

- ✅ **Universal & reusable** — pattern applies to many future tasks, not a one-off fix.
- ✅ **Abstracted** — a general principle (e.g., "always verify env vars exist before use"), not session-specific details.
- ✅ **High-impact** — prevents critical failure, enforces a safety pattern, or significantly improves efficiency.

**Categorization** — for each lesson that passes:
- **Global doctrine** — universal engineering principle → `03 - Skills & Rules/Rules/engineering-doctrine.md` or a relevant style/playbook rule
- **Vault doctrine** — vault-specific best practice → `03 - Skills & Rules/Rules/vault-conventions.md` or `5S_STANDARD.md`
- **Project doctrine** — specific to one project's tech/architecture → that project's `CLAUDE.md`
- **Agent memory** — specific to ONE agent's behavior → that agent's `pinned.md` or `universal.md` per [[memory]] rule

### Phase 2 — Doctrine integration

Integrate lessons into the appropriate file.

**Rule discovery protocol:**
1. **Project-level rules first** — search for `CLAUDE.md`, `AGENT.md`, `.cursor/rules/` in current project. Primary target for project-specific learnings.
2. **Vault-level rules** — `03 - Skills & Rules/Rules/*` for cross-project learnings.
3. **Agent memory** — `03 - Skills & Rules/Agents/memory/<DeptHead>/pinned.md` or `universal.md` for agent-specific habits.

**Integration protocol:**
1. **Read** the target file to understand its structure.
2. Find the most logical section.
3. **Refine, don't just append.** If a similar rule exists, IMPROVE it with the new insight. If not, ADD it, matching the file's tone and structure.

## Final report

- **Doctrine update summary** — which file(s) updated. The exact diff of changes. If no update warranted, state: `ℹ️ No durable lessons distilled — no doctrine change.`
- **Session learnings** — concise bulleted list of patterns identified in Phase 0. Context + evidence for the doctrine changes.

## Quality check before writing

Before integrating a lesson, ask:

- Is this actually universal or just felt important in the moment?
- Will I (a future agent reading this rule) act differently because of it?
- Does it conflict with an existing rule? If so, which wins?
- Is the new line clear standalone, or does it need the session's context to make sense?

If the answer to any of those is uncomfortable, sharpen the lesson first.

## Why this matters

The system gets smarter every time. The Activity Log captures WHAT happened; this playbook captures WHY we should behave differently next time. Without retros, the same mistakes happen on different files.
