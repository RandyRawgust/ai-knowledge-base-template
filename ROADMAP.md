# Andy's AI OS Roadmap

**Status (May 2026):** Phases 0-10 shipped. Vault, Command Center, multi-agent hierarchy with memory layer, scheduled automation, 5-category doctrine (Skills / Rules / Agents / Workflows / Scheduled Tasks), and native Claude Code runtime integration (sub-agents, skills, hooks, MCP, plugin manifest) all live. Vault on GitHub at `<YOUR-GH-HANDLE>/ai-knowledge-base`. Next: course content build-out (Fundamentals of Coding has 1 of 12 weeks), TerraWatt rebuild from scratch, possible Telegram interface. See "Where we are now" below; deeper history in [[03 - Skills & Rules/Agents/Activity Log|Activity Log]].

---

## 1. The North Star

A **living markdown vault** that holds your projects, notes, software map,
and AI conversation logs. It is:

- **Readable by Claude** — I can read every file directly, no scraping or
  vector DBs needed.
- **Visualizable in Obsidian** — graph view, canvas, backlinks, all working on
  the same files Claude reads.
- **Surfaced via a dashboard** — Cowork artifact that pulls live data from
  Calendar, Gmail, project status, and the weekly file-cleanup log.
- **Self-sustaining** — weekly sort routine + monthly 5S audit keep entropy
  down without you grinding.

This isn't speculative. The pieces exist. We just have to assemble them.

---

## 2. Research summary — what others are doing

### Andrej Karpathy's "LLM Wiki" (April 2026)
This is the closest existing pattern to what you described.

- Plain markdown files, organized by topic, opened in **Obsidian**.
- Claude Code (or any capable LLM) reads the folder and answers questions
  grounded in your own notes — not the open internet.
- Karpathy uses **Obsidian Web Clipper** to convert articles to markdown so
  the LLM can reference them. Images get downloaded locally.
- Reportedly **~70x more efficient than RAG** for this use case because there's
  no embedding/chunking — just file reads.
- His personal wiki on a single research topic grew to ~100 articles /
  ~400,000 words, which Claude compiled from his raw source material —
  he didn't write it directly.

**For Andy:** This is the AI folder you described. The "various md files" idea
is exactly Karpathy's pattern. We build the folder, give it structure, and
Claude maintains it as you feed in source material.

### Nate Herk's n8n agent stacks
n8n is a visual workflow builder that connects services. Herk's whole brand
is teaching non-developers to build "mid-tier agents that actually work" —
agents that handle invoices, customer inquiries, calendar coordination, etc.
**600+ integrations**, lower-cost than enterprise platforms like Zapier or
Make for AI-heavy flows.

**For Andy:** This is the tool layer underneath your dashboard, if/when you
want true automation (e.g., "auto-tag every Gmail thread by project," or
"when a project folder hasn't been touched in 60 days, ping me"). Optional —
artifacts can carry the dashboard alone.

### Marc Andreessen's productivity (current era)
He flipped his system around 2020: from anti-schedule index cards to a
heavily programmed, calendar-driven day. His bet is that at scale, the
calendar IS the productivity system — everything else feeds it.

**For Andy:** Reinforces the dashboard's center-of-gravity being your
**Google Calendar**. Tasks, projects, and files are all secondary feeds.

### 5S for digital files (Lean → digital)
The five steps map cleanly:

| 5S step | Physical | Digital |
|---------|----------|---------|
| Sort (Seiri) | Throw out junk | Delete duplicates, old installers, stale exports |
| Set in Order (Seiton) | Place tools where used | Clear folder structure, one home per file type |
| Shine (Seisō) | Clean regularly | Weekly Inbox sort routine |
| Standardize (Seiketsu) | Document procedures | Naming conventions, written file standard |
| Sustain (Shitsuke) | Audit, train | Monthly self-audit, scheduled health checks |

We've already done parts of Sort + Set in Order. The standard doc covers
Standardize. The weekly routine is Shine. We need a monthly audit step for
Sustain.

---

## 3. The phased plan

