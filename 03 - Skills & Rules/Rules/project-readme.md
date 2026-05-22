---
type: rule
scope: projects
applies_when: AI is creating or updating a project README
tags: [rule, projects]
---

# Project README Format

How every project README should look — for both vault project notes and
in-folder `README.md` files at the actual project location.

## Where things live (important)

There are TWO project README surfaces, and they serve different roles:

| Surface | Path | Purpose |
|---|---|---|
| **Vault directory-pointer** | `02 - Projects/<Category>/<Project>.md` | Tells the vault what the project is, where it lives, status. Lean. No code, no assets, no handoffs. |
| **On-disk project README** | `<path-in-frontmatter>/README.md` | The actual project's own README — at `E:\Projects\<project>\` or `F:\Game Dev\Projects\<project>\`. Code, assets, working files live here. |

Both files use the same frontmatter pattern below. The difference is what goes in the body. **The vault note is a pointer, not a storage location.** If you find code, screenshots, exports, or session handoffs inside `02 - Projects/`, move them to the project's on-disk path and leave only the pointer note behind.

## Frontmatter

```yaml
---
type: project
status: active | paused | dormant | completed | archived
category: game-dev | ksp-themed | creative | meta | web | other
created: YYYY-MM-DD
updated: YYYY-MM-DD
path: <absolute path to project folder>
skills: [list-of-skill-slugs]
rules: [list-of-rule-slugs]
agents: [list-of-agent-slugs]
tags: []
---
```

## Body sections (in this order)

1. Title (h1)
2. One-paragraph what-is-this
3. `## Path` — markdown file:// link to the actual project folder
4. `## Stack` — wikilinks to software map nodes
5. `## Touches` — directories the project reads/writes (file:// links)
6. `## Status` — current state, blockers, next milestone
7. `## Related` — wikilinks to sibling projects, topics
8. `## Notes` — anything else

## Used by

- All notes in `02 - Projects/` folder
- The `README.md` in each project's actual folder (when authored)
