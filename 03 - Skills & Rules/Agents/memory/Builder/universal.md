---
type: memory-universal
agent: Builder
last_consolidated: 2026-05-13
---

# Builder — Universal Memory

Cross-project facts I load every invocation.

## Andy's build preferences

- **Ship complete files, not snippets.** When asked to build, write the whole thing, not "here's the start, you fill in the rest."
- **Real files over described plans.** "I'd suggest creating X" is wrong; "I created X at <path>" is right.
- **Match his aesthetic.** BBS/CRT for tools (green-on-black, scanlines, JetBrains Mono / VT323 / Black Ops One). Clean modern for sharing (white bg, Inter, restrained accents).
- **Make it work end-to-end before polish.** Working ugly beats broken polished.

## Andy's accounts / handles

- **GitHub:** `<YOUR-GH-HANDLE>` (not `<YOUR-OLD-GH-HANDLE>` — common mistake; the email prefix is misleading). Verify with `gh api user --jq .login` if unsure.
- **Email:** <YOUR-EMAIL>
- **Website:** <YOUR-PERSONAL-SITE>.dev

## Tech preferences

- Python: use stdlib first (`urllib` over `requests`, etc.) to keep dependency footprint low. Add deps only when justified.
- Windows-friendly: `CREATE_NO_WINDOW` on subprocess calls so no flashing cmd windows. Use `setx` for persistent env vars.
- File paths: always absolute. `pathlib.Path` preferred over string concatenation.
- Bigger tools (the Command Center) — single-file Python with embedded HTML/CSS/JS is fine and expected. Don't split for the sake of splitting.

## Conventions when writing files

- Frontmatter on every markdown note: `type, created, tags` minimum.
- ISO dates only: `YYYY-MM-DD`.
- Wikilinks `[[name]]` for vault refs; `[label](file:///...)` for external paths.
- Course content follows [[03 - Skills & Rules/Rules/course-format]].
- Project READMEs follow [[03 - Skills & Rules/Rules/project-readme]].

## What I've already built

- **AI OS vault scaffolding** — 02 - Projects/, 10 - Topics/, 13 - Courses/, 01 - Daily Notes/, 00 - Chats/, 11 - Sources/, 12 - Software Map/, 03 - Skills & Rules/, 04 - Templates/, 20 - Decks/
- **Command Center** (`[[_Command Center.canvas]]` at vault root) — native Obsidian canvas composing Dataview-driven views of agents, projects, workflows, scheduled tasks, recent activity. No server, no Python. The previous Python FastAPI dashboard (`command_center.py` at `E:\Projects\Command Center\`) was superseded 05-17-26; see [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra]].
- **Fundamentals of Coding scaffold** — 12-week course shell. Only lesson 01 actually built.
- **Agent specialists** (11 total, all built) — brainstormer, course-builder, doc-improver, drift-watcher, inbox-sweeper, lesson-writer, presenter, project-scaffolder, summary-writer, topic-compiler, weekly-summarizer.

## Don'ts

- Don't bake project-specific rules into universal templates. Fork to `02 - Projects/<name>/` per CLAUDE.md.
- Don't generate huge LOC counts of speculative scaffolding. Build what's asked.
- Don't pad with greetings or "here's what I did" preamble when reporting back.
