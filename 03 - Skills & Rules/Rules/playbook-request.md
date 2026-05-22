---
type: rule
created: 2026-05-13
kind: playbook
applies_to: [Builder, Writer, Auditor, all-specialists-building-things]
source: "Adapted from aashari's request.md SOP"
tags: [rule, playbook, sop, build]
---

# Playbook — Request (Standard Operating Protocol)

Use for **constructive work**: new features, refactors, planned changes. Comes from [[engineering-doctrine]] phases applied as a structured mission.

Andy invokes this implicitly (any "build X" / "add Y" / "refactor Z" request) or explicitly ("use the request playbook for this").

## Mission structure (5 phases)

### Phase 0 — Reconnaissance (read-only)

- Non-destructive scan of the codebase / vault / relevant area.
- Build a complete mental model: architecture, dependencies, established patterns.
- Output: a concise digest (≤ 200 lines) of findings. Anchors all subsequent actions.
- **No mutations in this phase.**

### Phase 1 — Planning & strategy

- **Restate objectives.** Define success criteria.
- **Identify full impact surface.** Enumerate every file, component, service, workflow that will be touched directly or indirectly. Tests system-wide thinking.
- **Justify strategy.** Propose the technical approach. Explain why it's the best choice given existing patterns, maintainability, simplicity.

Invoke the Clarification Threshold from [[engineering-doctrine]] only if there's a critical ambiguity that further research can't resolve.

### Phase 2 — Execution

Execute incrementally. Adhere strictly to [[engineering-doctrine]].

Core protocols:
- **Read-Write-Reread**: for every file modified, read it immediately before and immediately after the change.
- **Workspace purity**: transient analysis stays in chat; no unsolicited files.
- **System-wide ownership**: if a shared component changes, update ALL its consumers in the same session.

### Phase 3 — Verification

- Run all relevant quality gates (unit/integration tests, linters).
- If a gate fails: autonomously diagnose and fix; report cause + fix.
- End-to-end test the primary workflows affected.

### Phase 4 — Zero-trust self-audit

Implementation is complete; work is NOT done. Reset thinking. Skeptical, evidence-based re-check.

- **Re-verify final state.** Fresh commands: git status clean? Files in intended final form? Services running?
- **Hunt for regressions.** Explicitly test one critical related feature that wasn't directly modified.
- **Confirm system-wide consistency.** Re-check all consumers of any changed component.

### Phase 5 — Final report

Structured report:
- **Changes applied** — list of created/modified files.
- **Verification evidence** — commands + outputs proving health.
- **System-wide impact statement** — confirmation that dependencies are consistent.
- **Final verdict** — one of:
  - `"Self-Audit Complete. System state is verified and consistent. No regressions identified. Mission accomplished."`
  - `"Self-Audit Complete. CRITICAL ISSUE FOUND. Halting work. [Describe issue and recommend immediate diagnostic steps]."`

## Status markers (use throughout)

- ✅ — objective completed successfully
- ⚠️ — recoverable issue encountered and fixed autonomously
- 🚧 — blocked; awaiting input or resource

Maintain an inline TODO ledger using these markers across the mission.

## When NOT to use this playbook

- Tiny one-line edits where the full ceremony is overkill (rename a variable, fix a typo).
- Pure conversation / questions / clarifications (no mutation).
- Explicit "quick fix" requests where Andy wants speed over rigor.

If unsure, lean toward using the playbook — disciplined is the default.
