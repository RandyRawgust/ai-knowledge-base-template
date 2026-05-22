---
name: compile-topic
description: Invoke topic-compiler specialist to synthesize a Karpathy-style topic note from raw sources in 11 - Sources/. Use when Andy says compile a topic, build a topic note, summarize sources on X, make a primer on Y, what do I know about Z.
---

# Compile Topic

Wrapper for [[03 - Skills & Rules/Agents/Specialists/topic-compiler|topic-compiler specialist]]. Builds a coherent topic note in `10 - Topics/` from raw clipped sources.

## When to use
Triggers: `compile a topic`, `build a topic note`, `summarize sources on X`, `make a primer on Y`, `what do I know about Z`, `synthesize these sources`.

## Load
- `03 - Skills & Rules/Agents/Specialists/topic-compiler.md` - canonical spec
- `11 - Sources/` - raw inputs (Web Clipper destination)
- An existing topic note as style reference: pick any from `10 - Topics/AI/` or related domain
- `03 - Skills & Rules/Agents/memory/Archivist/universal.md` - Karpathy-wiki tone

## Confirm inputs
1. Topic name (becomes file slug)
2. Source list - paths, a glob like `11 - Sources/2026-05-*`, or "everything tagged X"
3. Audience - just-me notes vs. shareable explainer
4. Domain folder under `10 - Topics/` (AI, Game Dev, etc.) - create if doesn't exist

## Run
1. Flip topic-compiler to `status: active`
2. Read every source. Extract key claims, definitions, examples, contradictions.
3. Group by sub-theme. Identify the spine of the topic (3-5 main sections).
4. Draft the note in Karpathy style: dense, linked, definitions inline, examples concrete, no fluff.
5. Cite each source via `[[11 - Sources/<file>]]` wikilinks. Every non-obvious claim cites.

## Output
`10 - Topics/<Domain>/<topic-slug>.md` with frontmatter:

```yaml
---
type: topic
created: <MM-DD-YY>
domain: <Domain>
sources: [<list of source wikilinks>]
status: draft | reviewed
tags: [topic, <domain-tag>]
---
```

Body sections: intro, main concepts (each subsectioned), open questions, related topics, sources.

## After
1. Cross-link from related existing topic notes
2. Append Activity Log row
3. Flip topic-compiler to `status: idle`
4. Provide `[Open topic note](computer://...)` link

## Don't
- Don't write from training knowledge alone - this is source-grounded synthesis
- Don't skip contradictions between sources - surface them, don't paper over
- Don't make it longer than the sources warrant - density beats length
- Don't auto-tag - tags are Andy's call