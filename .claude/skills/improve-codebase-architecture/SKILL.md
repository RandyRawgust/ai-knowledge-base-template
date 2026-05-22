---
name: improve-codebase-architecture
description: Find deepening opportunities in a codebase, informed by domain language and ADRs. Use when Andy wants to improve architecture, find refactoring opportunities, consolidate tightly-coupled modules, or make a codebase more testable and AI-navigable. Run periodically to keep entropy in check.
---

# Improve Codebase Architecture

Surface architectural friction and propose **deepening opportunities** — refactors that turn shallow modules into deep ones. The aim is testability and AI-navigability.

## Glossary

Use these terms exactly in every suggestion. Consistent language is the point — don't drift into "component," "service," "API," or "boundary."

- **Module** — anything with an interface and an implementation (function, class, package, slice)
- **Interface** — everything a caller must know to use the module: types, invariants, error modes, ordering, config. Not just the type signature.
- **Implementation** — the code inside
- **Depth** — leverage at the interface: a lot of behaviour behind a small interface. **Deep** = high leverage. **Shallow** = interface nearly as complex as the implementation.
- **Seam** — where an interface lives; a place behaviour can be altered without editing in place. (Use this, not "boundary.")
- **Adapter** — a concrete thing satisfying an interface at a seam
- **Leverage** — what callers get from depth
- **Locality** — what maintainers get from depth: change, bugs, knowledge concentrated in one place

### Key principles

- **Deletion test**: imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across N callers, it was earning its keep.
- **The interface is the test surface.**
- **One adapter = hypothetical seam. Two adapters = real seam.**

This skill is *informed* by the project's domain model. The domain language (in `CONTEXT.md`, README, or vault notes) names good seams; ADRs (in `docs/adr/`) record decisions the skill should not re-litigate.

## Process

### 1. Explore

Read the project's domain glossary and any ADRs in the area you're touching first.

Then walk the codebase. Don't follow rigid heuristics — explore organically and note where you experience friction:

- Where does understanding one concept require bouncing between many small modules?
- Where are modules **shallow** — interface nearly as complex as the implementation?
- Where have pure functions been extracted just for testability, but the real bugs hide in how they're called (no **locality**)?
- Where do tightly-coupled modules leak across their seams?
- Which parts of the codebase are untested, or hard to test through their current interface?

Apply the **deletion test** to anything you suspect is shallow: would deleting it concentrate complexity, or just move it? A "yes, concentrates" is the signal you want.

### 2. Present candidates

Present a numbered list of deepening opportunities. For each:

- **Files** — which files/modules are involved
- **Problem** — why the current architecture is causing friction
- **Solution** — plain English description of what would change
- **Benefits** — explained in terms of **locality** and **leverage**, and how tests would improve

Use CONTEXT.md (or README) vocabulary for the domain, and the glossary above for architecture. If `CONTEXT.md` defines "Order," talk about "the Order intake module" — not "the FooBarHandler," and not "the Order service."

**ADR conflicts**: if a candidate contradicts an existing ADR, only surface it when the friction is real enough to warrant revisiting the ADR. Mark it clearly: *"contradicts ADR-0007 — but worth reopening because…"* Don't list every theoretical refactor an ADR forbids.

Do NOT propose interfaces yet. Ask Andy: "Which of these would you like to explore?"

### 3. Grilling loop

Once he picks a candidate, drop into a grilling conversation. Walk the design tree with him — constraints, dependencies, the shape of the deepened module, what sits behind the seam, what tests survive.

Side effects happen inline as decisions crystallize:

- **Naming a deepened module after a concept not in CONTEXT.md?** Add the term to `CONTEXT.md`. Create the file lazily if it doesn't exist.
- **Sharpening a fuzzy term during the conversation?** Update `CONTEXT.md` right there.
- **Andy rejects a candidate with a load-bearing reason?** Offer an ADR, framed: *"Want me to record this as an ADR so future architecture reviews don't re-suggest it?"* Only offer when the reason would actually be needed by a future explorer — skip ephemeral reasons ("not worth it right now") and self-evident ones.

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/improve-codebase-architecture) — 05-21-26. Helper files (LANGUAGE.md, INTERFACE-DESIGN.md, CONTEXT-FORMAT.md, ADR-FORMAT.md) summarised inline.

## Integrates with
- `03 - Skills & Rules/Agents/Auditor.md` — Auditor runs this on a cadence to surface entropy
- `03 - Skills & Rules/Skills/zoom-out.md` — common upstream input
- `03 - Skills & Rules/Skills/diagnose.md` — common upstream input (post-mortems often surface architectural rot)
