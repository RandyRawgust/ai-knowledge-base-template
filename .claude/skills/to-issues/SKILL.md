---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable GitHub issues using tracer-bullet vertical slices. Use when Andy wants to convert a plan into issues, create implementation tickets, or break work into shippable units.
---

# To Issues

Break a plan into independently-grabbable GitHub issues using vertical slices (tracer bullets).

## When to use
Triggers: `to issues`, `break this into issues`, `create tickets`, `slice this up`, `make implementation tickets`.

## Process

### 1. Gather context
Work from whatever is already in the conversation. If Andy passes a GitHub issue number or URL, fetch it with `gh issue view <number>` (with comments).

### 2. Explore the codebase (optional)
If you have not already explored the codebase, do so to understand the current state.

### 3. Draft vertical slices

Break the plan into **tracer bullet** issues. Each issue is a thin vertical slice that cuts through ALL integration layers end-to-end — NOT a horizontal slice of one layer.

Slices may be `HITL` (human-in-the-loop) or `AFK` (agent-friendly, can be implemented and merged without supervision). Prefer AFK over HITL where possible.

- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones

### 4. Quiz Andy

Present the proposed breakdown as a numbered list. For each slice:
- **Title** — short descriptive name
- **Type** — HITL / AFK
- **Blocked by** — which other slices (if any) must complete first
- **User stories covered** — if the source has them

Ask:
- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split?
- Are HITL/AFK labels correct?

Iterate until Andy approves.

### 5. Create the GitHub issues

For each approved slice, create a GitHub issue using `gh issue create`. Use the body template below.

Create issues in dependency order (blockers first) so you can reference real issue numbers in "Blocked by".

If the project doesn't have GitHub set up, instead write the slices to `docs/issues/<MM-DD-YY>-<slug>.md` as a numbered list and note that `gh issue create` will run later.

## Issue body template

```markdown
## Parent

# <parent-issue-number> (if the source was a GitHub issue, otherwise omit)

## What to build

A concise description of this vertical slice. End-to-end behaviour, not layer-by-layer implementation.

## Acceptance criteria

- Criterion 1
- Criterion 2
- Criterion 3

## Blocked by

- Blocked by #<n>

Or "None — can start immediately" if no blockers.
```

Do NOT close or modify any parent issue.

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-issues) — 05-21-26. Adapted to fall back to a `docs/issues/` markdown list when `gh` CLI isn't available.

## Integrates with
- `03 - Skills & Rules/Skills/to-prd.md` — the typical upstream input
- `03 - Skills & Rules/Skills/tdd.md` — downstream implementation discipline for each slice
