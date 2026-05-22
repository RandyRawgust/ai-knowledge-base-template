---
type: index
created: 2026-05-08
---

# Topics

This is the Karpathy-wiki layer — research notes, compiled understanding,
reference material that the LLM helps maintain.

## How it works

- One markdown file per topic. Filename is the topic.
- Frontmatter sets `type: topic` and tags.
- Body is structured: short summary → key facts → links → sources.
- You drop raw material into `11 - Sources/`, then ask Claude to compile a topic
  note from those sources.
- Topic notes can wikilink to each other and to `12 - Software Map/` notes.

## Suggested first topics

Start with topics where you already have scattered knowledge:

- `KSP-physics.md` — orbital mechanics, dV math, real-world refs
- `Video-editing-pipeline.md` — your render flow, codec choices
- `Lean-5S.md` — applied to your filesystem
- `Obsidian-graph.md` — how this vault works (meta!)

## File template

When creating a new topic note, use this skeleton:

```markdown
---
type: topic
tags: [kerbalism, orbital-mechanics]
created: 2026-05-08
sources: [[11 - Sources/some-source]]
---

# Topic Title

## Summary

(1-3 sentences, the gist)

## Key facts

-

## Related

- [[other-topic]]
- [[12 - Software Map/some-software]]

## Sources

-
```
