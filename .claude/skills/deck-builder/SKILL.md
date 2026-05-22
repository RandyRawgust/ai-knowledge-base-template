---
name: deck-builder
description: Scaffold a new HTML presentation deck for the Presenter specialist's voice-chat sessions. Use when Andy says build a deck, presenter deck, slides for X, voice walkthrough.
---

# Deck Builder

## When to use
Triggers: build a deck, make slides, presenter deck, voice walkthrough, present this.

## Load
- `03 - Skills & Rules/Agents/Specialists/presenter.md` - presenter specialist spec
- `20 - Decks/` - examples of existing decks
- `20 - Decks/README.md` - deck conventions

## Confirm
1. Topic / title
2. Audience (voice-chat with Andy? sharing with others later?)
3. Length (5 / 10 / 20 minutes)

## Create
`20 - Decks/<slug>.html` - single-file HTML with embedded CSS + JS. Pattern:
- Title slide
- Agenda (3-5 bullets)
- Content slides (one concept per slide)
- Recap
- Optional Q+A prompts

## Style
- BBS / CRT aesthetic for Andy's internal decks (green-on-black, JetBrains Mono, scanlines)
- Clean modern for share-able decks (white, Inter, restrained accents)
- Match the existing deck examples in `20 - Decks/`

## Don't
- Don't auto-generate the actual CONTENT - just the structure. Andy + Writer specialists write the words.
- Don't import external libraries beyond what's needed - keep single-file for portability