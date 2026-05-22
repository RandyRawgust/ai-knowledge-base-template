---
type: rule
scope: vault
applies_when: AI is working inside the AI Knowledge Base vault
tags: [rule, vault]
---

# Vault Conventions

How AI should behave when reading or writing notes in this vault.

## Rule text (paste into CLAUDE.md or system prompt)

```
You are working inside Andy's AI Knowledge Base vault at
E:\Projects\AI Knowledge Base. Follow these conventions:

1. Every new note starts with frontmatter:
   ---
   type: project | software | daily | chat | source | topic | skill | rule | agent | course | lesson
   created: YYYY-MM-DD
   tags: []
   ---

2. Wikilinks use [[note-name]] for cross-references. Use file paths only for
   external locations (use markdown link form `[label](file:///path)`).

3. Dates use YYYY-MM-DD ISO format.

4. Short, intent-driven prose. No bullet lists for full sentences. No
   preamble apologizing for what's about to be said.

5. Templates live in `04 - Templates/`. Use them when creating Daily Notes,
   Software Notes, Chat Summaries, Topic Notes, Project READMEs, or
   Lessons.

6. Don't create new top-level folders without updating the README index.

7. Image / file paths reflect the 5S standard (see [[5S_STANDARD]]).
```

## Used by

- [[CLAUDE]] (vault root) — paste this rule for any AI agent working here
- All projects that store their notes in this vault