Each phase is independently shippable. We don't move to the next until the
prior is in place.

### ✅ Phase 0 — Cleanup (DONE, May 8)
- 308 files moved off Desktop + Downloads
- Weekly sort routine installed (Windows Task Scheduler, Sundays 9 AM)
- Inbox-by-type system live

### ✅ Phase 1 — Foundation (DONE)
- **5S file standard** written and saved into the vault root
- Reorganize so Projects holds *all* creative + code + Cowork stuff
  - `Desktop\Cowork` → `E:\Projects\Cowork`
  - Any other code folders that drift in → `E:\Projects\<name>`
  - Chat/AI conversation exports → `E:\Projects\AI Knowledge Base\Chats`
- Create the **AI Knowledge Base** folder with skeleton subfolders
  (Topics, Software Map, Daily Notes, Chats, Sources)
- Inbox `_Folders_to_File_` cleared by you with my help

### ✅ Phase 2 — Obsidian vault (DONE)
- Install Obsidian (free)
- Open `E:\Projects\AI Knowledge Base` as a vault
- Install **Web Clipper** browser extension
- Install Canvas core plugin (already built-in) — your brainstorm space
- Add starter note templates: Daily, Software, Project, Chat-summary
- Configure file-naming linter (community plugin) so the 5S standard is enforced

### ✅ Phase 3 — Software map (DONE — sparse but live)
- For each piece of software you use: a markdown note with frontmatter
  (`type: software`, `category: video editing`, etc.)
- Each note links via wikilinks to: directories it touches, projects that
  use it, file types it produces
- Obsidian's **Graph view** automatically draws the picture you described
  ("DaVinci → editing projects, assets, music")
- Built incrementally — start with your top 5 most-used apps, grow from there

### ✅ Phase 4 — AI OS Dashboard (DONE)

Two views, one source of truth (the vault):

**Primary: Obsidian-native dashboard** (Eric Michaud's pattern, May 2026).
A `Dashboard.md` note in the vault that uses:
- **Dataview** plugin — query frontmatter across all notes
  (e.g. `LIST FROM "02 - Projects" WHERE status = "active" SORT modified DESC`)
- **Meta Bind / Buttons** — trigger commands inline (run a script, open a
  related vault path, kick off an agent)
- **Custom Frames** — embed web tools (Calendar, Hermes dashboard, etc.)
  right in the note. No alt-tab.
- **Templater** — date-aware daily-note generation

What it shows:
- Today's Calendar (via embed or Google Workspace CLI output)
- Active projects pulled from vault frontmatter (`status: active`)
- File cleanup health (last weekly run, `_Review_` count)
- Pinned current focus + anti-todo list (Andreessen-style)
- "Daily Agent Commands" panel — buttons that trigger Claude / Codex /
  GitHub CLI and write results into the vault

**Secondary: Cowork artifact** — same data, web-page form, refreshes on
each open. Useful when you're not in Obsidian (phone, glance from any
browser, sharing with someone). Built later, shares the vault as backend.

### ✅ Phase 5 — Agent layer (DONE — Option C picked)
- Went with the in-vault command pattern (Eric Michaud's approach)
- 5 dept-head agents (Orchestrator/Builder/Writer/Archivist/Auditor) with kaomoji + accent colors
- Specialists folder (11 total): brainstormer, course-builder, doc-improver, drift-watcher, inbox-sweeper, lesson-writer, presenter, project-scaffolder, summary-writer, topic-compiler, weekly-summarizer
- Project-specific agents: TerraWatt's six roles (alignment, foundation, pixel-sim, world-gen, player, cowork-visual)
- Memory layer skeleton: per-dept-head universal/pinned/recent + per-project files (currently all empty stubs)
- Hermes Agent (n8n's alternative) installed but largely unused — Cowork+claude-print covers the use cases at zero marginal cost via the Max plan
- War Room (in-browser voice chat with 5 dept heads) BUILT then REPLACED in Phase 7 by Presenter

Original notes on this phase preserved below for reference:
Only if you actual