---
type: index
created: 2026-05-08
---

# Software Map

The graph layer: each note is one piece of software, linked to the
directories it touches and the projects it powers. Obsidian's **Graph
View** turns this into the visual map you described
("DaVinci → editing projects, assets, music").

## How to use it

1. For each significant piece of software you use, copy `_template.md` to
   `<software-name>.md` and fill in the fields.
2. In the body, wikilink to other software, topics, and project notes.
3. For directories the software touches, link them as markdown file paths
   like `[E:\Videos](file:///E:/Videos)` so Obsidian can open them in
   Explorer.
4. Open the **Graph View** (left sidebar icon, or Ctrl+G) to see the picture.

## Filtering by category

Once Dataview is installed:

```dataview
TABLE category, installed, last_used
FROM "12 - Software Map"
WHERE type = "software"
SORT category, file.name
```

## Master index

[[Software Index]] is the single-page roll-up of everything installed on
the machine (built from `_scan-installed.ps1`, merged with the per-software
notes here). Start there if you want to see the full inventory; come back
to this folder for per-software detail pages.

## Per-software notes (with full directories-and-projects detail)

- [[davinci-resolve]] — video editing, the example showing the link pattern
- [[obsidian]] — meta: Obsidian itself
- [[cowork]], [[claude-code]], [[cursor]], [[codex]], [[hermes]] — AI tools
- [[git]], [[python]] — dev tools
- [[godot]] — game engine
- [[obsidian-canvas]] — vault visual planning
