# Andy's File Standard (5S)

The rules for where things live, how they're named, and how the system stays
clean. Lives at the root of your AI Knowledge Base vault so Claude and you
can both reference it.

---

## SORT — what gets thrown out

Delete on sight:
- Installers older than 30 days that have already been installed
- Numbered duplicates (`foo (1).pdf`) once you confirm the original exists
- Empty folders the routine creates accidentally
- Browser-downloaded receipts/confirmations after they're entered into your
  records
- Auto-generated junk: `desktop.ini`, `Thumbs.db`, `~$lock` files

Send to `_Review_` (don't delete yet, but earmark):
- Stuff you can't immediately classify
- Files older than a year you haven't opened

**Default to delete when in doubt.** The cost of recovering a lost meme is
zero. The cost of carrying 1,000 of them is real.

---

## SET IN ORDER — where things live

### Top-level home for each category

| What                                                    | Where                                                     |
| ------------------------------------------------------- | --------------------------------------------------------- |
| Resumes, job apps, pay stubs, IDs                       | `C:\Users\<YOUR-USERNAME>\OneDrive\Career\` & `Identity & Records\` |
| Photos                                                  | `E:\Media\Images\Photos\`                                 |
| Screenshots                                             | `E:\Media\Images\Screenshots\`                            |
| Memes / saved images                                    | `E:\Media\Images\Memes\`                                  |
| Misc / uncategorized images                             | `E:\Media\Images\Misc\`                                   |
| AI-generated images                                     | `E:\Media\Images\AI Gen\`                                 |
| Music (non-DJ)                                          | `E:\Media\Audio\Music\`                                   |
| Sound effects / clips                                   | `E:\Media\Audio\SFX\`                                     |
| AI-generated audio                                      | `E:\Media\Audio\AI Gen\`                                  |
| Videos (renders, personal)                              | `E:\Media\Videos\`                                        |
| AI-generated videos                                     | `E:\Media\Videos\AI Gen\`                                 |
| **Non-game-dev projects + AI vault**                    | `E:\Projects\<project>`                                   |
| **Non-game AI workspaces**                              | `E:\Utilities\`                                           |
| **Game dev projects** (TerraWatt, Citizen RED-6, Godot) | `F:\Game Dev\Projects\<project>`                          |
| **Game dev tools / utilities**                          | `F:\Game Dev\Utilities\`                                  |
| Steam library                                           | `F:\Games\SteamLibrary\` (don't touch)                    |
| Epic Games                                              | `F:\Games\Epic Games\`                                    |
| Other game launchers (EA, Rockstar, Battle.net)         | `F:\Games\Installed\<launcher>`                           |
| Emulators / ROMs                                        | `F:\Games\Emu & Roms\`                                    |
| Game mods, addons                                       | `F:\Mods\<game>\`                                         |
| Game-related docs (KSP Guide, Raptor Craft, etc.)       | `F:\Docs\`                                                |
| DJ Music                                                | `G:\DJ Music\` (don't touch)                              |
| Jellyfin video library                                  | `G:\media\video\` (don't touch)                           |
| Old installers, backups, takeouts                       | `G:\Archive\`                                             |
| Staging for new files                                   | `Desktop\Inbox\<type>\`                                   |
| Active shortcuts                                        | `Desktop\Shortcuts\`                                      |

### Inside `E:\Projects\<project>\`

Every project follows the same skeleton (so Claude can navigate any project
the same way):

```
<project>\
├─ README.md              ← what is this, what's the status, who/why
├─ assets\                (images, audio, reference)
├─ docs\                  (notes, plans, design, handoffs)
├─ src\                   (code, scripts, raw working files — if applicable)
├─ exports\               (rendered output, deliverables)
└─ _archive\              (old versions you don't want deleted)
```

### Vault note vs. on-disk project (critical)

The vault at `E:\Projects\AI Knowledge Base\02 - Projects\<Category>\<Project>.md` is a **directory-pointer note**. It tells the vault what the project is, where it lives on disk, and current status. It is NOT a storage location for project files.

| In the vault | On disk |
|---|---|
| Project metadata (status, category, stack, related notes) | Code, assets, screenshots, exports |
| Wikilinks to topics + software map + sibling projects | Working files, docs, design notes |
| Frontmatter `path:` pointing to the on-disk location | The actual `README.md` |
| Session handoffs and plans — **NO** | Session handoffs and plans — **yes** |
| Generated assets (PNGs, recordings) — **NO** | Generated assets — **yes** |

If you find anything in `02 - Projects/<Category>/<Project>/` other than the directory note (`<Project>.md`), move it to the project's on-disk path and delete the orphan from the vault.

Not every project needs every folder. Add as needed.

---

## SHINE — keep it clean

- **Weekly:** the `Andy Inbox Sort` task runs Sunday 9 AM. You spend ~10
  minutes filing what's in the Inbox to permanent homes.
- **Within the day:** new files go straight to Downloads or Desktop — fine.
  Don't try to file as you work; let the routine batch it.
- **`_Review_`:** glance through monthly. Empty it when you can.

---

## STANDARDIZE — naming conventions

### General principles
1. **Descriptive over cryptic.** `KSP_Mission_Reference.docx` beats
   `doc1.docx`. Dates and versions go at the end.
2. **No spaces in code/script files.** Use underscores or hyphens.
   Spaces are fine in documents, photos, and personal stuff.
3. **Lowercase preferred** for code/scripts. Title Case fine for documents.
4. **Date format: `YYYY-MM-DD`** if the date is part of the name. ISO order
   sorts correctly.

### Specific patterns

| Type | Pattern | Example |
|------|---------|---------|
| Resumes | `Andy_Resume_<YYYY>_<role>.pdf` | `Andy_Resume_2026_PM.pdf` |
| Job applications | `<Company>_<Role>_<YYYY-MM>.pdf` | `Stripe_PM_2026-04.pdf` |
| Project deliverables | `<project>_<deliverable>_v<n>.<ext>` | `terrawatt_design_v3.pdf` |
| Daily notes | `<YYYY-MM-DD>.md` | `2026-05-08.md` |
| Photos | keep camera filename (`20260508_142312.jpg`) — already date-sortable |
| AI conversations | `<YYYY-MM-DD>_<topic>.md` | `2026-05-08_file-cleanup.md` |
| Software notes | `<software-name>.md` | `davinci-resolve.md` |

### Frontmatter for vault notes
Every markdown note in the AI Knowledge Base starts with:

```yaml
---
type: project | software | daily | chat | source | topic
status: active | dormant | archived | done   # for projects
created: 2026-05-08
tags: [tag1, tag2]
---
```

This is what makes the graph work and makes Claude able to filter (e.g.,
"show me all dormant projects").

---

## SUSTAIN — the audit cadence

### Weekly (auto)
The Inbox sort routine runs. Nothing for you to do unless `_Review_`
fills up.

### Monthly (10–30 min, you)
1. Empty `Inbox\_Review_`. Decide each item: delete, file, or keep.
2. Glance over `E:\Projects` — anything dormant? Update its README status.
3. Check `Desktop\Inbox` is empty by Monday.
4. Glance at the dashboard (once Phase 4 is up): any red flags?

### Quarterly (1 hour, you)
1. Walk the top-level folders on E:, F:, G:. Anything misfiled?
2. Update `E:\Projects\AI Knowledge Base\Software Map` if you've installed
   or uninstalled anything significant.
3. Move stale projects to `E:\Projects\_Archive`.

### Annually (half a day, you)
1. Sweep `G:\Archive`. Anything you can finally delete?
2. Re-read this standard. Update it where reality has drifted.
3. Backup your vault to a separate drive.

---

## Anti-patterns (things NOT to do)

- ❌ Don't make new top-level folders without updating this doc
- ❌ Don't put project files in OneDrive (sync friction, size limits)
- ❌ Don't keep stuff in Downloads thinking "I'll file it later" — that's
  what the Inbox routine is for
- ❌ Don't manually duplicate files between drives (use shortcuts/symlinks)
- ❌ Don't trust filenames you didn't choose — rename anything cryptic when
  you file it
