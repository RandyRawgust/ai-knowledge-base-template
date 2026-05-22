---
name: diagnose
description: Disciplined diagnosis loop for hard bugs and performance regressions - reproduce, minimise, hypothesise, instrument, fix, regression-test. Use when Andy says diagnose this, debug this, reports a bug, says something is broken/throwing/failing, or describes a performance regression.
---

# Diagnose

A discipline for hard bugs. Skip phases only when explicitly justified.

When exploring the codebase, use the project's domain glossary (`CONTEXT.md`, the project README, or vault notes) to build a clear mental model, and check any ADRs in the area you're touching.

## Phase 1 — Build a feedback loop

**This is the skill.** Everything else is mechanical. If you have a fast, deterministic, agent-runnable pass/fail signal for the bug, you will find the cause — bisection, hypothesis-testing, and instrumentation all just consume that signal. If you don't have one, no amount of staring at code will save you.

Spend disproportionate effort here. **Be aggressive. Be creative. Refuse to give up.**

### Ways to construct one — try them in roughly this order

1. **Failing test** at whatever seam reaches the bug — unit, integration, e2e
2. **Curl / HTTP script** against a running dev server
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot
4. **Headless browser script** (Playwright / Puppeteer) — drives the UI, asserts on DOM/console/network
5. **Replay a captured trace** — save a real network request / payload / event log to disk; replay it through the code path in isolation
6. **Throwaway harness** — spin up a minimal subset of the system (one service, mocked deps) that exercises the bug code path with a single function call
7. **Property / fuzz loop** — for "sometimes wrong output" bugs, run 1000 random inputs and look for the failure mode
8. **Bisection harness** — automate "boot at state X, check, repeat" so you can `git bisect run` it
9. **Differential loop** — same input through old-version vs new-version (or two configs), diff outputs
10. **HITL bash script** — last resort. If a human must click, drive *them* with a structured loop so output still feeds back to you

Build the right feedback loop, and the bug is 90% fixed.

### Iterate on the loop itself

Treat the loop as a product:
- Can I make it faster? (Cache setup, skip unrelated init, narrow scope)
- Can I make the signal sharper? (Assert on the specific symptom, not "didn't crash")
- Can I make it more deterministic? (Pin time, seed RNG, isolate filesystem, freeze network)

A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is a debugging superpower.

### Non-deterministic bugs

Goal is not a clean repro but a **higher reproduction rate**. Loop the trigger 100×, parallelise, add stress, narrow timing windows, inject sleeps. A 50%-flake bug is debuggable; 1% is not — keep raising the rate until it is.

### When you genuinely cannot build a loop

Stop and say so explicitly. List what you tried. Ask for: (a) access to whatever environment reproduces it, (b) a captured artifact (HAR file, log dump, core dump, screen recording with timestamps), or (c) permission to add temporary production instrumentation. Do **not** proceed to hypothesise without a loop.

Do not proceed to Phase 2 until you have a loop you believe in.

## Phase 2 — Reproduce

Run the loop. Watch the bug appear.

Confirm:
- The loop produces the failure mode **Andy** described — not a different failure that happens to be nearby. Wrong bug = wrong fix.
- Reproducible across multiple runs (or, for non-deterministic bugs, at a high enough rate)
- You have captured the exact symptom so later phases can verify the fix actually addresses it

Do not proceed until you reproduce the bug.

## Phase 3 — Hypothesise

Generate **3–5 ranked hypotheses** before testing any of them. Single-hypothesis generation anchors on the first plausible idea.

Each hypothesis must be **falsifiable**. State the prediction it makes.

> Format: "If <X> is the cause, then <Y> will make the bug disappear / <Z> will make it worse."

If you cannot state the prediction, the hypothesis is a vibe — discard or sharpen.

**Show the ranked list to Andy before testing.** He often has context that re-ranks instantly ("we just changed #3"), or rules out hypotheses he's already tried. Cheap checkpoint, big time saver. Don't block on it — proceed with your ranking if he's AFK.

## Phase 4 — Instrument

Each probe must map to a specific prediction from Phase 3. **Change one variable at a time.**

Tool preference:
1. **Debugger / REPL inspection** if the env supports it — one breakpoint beats ten logs
2. **Targeted logs** at the boundaries that distinguish hypotheses
3. Never "log everything and grep"

**Tag every debug log** with a unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup at the end becomes a single grep.

**Perf branch.** For performance regressions, logs are usually wrong. Instead: establish a baseline measurement (timing harness, `performance.now()`, profiler, query plan), then bisect. Measure first, fix second.

## Phase 5 — Fix + regression test

Write the regression test **before the fix** — but only if there is a **correct seam** for it.

A correct seam is one where the test exercises the **real bug pattern** as it occurs at the call site. If the only seam is too shallow, a regression test there gives false confidence.

**If no correct seam exists, that itself is the finding.** Note it. The architecture is preventing the bug from being locked down. Flag this for the next phase.

If a correct seam exists:
1. Turn the minimised repro into a failing test at that seam
2. Watch it fail
3. Apply the fix
4. Watch it pass
5. Re-run the Phase 1 feedback loop against the original (un-minimised) scenario

## Phase 6 — Cleanup + post-mortem

Required before declaring done:
- Original repro no longer reproduces (re-run the Phase 1 loop)
- Regression test passes (or absence of seam is documented)
- All `[DEBUG-...]` instrumentation removed (`grep` the prefix)
- Throwaway prototypes deleted (or moved to a clearly-marked debug location)
- The hypothesis that turned out correct is stated in the commit / PR message — so the next debugger learns

**Then ask: what would have prevented this bug?** If the answer involves architectural change (no good test seam, tangled callers, hidden coupling) hand off to `improve-codebase-architecture` with the specifics. Make the recommendation **after** the fix, not before.

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/diagnose) — 05-21-26.

## Integrates with
- `03 - Skills & Rules/Rules/playbook-refresh.md` — when prior fixes failed; diagnose is the disciplined version
- `03 - Skills & Rules/Skills/tdd.md` — regression-test step uses the TDD loop
- `03 - Skills & Rules/Skills/improve-codebase-architecture.md` — post-mortem hand-off

## Difference from revive / drift-fix
- `revive` resurrects dormant projects (project-level scope)
- `drift-fix` repairs detected vault drift (vault-level scope)
- `diagnose` debugs a specific code bug or perf regression (file-level scope)
