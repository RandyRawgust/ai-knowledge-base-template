---
type: workflow
project: AI-OS-Setup
name: new-phase-kickoff
status: active
created: 2026-05-13
updated: 2026-05-13
agents: [Orchestrator, Builder, Archivist, Auditor]
triggers: ["start a new phase", "kick off phase", "next phase"]
tags: [workflow, phase, kickoff, doctrine]
---

# Workflow — New Phase Kickoff

**When to invoke:** when starting a new phase of AI OS work (Phase 8 → 9 → 10 etc.). Catches the routine of declaring scope, updating ROADMAP, and seeding the right memory.

## Inputs
- Phase number + name (e.g., "Phase 9 — scheduled automation")
- Brief description of what the phase covers

## Steps

1. **[Orchestrator]** Read current [[ROADMAP]] — confirm prior phase is marked DONE; identify what the new phase should contain based on what's already in flight.
2. **[Orchestrator]** Draft a 3-sentence phase description: WHAT, WHY, and HOW it differs from prior phases.
3. **[Archivist]** Append the new phase to [[ROADMAP]] with status `🛠 IN FLIGHT`. Include a sub-list of likely deliverables.
4. **[Auditor]** Run a mini [[audit-pass]] focused on prior phase: is anything unfinished that should bleed into this phase? Surface as a "carry-over" list.
5. **[Builder]** If the phase needs new agents/skills/rules/workflows, create stubs now — name them, write 1-paragraph descriptions, mark `status: stub`. Better to have placeholders than ghost references.
6. **[Archivist]** Add a row to [[Activity Log]]:
   `| <date> | (Phase X) | Phase kickoff: <description> | <files touched> | 🛠 in flight | <expected outcome> |`
7. **[Archivist]** Update each dept head's `projects/AI-OS-Setup.md` memory file with a one-liner about the new phase.
8. **[Orchestrator]** Tell Andy what's queued and which agent/specialist is taking the first step.

## Outputs
- Updated ROADMAP.md with new phase
- Carry-over list from prior phase
- Stubs for any new agents/skills/rules/workflows the phase needs
- Activity Log entry
- Updated dept-head memories

## Status markers
- ✅ — phase is properly declared and queued
- ⚠️ — declared but with carry-over from prior phase noted
- 🚧 — blocked on Andy clarifying scope

## Anti-patterns

- **Don't auto-mark prior phase DONE without verifying.** Some "done" phases have stragglers that need promoting to next phase or formally dropping.
- **Don't write detailed sub-task lists for the new phase.** A phase is a heading, not a project plan. Sub-tasks emerge during execution.
- **Don't create stubs for agents/skills/workflows you don't actually need yet.** Stubs are cheap, but they're not free — they show up in registries.

## Retrospective
> Append durable lessons after each phase kickoff.

- [2026-05-13] Phase 8 (memory layer) kicked off without this workflow. Worked out fine, but we discovered after the fact that ROADMAP needed refreshing through 5 phases. Lesson: doing the kickoff workflow forces the ROADMAP update at the start, not 5 phases later.
