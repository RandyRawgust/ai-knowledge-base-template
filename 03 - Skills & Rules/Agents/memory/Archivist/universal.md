---
type: memory-universal
agent: Archivist
last_consolidated: 2026-05-13
---

# Archivist — Universal Memory

Cross-project facts I load every invocation.

## Andy's accounts / handles

- **GitHub:** `<YOUR-GH-HANDLE>` (NOT `<YOUR-OLD-GH-HANDLE>` — common mistake; email prefix is misleading). Repos under `github.com/<YOUR-GH-HANDLE>/<project>`.
- **Email:** <YOUR-EMAIL> · **Website:** <YOUR-PERSONAL-SITE>.dev

## Where things live (5S layout)

The vault follows the [[5S_STANDARD]]. Quick map:

- **Inbox** — Desktop\Inbox\ (Windows side). Weekly sweep at Sunday 9 AM. NEVER let this be the long-term home of anything.
- **Projects** — `E:\Projects\` (non-game) and `F:\Game Dev\Projects\` (game). One folder per project with README + CLAUDE.md (optional).
- **Vault** — `E:\Projects\AI Knowledge Base` — markdown layer (this place). One file per concept.
- **Media** — `E:\Media\Images\{Photos,Screenshots,Memes,Misc,AI Gen}`, `E:\Media\Audio\{Music,SFX,AI Gen}`, `E:\Media\Videos\AI Gen`.
- **Archive** — `G:\Archive\` for old installers, takeouts, retired stuff.
- **Untouched** — `G:\DJ Music\`, `G:\media\video\` (Jellyfin). Don't touch.

## File conventions

- ISO dates: `YYYY-MM-DD`.
- Frontmatter on every note: `type, created, tags`.
- Wikilinks for vault refs. Markdown links for external paths.

## Common requests I handle

- **"summarize this conversation"** → write into `00 - Chats/<YYYY-MM-DD>_<slug>.md`. Hand off to [[Specialists/summary-writer]].
- **"compile a topic note on X"** → read sources, write `10 - Topics/<slug>.md`. Hand off to [[Specialists/topic-compiler]].
- **"what did I do this week"** → read Activity Log + Daily Notes, write a weekly recap. Hand off to [[Specialists/weekly-summarizer]] (Auditor specialist but I often help).
- **"find me X"** — search vault, return paths + 1-line context.
- **"organize these"** — propose a layout, ask before moving.

## Where chat / session artifacts go

- **Voice chat decks** → `20 - Decks/<YYYY-MM-DD HHmm> <slug>.html` (Presenter writes these).
- **Conversation summaries** → `00 - Chats/<YYYY-MM-DD>_<slug>.md` (summary-writer writes these).
- **Daily Notes** → `01 - Daily Notes/<YYYY-MM-DD>.md` — short, intent-driven, often empty if light day.
- **Activity Log** → `03 - Skills & Rules/Agents/Activity Log.md` — append-only, one row per major action.

## What I won't do

- Don't rename or move files without asking — sentimental value can be invisible from outside.
- Don't compress everything into "concise" forms. Some things should stay long. Match the source's depth.
- Don't archive things just because they're old. Old isn't dead.
