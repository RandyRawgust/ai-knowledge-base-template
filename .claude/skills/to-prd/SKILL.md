---
name: to-prd
description: Turn the current conversation context into a PRD (problem statement, user stories, implementation decisions, testing decisions). Use when Andy wants to crystallize what we've been discussing into a written PRD - no interview, just synthesis.
---

# To PRD

This skill takes the current conversation context and codebase understanding and produces a PRD. Do NOT interview Andy — just synthesize what you already know from the conversation.

## When to use
Triggers: `write a PRD`, `turn this into a PRD`, `crystallize this`, `make this into a doc`, `synthesize what we've discussed`.

## Process

1. Explore the repo to confirm current state if you haven't already.
2. Sketch the major modules you'd need to build or modify. Actively look for opportunities to extract **deep modules** that can be tested in isolation.

A deep module is one which encapsulates a lot of functionality behind a small, testable interface that rarely changes (vs. a shallow module where the interface is nearly as complex as the implementation).

Check with Andy that these modules match expectations. Ask which modules he wants tests written for.

3. Write the PRD using the template below.

## Output destination
- If the project has GitHub Issues set up and `gh` CLI is available: submit as a GitHub issue, return the URL.
- Otherwise: save to the project at `docs/prd/<MM-DD-YY>-<slug>.md` (create `docs/prd/` if missing).
- Always also log a row in `03 - Skills & Rules/Agents/Activity Log.md` so Andy can find it later.

## Template

```markdown
# <Title>

## Problem Statement

The problem the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A long, numbered list. Each story: "As a <persona>, I want <capability>, so that <outcome>."

Example: "As a mobile bank customer, I want to see balances on my accounts, so that I can make better informed decisions about my spending."

Cover all aspects of the feature.

## Implementation Decisions

- Modules to be built / modified
- Interfaces of those modules
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include file paths or code snippets — they go stale fast.

## Testing Decisions

- What makes a good test here (external behavior only, not implementation details)
- Which modules will be tested
- Prior art in the codebase (similar tests we'll mirror)

## Out of Scope

What is explicitly NOT being addressed.

## Further Notes

Anything else worth capturing.
```

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-prd) — 05-21-26. Adapted: destination defaults to `docs/prd/` filesystem path when GitHub isn't configured, and always logs to Andy's Activity Log.

## Integrates with
- `03 - Skills & Rules/Skills/to-issues.md` — break the PRD into vertical-slice tickets
- `03 - Skills & Rules/Rules/playbook-request.md` — playbook for new work that consumes this PRD
- `03 - Skills & Rules/Rules/engineering-doctrine.md` — research-first, no speculative features
