---
type: rule
created: 05-17-26
updated: 05-17-26
applies_to: [all-agents]
tags: [rule, infrastructure, deprecation, drift]
---

# Superseded Infrastructure

Things that used to live in this system and have since been replaced, deleted, or repurposed. Agents read this when loading context so they don't accidentally reference dead infrastructure.

If you see a wikilink, path, or convention listed in the "old" column anywhere in a live document, that's drift. Flag it (drift-watcher does this automatically) or fix it.

## Folder paths

| Old (don't reference) | Current | When superseded |
|---|---|---|
| `Chats/`, `Daily Notes/`, `Projects/`, `Skills & Rules/`, etc. (unprefixed) | `00 - Chats/`, `01 - Daily Notes/`, `02 - Projects/`, `03 - Skills & Rules/`, etc. | 05-17-26 |
| `.scripts/` (vault dotfolder, brief hide attempt) | `22 - Scripts/` — returned to visible Tier 2 / utility location on 05-17-26 because PowerShell-integration changed the access pattern: scripts are tools Andy invokes interactively, not just runtime plumbing. README catalogs each one. | 05-17-26 |
| `02 - Projects/command-center/` (with code/assets) | `E:\Projects\Command Center\` (on disk); vault holds only the directory-pointer note | 05-17-26 |
| `E:\Projects\Command Center\` referenced as live (Python FastAPI dashboard, `command_center.py`, `localhost:8080`, `.\Start.ps1`) | `_Command Center.canvas` at vault root (native Obsidian canvas; no server, no Python, no JS) | 05-17-26 |
| `02 - Projects/command-center/NEXT-SESSION-HANDOFF.md` runbook | (none — Canvas CC has no runbook; the canvas itself is the runbook) | 05-17-26 |
| `13 - Courses/_template-course/` | `04 - Templates/_template-course/` | 05-17-26 |

## Files removed

| Old | Why | What replaced it |
|---|---|---|
| `_System Map.canvas` | Stale after prefix migration; overlapping conceptual + flow content | `14 - How To/system-overview.canvas` |
| `05 - Workflows/*.canvas` (4 files) | Auto-generated canvas mirrors were never used in practice; added maintenance burden | Workflow `.md` files only; visual flow lives in `14 - How To/` if needed |
| `05 - Workflows/command-center-deploy.md` | Deployed the retired Python Command Center; no deploy step exists for the canvas | (none — Canvas CC requires no deployment) |
| `12 - Software Map/_template.md` | Redundant — `04 - Templates/Software Note.md` is canonical | The `04 - Templates/` Software Note template |

## Conventions removed

| Old | Why | What now |
|---|---|---|
| Kaomoji in agent personas (`(•̀ᴗ•́)`, `눈_눈`, etc.) | Leaked as garbled UTF-8 in transcripts and tool output | Agent identity = name + color + role only |
| `face:` / `kaomoji:` frontmatter blocks in agent files | Same | Removed entirely |
| Binary files in vault (PNG, JPG, MP4, etc.) | Vault is text-only knowledge base | Reference via `file:///` link to on-disk location |
| Workflow `.canvas` sibling requirement | Generated files maintained without use | Workflows are markdown-only |
| GitHub handle `<YOUR-OLD-GH-HANDLE>` (in any new ref) | Wrong handle; correct is `<YOUR-GH-HANDLE>` | Use `<YOUR-GH-HANDLE>` everywhere. Old repo URL `github.com/<YOUR-OLD-GH-HANDLE>/ai-knowledge-base` may still exist as a redirect; treat it as drift in new docs. |

## Conventions superseded by sharper versions

| Old | Current |
|---|---|
| ISO `YYYY-MM-DD` everywhere | **Filenames** keep ISO `YYYY-MM-DD` (sortability); **frontmatter + prose** use `MM-DD-YY` |
| "Vault contains project notes" (ambiguous) | Vault `02 - Projects/<Category>/<Project>.md` holds the directory-pointer note ONLY. Code/assets/handoffs live on disk at the path in frontmatter `path:` |

## How agents use this rule

When forming a response that involves vault paths or system references:

1. If a referenced path matches anything in the "Old" columns above, treat it as drift — either silently translate to the current form OR surface it to Andy as a finding (drift-watcher mode).
2. When writing new notes/rules/agent definitions, never use the old conventions.
3. When reading old notes (historical Activity Log rows, archived chats, old daily notes), the old conventions are preserved as history — don't rewrite them.

The Activity Log and historical Daily Notes are **history**. Don't translate past tense.

## Maintenance

Append to this rule when something gets retired. Format:

```
| Old path/concept | Current path/concept | When (MM-DD-YY) |
```

The drift-watcher quarterly run cross-references this rule against the vault to find lingering references to anything in an "Old" column.

## See also

- [[claude-features]] — feature registry (forward-looking; what's available)
- [[engineering-doctrine]] — trust code over docs; verify against reality
- [[memory]] — agent memory protocol (where universal/pinned/recent live)
