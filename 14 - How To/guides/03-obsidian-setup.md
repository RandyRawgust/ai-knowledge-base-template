---
type: guide
order: 4
created: 05-17-26
tags: [how-to, obsidian, plugins, css, setup]
---

# Obsidian Setup — Plugins, Snippets, Theme

The community plugins and CSS snippets that turn vanilla Obsidian into the AI OS interface. **11 plugins + 2 CSS snippets + 1 theme.** Each one earns its place: this list is intentionally lean, not a kitchen sink.

The sibling canvas [[obsidian-setup.canvas]] gives the visual grouping by purpose.

## Theme

| Setting | Value | Why |
|---|---|---|
| `cssTheme` | **GitHub Theme** | Clean, code-friendly, plays well with both light and dark modes. Familiar typography. |

Configured in `.obsidian/appearance.json`. Switch via **Settings → Appearance → Theme**.

## Plugins (11)

Grouped by purpose. All are community plugins installed from the Obsidian Community Plugins gallery.

### Doctrine & metadata layer

These plugins power the vault's "thinking" surface — frontmatter, queries, templates, the things that make the markdown act like a database.

| Plugin | Author | What it does | Why it's here |
|---|---|---|---|
| **Templater** | SilentVoid | Handlebars-like templating. Dynamic frontmatter, date variables, scripts inside templates. | Every note created from `04 - Templates/` uses Templater. Daily note auto-frontmatter, project README skeletons, lesson trackers — all driven by Templater syntax. |
| **Meta Bind** | Moritz Jung | Interactive inline input fields, metadata displays, buttons inside notes. | Dashboard widgets. Status togglers. Inline frontmatter editors without leaving the note. |
| **Dataview** | blacksmithgu | Query notes by frontmatter as if they were a database. Tables, lists, calendars. | Dashboard.md, Projects-Index.md, the agent-status tables — all Dataview queries. Without this, the vault is just markdown; with it, it's a live application. |
| **Folder Notes** | Lost Paul | Each folder can have an "index" note that opens without collapsing the folder. Notion-style. | Every tier folder (`00 - Chats/`, `02 - Projects/`, etc.) has a README that Folder Notes makes feel like the folder *itself*. Cleaner navigation than vanilla Obsidian. |
| **Iconize** | Florian Woelki | Add icons to files, folders, and text. | Visual scan anchor — folder icons in the sidebar mirror the tier colors from the CSS snippets. Tier 0 folders get one icon family, Tier 1 another, etc. |

### Visual surfaces

The plugins that put non-text content into the vault — drawings, boards, embedded web apps, calendars.

| Plugin | Author | What it does | Why it's here |
|---|---|---|---|
| **Excalidraw** | Zsolt Viczian | Sketch tool inside Obsidian. Whiteboards, diagrams, hand-drawn flows. Files are markdown + embedded JSON, so they stay text-only. | The capture surface in the [[04-brainstorm-to-project|brainstorm → project lifecycle]]. Fastest way to externalize a half-formed idea. Files land in `21 - Excalidraw/`. |
| **Base Board** | Michael DeRazon | Kanban boards backed by frontmatter properties. Cards = notes; columns = property values; drag-and-drop. | Project workflow tracking without leaving Obsidian. Beats Trello for things that already live as notes. |
| **Custom Frames** | Ellpeck | Embed web apps as Obsidian panes via iframes. Includes presets for Google Keep, Todoist, etc. | Reserved for embedding lightweight web tools alongside notes. Used historically for the localhost:8080 Command Center (retired); now mostly for calendar/inbox-style embeds. |
| **Google Calendar** | YukiGasai | Two-way Google Calendar integration. Events appear inline in notes; events can be created from Obsidian. | Daily Note shows today's calendar inline. Bridges the "what's happening when" gap between vault planning and external scheduling. |

### Terminal & code

| Plugin | Author | What it does | Why it's here |
|---|---|---|---|
| **Open in Terminal** | ChenFeng | Open the vault in an external terminal, launch CLI tools, run quick git commands from Obsidian. | The bridge to PowerShell. Right-click any folder → "Open in Terminal" → PowerShell opens at that path. Enables running scripts from `22 - Scripts/` directly from sidebar context. |
| **oterm** | mgriffen | Full terminal emulator inside Obsidian via xterm.js + node-pty. PowerShell, WSL, zsh, tmux, CLI tools. | When you want the terminal *inside* the vault window instead of a separate app. Heavier than Open in Terminal but doesn't context-switch. |

