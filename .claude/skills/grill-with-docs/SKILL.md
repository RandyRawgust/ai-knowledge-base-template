---
name: grill-with-docs
description: Grilling session that challenges a plan against the existing domain model, sharpens terminology, and updates CONTEXT.md and ADRs inline as decisions crystallise. Use when Andy wants to stress-test a coding plan against the project's domain language and documented decisions. Code-side counterpart to the brainstormer specialist.
---

# Grill With Docs

Interview Andy relentlessly about every aspect of this plan until you reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions **one at a time**, waiting for feedback on each before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

## When to use
Triggers: `grill me on this plan`, `stress-test the design`, `challenge my approach`, `walk the design tree`, `make sure we agree on the model`.

Use this skill for **code/architecture** plans where alignment with project vocabulary matters. For looser, non-code "is this idea worth doing" sessions, use the `brainstorm` skill instead — that one delegates to the brainstormer specialist and saves to `00 - Chats/brainstorms/`.

## Domain awareness

During codebase exploration, also look for existing documentation:

### File structure

Most repos have a single context:

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

If a `CONTEXT-MAP.md` exists at the root, the repo has multiple contexts:

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← context-specific decisions
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

Create files **lazily** — only when you have something to write. If no `CONTEXT.md` exists, create one when the first term is resolved. If no `docs/adr/` exists, create it when the first ADR is needed.

## During the session

### Challenge against the glossary
When Andy uses a term that conflicts with existing language in `CONTEXT.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

### Sharpen fuzzy language
When he uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account' — do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios
When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force precision about the boundaries between concepts.

### Cross-reference with code
When he states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible — which is right?"

### Update CONTEXT.md inline
When a term is resolved, update `CONTEXT.md` right there. Don't batch — capture as it happens.

CONTEXT.md format (compressed):
```markdown
# <Project> Domain Glossary

## <Term>
One-sentence definition in the user's language. Then a paragraph for edge cases, neighbours, and what this is NOT.

## <Next term>
...
```

Don't couple `CONTEXT.md` to implementation details. Only include terms that are meaningful to domain experts.

### Offer ADRs sparingly

Only offer to create an ADR when all three are true:
1. **Hard to reverse** — the cost of changing your mind later is meaningful
2. **Surprising without context** — a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR.

ADR format (compressed):
```markdown
# ADR-<NNNN>: <Title>

**Status.** Accepted | Superseded by ADR-<n> | Rejected

**Context.** What were we trying to solve?

**Decision.** What did we choose?

**Consequences.** What did we trade off?

**Alternatives considered.** Briefly — what we ruled out and why.
```

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs) — 05-21-26. Helper files (CONTEXT-FORMAT.md, ADR-FORMAT.md, DOMAIN-AWARENESS.md) summarised inline.

## Integrates with
- `03 - Skills & Rules/Agents/Specialists/brainstormer.md` — non-code analog (vault-side ideation)
- `03 - Skills & Rules/Skills/to-prd.md` — typical downstream once the design is grilled clean
- `03 - Skills & Rules/Skills/improve-codebase-architecture.md` — shares the same grilling loop in step 3
- `03 - Skills & Rules/Rules/style-no-sycophancy.md` — must be on for grilling to work

## Relationship to brainstormer specialist
The `brainstorm` skill (Writer dept) handles "is this idea worth doing" — wide, conceptual, often outside code. `grill-with-docs` handles "is this design consistent with the code we have" — narrow, code-grounded, ends with CONTEXT.md and ADR updates. Different tools, no overlap.
