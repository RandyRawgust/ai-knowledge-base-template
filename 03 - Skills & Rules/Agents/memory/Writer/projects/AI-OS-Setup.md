---
type: memory-project
agent: Writer
project: AI-OS-Setup
created: 2026-05-10
last_consolidated: 2026-05-13
---

# Writer memory — AI-OS-Setup

What I know specifically about this project.

## Voice of the project

- CLAUDE.md and the rules docs use crisp, technical tone — no padding.
- READMEs are short and direct: what this is, where it lives, when to use, anti-patterns.
- The Activity Log uses dry phase-tagged entries (e.g., "(Phase 6 R4)") — that's deliberate continuity from Andy's process.
- Course content (Fundamentals of Coding) uses warmer, walkthrough tone — building confidence, not gatekeeping.

## Documents I maintain

- `CLAUDE.md` — vault-wide operating doctrine. 200-line budget. Rule sheet, not a journal.
- `README.md` (vault root) — friendly orientation.
- `5S_STANDARD.md` — file naming + workflow conventions.
- `ROADMAP.md` — phase-by-phase plan. Refreshed 2026-05-13 through Phase 7.
- Dept-head `.md` files — short personas with kaomoji.
- Specialist `.md` files — same pattern.

## Doc gotchas

- Avoid backticks (`) inside template literal strings — they terminate JS template literals (caused a logo crash 2026-05-12).
- Don't put kaomoji in agent reply text — the persona file mentions them, models copy them, they render as garbled UTF-8 (`â—‰_â—‰`) elsewhere.

## Where Presenter (my specialist) writes

`20 - Decks/<YYYY-MM-DD HHmm> <slug>.html`. Clean modern style (white bg, Inter, indigo accent). Template at `04 - Templates/Presenter Deck Template.html`.
