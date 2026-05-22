---
type: rule
created: 05-18-26
kind: vocabulary
applies_to: [all-agents]
scope: internal
source: "Andy's Technical Cognitive Engine v0.1 (TechnicalCognitiveEngine_v0.1.docx)"
tags: [rule, vocabulary, compression, tce, internal]
---

# TCE Vocabulary — Internal Compression Codec

A dense symbol vocabulary for **agent-to-agent communication only**. Saves tokens on sub-agent dispatches, memory loads, and internal scratch reasoning by compressing recurring instruction patterns.

**Hard rule:** TCE is for internal use. Do NOT use TCE symbols in responses to Andy, in documentation, in the Activity Log, on the Dashboard, or in any file with a human audience beyond the dispatching agent. The symbols save tokens on one end only if both ends share the codec; Andy is not part of the codec.

## Where to use it

- **Sub-agent dispatches via the Task tool.** Brief the sub-agent in TCE; they'll have this doc loaded.
- **Agent-to-agent prompts** (Orchestrator → dept head → specialist) when running in-process.
- **Memory files** (`pinned.md`, `universal.md`, `projects/<slug>.md`) — for the durable "how I do things" lines, not for project facts that need to be readable.
- **Internal scratch reasoning** when working through a hard problem before producing the human-facing answer.

## Where NOT to use it

