---
type: guide
order: 2
created: 05-17-26
tags: [how-to, brainstorm, project, lifecycle]
---

# Brainstorm → Project Lifecycle

How an idea travels from "what if" to "I'm working on it." Seven stages. Everything happens in Claude Desktop — Cowork chat for conversation, Claude Code for terminal work, occasionally Claude in Chrome for browsing. Obsidian is the canvas the work lands on.

## Stage 1 — Capture in Excalidraw

Open Obsidian. `Ctrl+P → Excalidraw: Create new drawing`. Sketch the idea as fast as the hand will move. No structure, no judgment. Stick figures, arrows, boxes, words that came to mind. The point is to externalize the shape of the thought.

File auto-lands in `21 - Excalidraw/` as a markdown file with embedded JSON. It's text, not a binary.

If it's a non-visual idea — a thought, a sentence, a quote that triggered something — open today's daily note in `01 - Daily Notes/` and write it down. Same purpose, different surface.

## Stage 2 — Talk it through with Cowork

Open Cowork. Attach the Excalidraw export (or just describe it in text). Start a conversation:

- "What is this, in one sentence?"
- "Who would use this / why would I make this?"
- "What's the smallest version that's still interesting?"
- "What's already in the vault that connects to this?"

The goal is to find out whether the idea has structural weight or just emotional weight. Both are valid signals; only one becomes a project.

Let Claude push back. If Cowork thinks the idea is incomplete or reinvents something already on disk, that's free intel.

## Stage 3 — Decide

Worth pursuing? Yes → continue to Stage 4. No → leave the Excalidraw drawing as a captured idea. Future-you might come back to it. Past-you would have lost it.

Decision criteria worth checking against:
- Is there a clear "done" state? (or is this open-ended exploration?)
- Does it fit a category in the [[Projects-Index]]?
- Does it block / depend on / replace an existing project?

## Stage 4 — Pick the home on disk

Use the [[5S_STANDARD]] drive map:

- **Non-game project** → `E:\Projects\<name>\`
- **Game dev project** → `F:\Game Dev\Projects\<name>\`
- **Course** → `E:\Projects\Courses\<name>\` (course-as-project convention)
- **Utility / tool that operates against the vault** → `E:\Utilities\<name>\`

Create the folder structure. The fast way:

```powershell
.\"22 - Scripts"\git-bootstrap.ps1 -Path "E:\Projects\<name>" -Name "<repo-name>"
```

That gets you a git repo, `.gitignore`, and `README.md` skeleton. Adjust as needed.

Or skip git entirely if it's pre-decision exploration. You can `git init` later when the project earns it.

## Stage 5 — Vault directory note

In `02 - Projects/<Category>/`, create `<Project Name>.md`. The fast way: copy `04 - Templates/Project README.md` to that location and fill in the frontmatter.

Required frontmatter:

```yaml
---
type: project
status: active
category: <game-dev | dev-projects | kerbal | misc | planet-coaster>
created: <MM-DD-YY>
path: <absolute on-disk path>
tags: []
---
```

Optional but useful for Dataview:

```yaml
skills: []     # which skills the project uses (e.g. [pptx, docx])
rules: []     # which rules apply (e.g. [course-format, vault-conventions])
agents: []    # which specialists own work in this project
```

Body sections (per [[03 - Skills & Rules/Rules/project-readme|project-readme rule]]):

1. Title + one-paragraph description
2. **Path** — markdown link to the on-disk folder (`[label](file:///E:/Projects/...)`)
3. **Stack** — wikilinks to [[12 - Software Map|software map]] nodes
4. **Touches** — directories the project reads/writes (file:// links to drive locations)
5. **Status** — current state, blockers, next milestone
6. **Related** — sibling projects, topics
7. **Notes** — anything else

## Stage 6 — Make it discoverable

The Dashboard's "Active projects" Dataview will pick the new note up automatically. Verify by opening `Dashboard.md` (or `_Command Center.canvas` — same data).

If the project uses software you already have in `12 - Software Map/`, add a wikilink from the software note → the project. If the project relates to an existing topic in `10 - Topics/`, add a wikilink there too. The graph view will start showing the connections.

## Stage 7 — Work the project

Open Cowork in the project context. Two patterns:

1. **Project as the working surface.** Run `cd <on-disk path>` in Cowork's terminal, or open Claude Code there. The project's own `README.md` and `CLAUDE.md` (if it has one) tell Claude what skills, rules, and agents apply. Work happens on disk. The vault note gets updated occasionally with status/milestones.

2. **Vault as the working surface.** For projects that are mostly *about* organizing thinking (not building code/assets), the vault note + linked topics IS the project. The on-disk path may not exist or may be minimal.

Either way: the vault note is the index entry. The on-disk path is the warehouse.

## Anti-patterns

- **Don't put assets in `02 - Projects/<Category>/<Name>/`.** That folder holds the directory note `<Name>.md`. Period. Code, assets, handoffs, screenshots → on-disk path.
- **Don't skip the brainstorm capture.** Even if it seems silly. The Excalidraw is cheap; losing the idea is expensive.
- **Don't create the vault directory note before the on-disk folder.** The `path:` frontmatter must point to something real, or `python "22 - Scripts/audit-projects.py"` will flag it as an orphan.

## See also

- [[01-system-overview]] — how the whole system fits together
- [[5S_STANDARD]] — drive map + naming conventions
- [[Projects-Index]] — full list of active and dormant projects
- [[03 - Skills & Rules/Rules/project-readme]] — README format spec
- [[04 - Templates/Project README]] — the template to copy
