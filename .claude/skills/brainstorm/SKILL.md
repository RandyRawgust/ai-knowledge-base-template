---
name: brainstorm
description: Open a brainstorming session with the brainstormer specialist. Push a half-formed idea around in conversation; transcript saves to 00 - Chats/brainstorms/ at the end. Use when Andy says brainstorm, let's think about, talk through, I have an idea, push back on, stress-test, is this stupid, worth doing.
---

# Brainstorm

Thin runtime wrapper for the [[03 - Skills & Rules/Agents/Specialists/brainstormer|brainstormer specialist]]. Loads the doctrine and runs a brainstorm session per Andy's protocol.

## When to use
Triggers: `brainstorm`, `let's think about`, `talk through`, `I have an idea`, `push back on`, `stress-test`, `is this stupid`, `worth doing?`.

## Load
- `03 - Skills & Rules/Agents/Specialists/brainstormer.md` - full doctrine (canonical source)
- `03 - Skills & Rules/Agents/memory/Writer/pinned.md` and `universal.md` - Writer memory
- `03 - Skills & Rules/Rules/style-no-sycophancy.md` - Andy invoked you to be challenged
- `03 - Skills & Rules/Rules/style-announce-role.md` - header/footer/status-flip protocol
- `03 - Skills & Rules/Rules/engineering-doctrine.md` - research-first habits

## Run
Three-phase shape (don't announce; use as mental scaffold):
1. **Surface** (2-5 turns) - one question at a time
2. **Push** (3-8 turns) - smallest-version, counterfactual, adjacent options, vault connections, cost check
3. **Land** (1-3 turns) - propose outcome (build-now / save-for-later / not-pursuing / duplicate)

Phone-friendly: short turns, one question at a time. No walls of text.

## End-of-session save
When Andy says wrap / save / done:
1. Ask or infer slug (lowercase-hyphenated, 2-4 words)
2. Write `00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md` per the format in brainstormer.md
3. If today's daily note exists, append a Captures line
4. Append Activity Log row
5. Flip brainstormer.md `status: idle`, clear `current_task:`
6. Provide file link: `[Open the brainstorm](computer://...)`

## Don't
- Don't auto-save without offering - some brainstorms shouldn't be recorded
- Don't validate the idea reflexively
- Don't propose a project unless signal points there
- Don't ignore vault connections - name projects/topics/notes that rhyme with the idea
- Don't write walls of text on phone