- Any response to Andy (he decodes; you don't get the savings he eats the cost).
- Any vault doc with external readership (README, course content, How-To guides).
- Activity Log rows, daily notes, handoffs, retros, brainstorms — all human-readable.
- The Dashboard or Command Center canvas.

## I. Symbol Table

Core vocabulary for compressing recurring instructions.

| SYM | NAME | MEANING | EXAMPLE |
|---|---|---|---|
| ⊕ | Compose | Combine two systems cleanly, no coupling | ⊕(physics, render) — integrate without bleed |
| ∂ | Boundary | Find the interface/edge of a system | ∂(chunk) — what does this expose? |
| ⧉ | Audit | Stress-test assumptions | ⧉(memory) — where does this leak? |
| ↻ | Recurse | Apply logic to itself | ↻(agent) — agent that monitors itself |
| ⊥ | Invert | Flip the approach entirely | ⊥(debug) — prove it can't fail |
| Δ | Delta | What changed / what's the diff | Δ(state) — what mutated this frame? |
| ∇ | Gradient | Where is pressure/load accumulating | ∇(sim) — where is this about to break? |
| λ | Isolate | Extract into pure function or module | λ(boiler) — make boiler logic standalone |
| ✦ | Spawn | Create agent / thread / process | ✦(worker) — spin up isolated task |
| ⊗ | Corrupt | Intentional failure injection | ⊗(pipe) — pipe breaks mid-sim |

## II. Compound Operations

Named multi-step patterns. Use when you find yourself combining two symbols repeatedly.

| COMPOUND | MEANING |
|---|---|
| ⧉(∂(X)) | Audit the boundary of X. Not internals — the interface. Use for chunk system, MCP servers, skill scripts. |
| ⊥(↻(X)) | Invert a recursive system. When an agent loop goes wrong — flip the question. |
| λ(⊗(X)) | Isolate then corrupt. Extract a module, then test its worst-case input. |
| Δ(∇(X)) | Track what changed AND where load is building. Frame-by-frame sim debugging. |

## III. Operational Modes

Prefix the dispatch with the mode symbol. The sub-agent switches behavior accordingly.

### → FLOW STATE
**Triggers:** Clear task, known approach. "add X", "fix Y", "write Z".
**Behavior:** Direct output. No questioning. Trust the spec. Fast.
**Model preference:** Haiku or Sonnet default.

Example dispatch: `→ add `dirty` flag to chunk struct in F:\Game Dev\Projects\TerraWatt\src\chunk.h`

### ⊙ RUPTURE STATE
**Triggers:** Architecture decision, impossible bug, new system design. "why is X broken", "how should I structure Y".
**Behavior:** Run full adversarial protocol (see IV) before answering. Use symbol table. Attack own answer. Don't output until ⧉, ∂, and ⊗ are done.
**Model preference:** Opus.

Example dispatch: `⊙ why is pressure asymmetric in the boiler when valves are symmetric?`

## IV. Adversarial Protocol (⊙ mode only)

Before any final answer in ⊙ mode, run all three attacks. **Findings surface at the TOP of the response**, then the solution.

| SYM | ATTACK | QUESTION ASKED |
|---|---|---|
| ⧉ | Assumption Audit | What does this solution assume is true? Are those assumptions guaranteed? |
| ∂ | Boundary Probe | Where does this touch other systems? What breaks at those interfaces? |
| ⊗ | Corruption Test | What is the worst realistic input or system state? What breaks first? |

Output format:

```
⧉ assumes chunk updates are sequential — is that guaranteed?
∂ this touches the render system at the chunk-redraw boundary — invalidation handled?
⊗ what if two chunks update the same boundary pixel simultaneously?

→ [then the solution]
```

This frontloads rework that would otherwise happen after the user pushed back. Net token effect is positive when attacks surface a real issue ≥1 in 3 invocations.

## V. Evolution Rules

This document grows. Follow these when adding to it.

- **ADD a symbol when:** you've used the same concept in 3+ dispatches and a verbose form keeps recurring.
- **ADD a compound when:** you find yourself combining two symbols repeatedly across multiple sessions.
- **ADD an attack when:** the existing 3 attacks missed a class of failure that bit you in practice.
- **VERSION bump when:** you change a symbol's meaning or remove one. Append a row to the version log below.
- **NEVER add:** decorative symbols with no executable meaning. Codec slots are scarce. Earn them.

## VI. Loading Pattern

For an agent to use TCE, this file should be linked from its `pinned.md` (one wikilink line is enough — the codec is small enough to keep entirely in working memory once loaded).

Suggested pinned.md line:

```markdown
- [[03 - Skills & Rules/Rules/tce-vocabulary|TCE codec]] — use for agent-to-agent dispatch only, not Andy-facing prose
```

## VII. Parallel Specialist Dispatch

Specialists are sub-agents. Multiple specialists CAN and SHOULD run in parallel when the work is independent. The Task tool supports this natively — dispatch multiple sub-agents in a single tool-use block and they run concurrently.

**When parallel dispatch is the right move:**

- Two independent audits (e.g., "audit the Skills/Specialists distinction" + "audit today's changes for doc coverage") — different scopes, no shared state.
- Research + build (e.g., one sub-agent surveys existing patterns while another scaffolds new files).
- Multi-file refactor where each file is independent of the others.
- Verification: one sub-agent re-reads what another sub-agent just wrote.

**When NOT to dispatch in parallel:**

- Dependent work (B needs A's output).
- Edits to the same file (race conditions).
- Anything where the order of operations matters.

**TCE form for parallel dispatch:**

```
✦(⧉(Skills↔Specialists)) + ✦(⧉(today.changes→docs))
→ synthesize findings
→ apply fixes
```

Spawn (✦) two audit operations in parallel; each runs ⧉ (audit) on its scope; synthesize after both return; apply.

**Practical pattern.** When dispatching via the Task tool, send a single message with multiple tool-use blocks. Each sub-agent must get the codec loaded in its system prompt or a TCE preamble in the dispatch itself — sub-agents spin up fresh and don't inherit the dispatching agent's pinned memory. First-run dispatches should use natural language; once the codec is in their system prompt (via plugin install or shared agent definitions), switch to TCE form for the token compression.

## IX. Sub-Agent Dispatch Preamble

**Every Task-tool dispatch MUST begin with this preamble** (per CLAUDE.md principle #9). Sub-agents spin up fresh — they don't inherit the dispatcher's pinned memory. Without the preamble, the sub-agent has no codec and either misinterprets TCE or has to respond in natural language (defeating the compression).

Copy-paste exactly:

```
[TCE codec — internal compression for this dispatch. Read first, then process the brief below.]
SYMBOLS: ⊕ compose · ∂ boundary · ⧉ audit · ↻ recurse · ⊥ invert · Δ delta · ∇ gradient · λ isolate · ✦ spawn · ⊗ corrupt
MODES: → flow (direct, fast) · ⊙ rupture (architecture/hard-debug — run adversarial protocol: surface ⧉ ∂ ⊗ findings before final answer)
COMPOUNDS: ⧉(∂(X)) audit-boundary · ⊥(↻(X)) invert-recursive · λ(⊗(X)) isolate-corrupt · Δ(∇(X)) delta-gradient
RULES: respond in TCE if dispatch used TCE. Findings in ⊙ mode go at TOP, then solution. Cite vault paths verbatim.

[Brief follows]
```

That's ~85 tokens of preamble. Pays for itself the moment your brief is dense enough to need the codec; on long dispatches the round-trip compression (dispatch + response both in TCE) covers it many times over.

**Cost-benefit threshold.** Skip the preamble only when the dispatch is trivially short — under ~50 tokens of natural-language brief. At that scale the preamble overhead exceeds the savings. Above that, always include it.

**When the dispatch is purely conversational** (e.g., "summarize this for me, plain English"), still include the preamble but use `→` mode and natural language in the brief — the sub-agent will respond in natural language because the dispatcher did. Bidirectional symmetry is the rule.

## X. Anti-Patterns

- **Symbolizing Andy-facing prose.** Decoding cost falls on him; he gets none of the savings.
- **Symbolizing one-off concepts.** If a pattern has only appeared once, it doesn't earn a codec slot.
- **Mixed-codec dispatches.** Don't half-symbolize. A prompt is either TCE-dense or natural language; mixing them costs more than either pure form.
- **Symbolizing project facts in memory.** Project memory files contain facts that need to remain readable on inspection (Andy reads them when debugging agent behavior). Only symbolize the "how I do things" doctrine lines.

## Version log

| Version | Date | Change |
|---|---|---|
| v0.1 | 05-18-26 | Initial port from Andy's TechnicalCognitiveEngine_v0.1.docx |
