---
type: rule
created: 2026-05-13
kind: playbook
applies_to: [Auditor, Specialists/drift-watcher, Builder, all-agents-debugging]
source: "Adapted from aashari's refresh.md RCA protocol"
tags: [rule, playbook, rca, debug, bug-hunt]
---

# Playbook — Refresh (Root Cause Analysis & Remediation)

Use when **a bug is persistent and previous simpler attempts have failed**. Standard procedures suspended; deep diagnostic mode engages.

Andy invokes this implicitly (recurring bug, "this still doesn't work", multiple failed fixes) or explicitly ("use the refresh playbook").

The goal: identify and fix the **absolute root cause**. Patching symptoms is a critical failure.

## Mission structure (6 phases)

### Phase 0 — Reconnaissance & state baseline (read-only)

Non-destructive scan of repo, runtime environment, configs, recent logs. Establish a high-fidelity evidence-based baseline of the system as it relates to the anomaly.

- Output: concise digest (≤ 200 lines).
- **No mutations.**

### Phase 1 — Isolate the anomaly

Critical first goal: create a **minimal, reproducible test case** that reliably triggers the bug.

1. **Define correctness** — state expected, non-buggy behavior.
2. **Create a failing test** — write a new automated test that fails precisely because of this bug. This is your signal-for-success.
3. **Pinpoint the trigger** — exact conditions, inputs, sequence that causes the failure.

No fix attempts until you can reproduce the failure on command.

### Phase 2 — Root cause analysis

With a reproducible failure, investigate methodically.

Evidence-gathering loop:

1. **Formulate a testable hypothesis** — e.g., "the auth token expires prematurely."
2. **Devise an experiment** — safe, non-destructive test or observation to prove/disprove.
3. **Execute and conclude** — present evidence, state conclusion. Wrong hypothesis? Reform from new evidence; repeat.

**Forbidden actions:**
- ❌ Applying a fix without confirmed root cause supported by evidence.
- ❌ Retrying a previously failed fix without new data.
- ❌ Patching a symptom (e.g., adding a null check) without understanding why the value became null.

### Phase 3 — Remediation

Minimal, precise fix that hardens the system against the confirmed root cause.

Core protocols in effect:
- **Read-Write-Reread** on every file modified.
- **System-wide ownership** — if the cause is in a shared component, fix all other affected consumers in this same session.

### Phase 4 — Verification & regression guard

Prove the fix resolved the issue without creating new ones.

1. **Confirm the fix** — re-run the failing test from Phase 1. Must now pass.
2. **Run full quality gates** — entire relevant test suite + linters.
3. **Autonomous correction** — if your fix introduced new failures, diagnose and resolve them.

### Phase 5 — Zero-trust self-audit

Remediation complete; work NOT done.

- **Re-verify final state** with fresh commands. Files correct? Services healthy?
- **Hunt for regressions** — explicitly test the primary workflow of the component you fixed.

### Phase 6 — After-action report

- **Root cause** — definitive statement of the underlying issue + the key piece of evidence.
- **Remediation** — list of changes applied.
- **Verification evidence** — passing test output + full suite output proving no new regressions.
- **Final verdict** — one of:
  - `"Self-Audit Complete. Root cause has been addressed, and system state is verified. No regressions identified. Mission accomplished."`
  - `"Self-Audit Complete. CRITICAL ISSUE FOUND during audit. Halting work. [Describe issue and recommend immediate diagnostic steps]."`

## Status markers

Use ✅ / ⚠️ / 🚧 throughout. Maintain inline TODO ledger.

## Why this matters

We've shipped fixes that didn't actually fix the underlying issue more than once in this vault's history — see Phase 5g (snake GIF transparency), Phase 7.1 (boot crash from missed orphan reference), Phase 7.x (CC didn't load until find_claude_cli orphan was caught). This playbook makes "thought it was fixed but wasn't" much less likely.