## CSS snippets (2)

Both enabled in `.obsidian/appearance.json` under `enabledCssSnippets`. Source at `.obsidian/snippets/`.

### `Colored Sidebar Items.css` (CyanVoxel v2.0.0)

The base snippet. Applies color formatting to folder names in the sidebar based on numbered prefix. Comes with ~13 color variables (mint, cyan, light-blue, blue, violet, magenta, etc.) and a default prefix mapping (00→mint, 01→cyan, 02→light-blue, …).

| Prefix range | Color family (default) |
|---|---|
| `00`–`06` | Tier 1 cool colors (mint → cyan → blue → violet → magenta) |
| `99` | Cool-gray (archive) |

Source: [CyanVoxel's Obsidian-Colored-Sidebar repo](https://github.com/CyanVoxel/Obsidian-Colored-Sidebar) (the `LICENSE` and `README.md` in `.obsidian/snippets/` are from this upstream).

### `Tier Extensions.css` (Andy's extension)

Extends the base snippet with this vault's tier system: warm colors for Tier 2 reference, yellow-green for Tier 2 output, archive for Tier 99.

| Prefix range | Color | Tier | Folder examples |
|---|---|---|---|
| `10`–`14` | Red → red-orange → orange → amber → gold | Tier 2 (Reference) | `10 - Topics/`, `11 - Sources/`, `12 - Software Map/`, `13 - Courses/`, `14 - How To/` |
| `20`–`21` | Yellow / lime | Tier 2 (Output) | `20 - Decks/`, `21 - Excalidraw/` |
| `22` | (inherits) | Tier 2 (Utility) | `22 - Scripts/` |

Reuses the color variables from the base snippet, adds one new variable (`--gold`). Degrades gracefully if the base snippet isn't loaded — folders just stay default text color.

## Why this stack (and not other plugins)

The vault is *intentionally lean*. Each plugin solves a specific problem the AI OS depends on:

- **Dataview** is non-negotiable — half the doctrine is queries against frontmatter
- **Templater** is non-negotiable — every new note expects its frontmatter to auto-populate
- **Excalidraw** is the capture surface
- **Iconize + the 2 CSS snippets** are the visual layer that makes the tier system legible at a glance
- **Open in Terminal + oterm** bridge to the PowerShell side

Plugins NOT in here, intentionally:

- **Calendar** (date-picker) — Daily Notes filenames are ISO-dated; the Files sidebar sorts them correctly without needing a calendar widget
- **Tasks** — Andy's task model is light (top-3 + anti-todo in the daily note); a full task plugin would be overkill
- **Kanban** (the popular one) — Base Board does the same job from frontmatter, integrating with Dataview queries
- **Many of the "you should install this!" plugins** — each one adds maintenance + drift potential; the bar is "does this earn its place in the doctrine?"

If a plugin doesn't pull weight in CLAUDE.md or a workflow, it doesn't belong. Reassess yearly.

## Fresh-install checklist

For a clean machine, after cloning the vault:

1. **Install Obsidian** from https://obsidian.md
2. **Open the vault** — point Obsidian at `E:\Projects\AI Knowledge Base\`
3. **Trust the vault** — Obsidian will ask; say yes
4. **Enable Community Plugins** — Settings → Community plugins → toggle off Restricted mode → Browse
5. **Install each plugin** from the table above. The vault's `.obsidian/community-plugins.json` lists exactly which ones to enable; Obsidian will only show enabled ones once installed. To bulk-install: open each plugin in the marketplace, click Install, then Enable.
6. **Set the theme** — Settings → Appearance → Theme → search "GitHub Theme" → install + apply
7. **Enable CSS snippets** — Settings → Appearance → CSS snippets → reload → toggle on `Colored Sidebar Items` and `Tier Extensions`

Order matters slightly: Dataview before any folder containing Dataview queries opens (otherwise they'll show errors until the plugin loads); Excalidraw before opening any `21 - Excalidraw/` files (same reason).

For a friend setting up the shareable template, the [[~~bootstrap-for-new-user.ps1~~|bootstrap script]] (Phase 4) handles the Claude Code runtime side; the Obsidian side is this list.

## Related

- [[01-system-overview]] — what the AI OS is and how the pieces relate
- [[05-vault-index]] — full catalog of every entity (folders, files, agents, rules, etc.)
- [[22 - Scripts/README|Scripts README]] — the PowerShell scripts that pair with Open in Terminal
- [[Dashboard]] — the Dataview-driven landing page these plugins make possible
