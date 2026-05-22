<#
.SYNOPSIS
    Phase 10.2: Drop custom Skill scaffolds into .claude/skills/.

.DESCRIPTION
    Each skill is a thin runtime registration that references canonical vault
    docs (rules, specialists, templates). The vault remains the design system;
    these skill files are just invocation surface.

    Tier 1 (daily):  commit-message-writer, daily-note-writer, brainstorm
    Tier 2 (course): course-builder, lesson-content-writer
    Tier 3 (meta):   workflow-author, specialist-creator
    Tier 4 (spec):   deck-builder, drift-fix
    Tier 5 (session): handoff, retro
    Tier 6 (vault):  audit, sweep-inbox, compile-topic
    Tier 7 (meta):   forge (mine sessions for skill candidates), revive (resurrect dormant projects)
    Tier 8 (voice):  report (voice + HTML project report via presenter specialist)
    + 2 from previous run: project-scaffolder, git-bootstrap

    Re-running is idempotent (overwrites with current definitions).

.NOTES
    Externally-sourced skills (imported 05-21-26 from https://github.com/mattpocock/skills):
      tdd, diagnose, to-prd, to-issues, zoom-out, prototype,
      improve-codebase-architecture, triage, setup-pre-commit, grill-with-docs

    These are NOT in the $skills hashtable below — they live at .claude/skills/<name>/SKILL.md
    on disk but are sourced from upstream rather than scaffolded by this script.

    Re-running this script will NOT touch them (no Remove-Item). To update them, re-fetch
    from upstream or edit the files directly. Their vault docs carry
    'generated_by: manual import from mattpocock/skills' in frontmatter; generate-skill-docs.ps1
    skips files with that marker to preserve hand-written contradiction notes.
#>
[CmdletBinding()]
param(
    [string]$VaultRoot = "E:\Projects\AI Knowledge Base"
)

$SkillsDir = Join-Path $VaultRoot ".claude\skills"
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
Write-Host "[setup] skills dir: $SkillsDir" -ForegroundColor Cyan

$skills = @{

    "project-scaffolder" = @{
        Description = "Scaffold a new project folder with CLAUDE.md, README.md, .gitignore, and the canonical structure. Use when Andy says build/start/create a new project, scaffold X, or set up a new project folder."
        Body = @"
# Project Scaffolder

Drop a fresh project folder following Andy's vault conventions.

## When to use
Trigger words: scaffold, set up, create a new project, start a new X, drop in a new folder.

## Inputs to confirm
1. Project name (lowercase-hyphens)
2. Location (default ``E:\Projects\<name>``)
3. Type (code / docs / course / game-dev)
4. Public or private repo

## Load
- ``03 - Skills & Rules/Rules/project-readme.md`` - README structure
- ``03 - Skills & Rules/Agents/Specialists/project-scaffolder.md`` - canonical spec
- ``CLAUDE.md`` - template for project-level CLAUDE.md

## Create
``project-name/`` with: README.md, CLAUDE.md, .gitignore, workflows/ (stub). Add row to Projects-Index.md. Suggest git-bootstrap as next step.

## Don't
- Don't overwrite existing folders without asking
- Don't skip the project CLAUDE.md - it's how doctrine cascades
"@
    }

    "git-bootstrap" = @{
        Description = "Initialize git on a project, set up .gitignore, first commit, create the GitHub repo, push. Use when starting version control on any project for the first time."
        Body = @"
# Git Bootstrap

## When to use
Triggers: git init, set up git, bootstrap git, put this on GitHub.

## Preferred path
Run the existing script:
``````powershell
cd "<project-path>"
& "E:\Projects\AI Knowledge Base\22 - Scripts\git-bootstrap.ps1" -Path "<project-path>" -Name "<repo-name>"
``````
Add ``-Public`` if shareable.

## Per-project visibility defaults
- AI Knowledge Base, TerraWatt, KSP*, Command Center: ``private``
- Fundamentals of Coding: ``public`` when ready

## Don't
- Don't init without .gitignore (sweeps junk)
- Don't commit secrets - check .env / API keys first
- Don't push vault publicly (personal memory + activity log)
"@
    }

    "commit-message-writer" = @{
        Description = "Draft a conventional commit message from the staged git diff. Use before any commit when the user asks you to write the message or generate one. Triggers: commit message, write a commit msg, generate commit, what should I commit this as."
        Body = @"
# Commit Message Writer

## When to use
User about to commit, asks for a message. Or you're about to commit on their behalf and need to draft one.

## Process
1. Run ``git diff --staged --stat`` to see scope
2. Run ``git diff --staged`` to see actual changes
3. Identify the type:
   - ``feat`` - new feature
   - ``fix`` - bug fix
   - ``docs`` - documentation only
   - ``refactor`` - code change, no behavior change
   - ``style`` - formatting, whitespace
   - ``test`` - test additions or fixes
   - ``chore`` - build, deps, config
   - ``perf`` - performance
4. Identify the scope (e.g. ``cc``, ``vault``, ``snake``, ``hooks``, ``agents``)
5. Write a one-liner: ``<type>(<scope>): <imperative present-tense summary>``
6. First line max 72 chars. If more context needed, blank line + body.

## Examples
- ``feat(cc): add script output dialog with stdout/stderr capture``
- ``fix(snake): revert sprite-sheet to static PNG after animation glitches``
- ``docs(roadmap): mark phase 10 complete, refresh status header``
- ``chore(vault): propagate <YOUR-GH-HANDLE> GitHub handle to 5 dept-head memories``

## Don't
- Don't write "Updated X" - use imperative present: "update X"
- Don't add a period at the end of the subject line
- Don't reference internal session details Andy wouldn't want public
- Don't lie about scope if changes span multiple areas - use ``misc`` or split commits
"@
    }

    "daily-note-writer" = @{
        Description = "Create today's Daily Note in 01 - Daily Notes/ with frontmatter, top-3 prompt, and anti-todo section. Use when Andy says start the day, daily note, today's note, what should I work on today."
        Body = @"
# Daily Note Writer

## When to use
Triggers: daily note, today's note, start the day, morning kickoff, anti-todo.

## Create
File: ``01 - Daily Notes/<YYYY-MM-DD>.md`` (today's date in ISO).

## Template
``````markdown
---
type: daily-note
created: <YYYY-MM-DD>
tags: [daily]
---

# <Day name, Month Day Year>

## Top 3
1.
2.
3.

## Anti-todo
> Things you actually got done today (write here as you go - low-friction capture).

-

## Captures
> Ideas, links, quotes - anything worth keeping.

-

## Tomorrow
> One thing to seed tomorrow.

-
``````

## After creating
Open the file. Don't fill in Top 3 yourself - leave for Andy. Suggest he reads the previous day's note (if it exists) for context.

## Don't
- Don't auto-fill Top 3 - that's Andy's choice
- Don't add task-management formality (no priorities, no labels) - it's intentionally minimal
- Don't pad with extra sections - the four above are it
"@
    }

    "brainstorm" = @{
        Description = "Open a brainstorming session with the brainstormer specialist. Push a half-formed idea around in conversation; transcript saves to 00 - Chats/brainstorms/ at the end. Use when Andy says brainstorm, let's think about, talk through, I have an idea, push back on, stress-test, is this stupid, worth doing."
        Body = @"
# Brainstorm

Thin runtime wrapper for the [[03 - Skills & Rules/Agents/Specialists/brainstormer|brainstormer specialist]]. Loads the doctrine and runs a brainstorm session per Andy's protocol.

## When to use
Triggers: ``brainstorm``, ``let's think about``, ``talk through``, ``I have an idea``, ``push back on``, ``stress-test``, ``is this stupid``, ``worth doing?``.

## Load
- ``03 - Skills & Rules/Agents/Specialists/brainstormer.md`` - full doctrine (canonical source)
- ``03 - Skills & Rules/Agents/memory/Writer/pinned.md`` and ``universal.md`` - Writer memory
- ``03 - Skills & Rules/Rules/style-no-sycophancy.md`` - Andy invoked you to be challenged
- ``03 - Skills & Rules/Rules/style-announce-role.md`` - header/footer/status-flip protocol
- ``03 - Skills & Rules/Rules/engineering-doctrine.md`` - research-first habits

## Run
Three-phase shape (don't announce; use as mental scaffold):
1. **Surface** (2-5 turns) - one question at a time
2. **Push** (3-8 turns) - smallest-version, counterfactual, adjacent options, vault connections, cost check
3. **Land** (1-3 turns) - propose outcome (build-now / save-for-later / not-pursuing / duplicate)

Phone-friendly: short turns, one question at a time. No walls of text.

## End-of-session save
When Andy says wrap / save / done:
1. Ask or infer slug (lowercase-hyphenated, 2-4 words)
2. Write ``00 - Chats/brainstorms/<MM-DD-YY>-<slug>.md`` per the format in brainstormer.md
3. If today's daily note exists, append a Captures line
4. Append Activity Log row
5. Flip brainstormer.md ``status: idle``, clear ``current_task:``
6. Provide file link: ``[Open the brainstorm](computer://...)``

## Don't
- Don't auto-save without offering - some brainstorms shouldn't be recorded
- Don't validate the idea reflexively
- Don't propose a project unless signal points there
- Don't ignore vault connections - name projects/topics/notes that rhyme with the idea
- Don't write walls of text on phone
"@
    }

    "course-builder" = @{
        Description = "Scaffold a 12-week course skeleton per course-format rule, or add new week to existing course. Use when starting a new course or extending the Fundamentals of Coding curriculum."
        Body = @"
# Course Builder

## When to use
Triggers: build a course, scaffold a course, add week N, new lesson series, course outline.

## Load
- ``03 - Skills & Rules/Rules/course-format.md`` - mandatory structure
- ``03 - Skills & Rules/Agents/Specialists/course-builder.md`` - canonical spec
- Existing course as reference: ``13 - Courses/fundamentals-of-coding/``

## Confirm inputs
1. Course slug (lowercase-hyphens, e.g. ``fundamentals-of-coding``)
2. Audience level (beginner / intermediate / advanced)
3. Topic / domain (Python? React? Game dev?)
4. Number of weeks (default 12)

## Create
``13 - Courses/<slug>/`` with:
- ``README.md`` (course-format-compliant; intro, prereqs, week index, completion criteria)
- ``week-01-<topic>/`` through ``week-12-<topic>/`` folders
- Each week: ``README.md`` (week intro) + ``lesson-01-<topic>.md`` stub
- ``capstone/`` folder for the final project

## Don't
- Don't auto-write lesson CONTENT - that's lesson-content-writer's job
- Don't pick week topics without confirming with Andy - course design is his call
- Don't duplicate Fundamentals - if topic overlaps, ask whether to extend or start fresh
"@
    }

    "lesson-content-writer" = @{
        Description = "Write the body of a course lesson following the lesson template (intro/concepts/exercises/answer key). Use when Andy says write lesson N, fill out lesson X, build out week Y."
        Body = @"
# Lesson Content Writer

## When to use
Triggers: write lesson N, fill out lesson X, build out week Y, draft this lesson.

## Load
- ``03 - Skills & Rules/Rules/course-format.md`` - lesson template
- ``03 - Skills & Rules/Agents/Specialists/lesson-writer.md`` - canonical spec
- Writer's universal memory for tone: ``03 - Skills & Rules/Agents/memory/Writer/universal.md``
- Existing lesson 1 as reference: ``13 - Courses/fundamentals-of-coding/week-01-*/lesson-01-*.md``

## Confirm
1. Which course + week + lesson
2. Specific concept(s) the lesson covers
3. Difficulty assumption (what did the prior lesson cover?)

## Structure
``````markdown
---
type: lesson
course: <slug>
week: N
status: in-progress
created: <date>
tags: [lesson]
---

# Lesson <NN>: <Title>

## Intro
Why this matters in 2-3 sentences. Concrete hook.

## Concepts
- Core idea 1 (with code example)
- Core idea 2 (with code example)
- Core idea 3 (with code example)

## Try it
3-5 progressive exercises. Each: clear prompt, expected behavior.

## Answer key
Collapsed by default. One solution per exercise with brief explanation.

## Next
What lesson <NN+1> will cover.
``````

## Tone (per Writer memory)
- Warm, direct, professional. Human, not corporate.
- No "honestly", "genuinely", "feel free to", "great question".
- Sentence case. Length matches substance.

## Don't
- Don't write all 12 lessons in one go - one at a time
- Don't skip exercises - that's where learning happens
- Don't add tangential concepts - the lesson stays scoped
"@
    }

    "workflow-author" = @{
        Description = "Scaffold a new workflow markdown file with triggers/agents/steps frontmatter, then auto-regenerate the sibling canvas. Use when Andy says codify this as a workflow, make this a workflow, save this recipe."
        Body = @"
# Workflow Author

## When to use
Triggers: codify this as a workflow, make this a workflow, save this recipe, turn this into a workflow.

## Load
- ``03 - Skills & Rules/Rules/workflow-spec.md`` - mandatory format
- Existing workflows as reference: ``05 - Workflows/audit-pass.md``, ``05 - Workflows/git-bootstrap.md``

## Confirm
1. Workflow slug (lowercase-hyphens)
2. Trigger phrases (what user words invoke it)
3. Owning agent(s) (Builder? Auditor? Specialist?)
4. The ordered steps (with optional ``[agent-name]`` prefix per step)

## Create
``05 - Workflows/<slug>.md`` with:
``````yaml
---
type: workflow
project: <AI-OS-Setup or sub-project>
name: <slug>
status: active
created: <date>
updated: <date>
agents: [<list>]
triggers: ["<phrase 1>", "<phrase 2>"]
tags: [workflow, <topic>]
---
``````

Body sections: When to invoke, Inputs, Steps (numbered, optionally with ``[agent]`` prefix), Outputs, Status markers, Anti-patterns, Retrospective.

## After creating
Workflow `.canvas` siblings were retired 05-17-26 — markdown-only is the current convention (see [[03 - Skills & Rules/Rules/superseded-infra]]). No canvas regen step.

## Don't
- Don't create a workflow for one-shot work - workflows are for recurring patterns
- Don't skip the anti-patterns section - that's where the gotchas live
- Don't forget triggers - without them, agents can't auto-route to the workflow
"@
    }

    "specialist-creator" = @{
        Description = "Scaffold a new specialist agent definition under 03 - Skills & Rules/Agents/Specialists/ with correct frontmatter. Use when adding a new agent role under one of the 5 dept heads."
        Body = @"
# Specialist Creator

## When to use
Triggers: add a specialist, new specialist, create a sub-agent, extend Builder/Writer/Archivist/Auditor.

## Load
- Existing specialists as reference: ``03 - Skills & Rules/Agents/Specialists/``
- Parent dept-head's spec (Builder.md / Writer.md / Archivist.md / Auditor.md)

## Confirm
1. Specialist slug (lowercase-hyphens)
2. One-line tagline (used in tooltips)
3. Parent dept head (Builder / Writer / Archivist / Auditor / Orchestrator)
4. Rules it uses (uses_rules: array)
5. Skills it uses (uses_skills: array - subset of [docx, pdf, pptx, xlsx])
6. Model (sonnet default; opus for heavy reasoning)

## Create
``03 - Skills & Rules/Agents/Specialists/<slug>.md`` with frontmatter:
``````yaml
---
type: agent
role: specialist
parent: <dept-head>
tagline: "<one line>"
status: idle
created: <date>
uses_rules: [<list>]
uses_skills: [<list or empty>]
model: <sonnet or opus>
tags: [agent, specialist]
---
``````

Body: role description, when invoked, inputs, process steps, outputs, don'ts.

## After creating
Update parent dept-head's ``delegates_to:`` list to include the new specialist.

## Don't
- Don't promote to ``.claude/agents/`` - per Andy's decision, specialists stay as dept-head delegates only
- Don't duplicate existing specialists - check the list first
- Don't skip the parent assignment - orphan specialists are an audit finding
"@
    }

    "deck-builder" = @{
        Description = "Scaffold a new HTML presentation deck for the Presenter specialist's voice-chat sessions. Use when Andy says build a deck, presenter deck, slides for X, voice walkthrough."
        Body = @"
# Deck Builder

## When to use
Triggers: build a deck, make slides, presenter deck, voice walkthrough, present this.

## Load
- ``03 - Skills & Rules/Agents/Specialists/presenter.md`` - presenter specialist spec
- ``20 - Decks/`` - examples of existing decks
- ``20 - Decks/README.md`` - deck conventions

## Confirm
1. Topic / title
2. Audience (voice-chat with Andy? sharing with others later?)
3. Length (5 / 10 / 20 minutes)

## Create
``20 - Decks/<slug>.html`` - single-file HTML with embedded CSS + JS. Pattern:
- Title slide
- Agenda (3-5 bullets)
- Content slides (one concept per slide)
- Recap
- Optional Q+A prompts

## Style
- BBS / CRT aesthetic for Andy's internal decks (green-on-black, JetBrains Mono, scanlines)
- Clean modern for share-able decks (white, Inter, restrained accents)
- Match the existing deck examples in ``20 - Decks/``

## Don't
- Don't auto-generate the actual CONTENT - just the structure. Andy + Writer specialists write the words.
- Don't import external libraries beyond what's needed - keep single-file for portability
"@
    }

    "drift-fix" = @{
        Description = "Apply fixes from the latest quarterly drift audit report. Use after drift-watcher-quarterly runs and produces a 01 - Daily Notes/<date> - Quarterly Drift Audit.md report."
        Body = @"
# Drift Fix

## When to use
Triggers: fix the drift, apply the audit, close the drift report, drift-watcher said X is broken.

## Load
1. Find the latest drift report: ``01 - Daily Notes/<YYYY-MM-DD> - Quarterly Drift Audit.md``
2. Read it top to bottom
3. ``03 - Skills & Rules/Rules/playbook-refresh.md`` - for any 🔴 critical findings that are real bugs

## Process

For each finding:

### 🔴 Critical
Apply playbook-refresh: read symptom, identify root cause, fix, verify, log. These usually mean a broken wikilink target file deleted, a CLAUDE.md over 200 lines, or a workflow referenced by trigger that doesn't exist.

### 🟡 Worth fixing
Direct fix per the suggestion in the report. Examples:
- Stale path reference → find/replace
- Ghost specialist → stub the missing file or remove the dangling delegates_to entry

### ⚪ Note
Acknowledge in the report but don't fix unless trivial.

## After fixes
1. Append an Activity Log row noting what got resolved and what was deferred
2. Re-run drift-watcher manually (or wait for next quarter) to confirm fixes held

## Don't
- Don't bulk-fix without reading each finding - drift can be wrong
- Don't ``git rm`` files flagged as orphans without checking they're truly unused
- Don't skip the activity-log row - audit closures need history
"@
    }

    "handoff" = @{
        Description = "Write a next-session handoff note before context runs out. Captures current state, what's done, what's mid-stream, and what to pick up first. Use when Andy says handoff, write a handoff, wrap up, context is running out, save state, end of session."
        Body = @"
# Handoff

Write a structured next-session handoff so the next agent (or future-Andy) can resume cold without re-deriving context.

## When to use
Triggers: ``handoff``, ``write a handoff``, ``wrap up the session``, ``context is running out``, ``save state``, ``end of session``, ``next session brief``.

## Load
- ``CLAUDE.md`` - so the handoff respects vault conventions
- ``03 - Skills & Rules/Agents/Activity Log.md`` - last 5 rows for context
- Current daily note ``01 - Daily Notes/<today>.md`` if it exists
- Any files the session has been editing (re-read for accurate current-state)

## Output

Write to ``00 - Chats/handoffs/<MM-DD-YY>-<slug>.md``. Create the ``handoffs/`` subfolder if missing.

Format:

``````markdown
---
type: handoff
created: <MM-DD-YY>
session_topic: <one-line>
status: <in-progress | done | blocked>
tags: [handoff]
---

# Handoff -- <topic>

## TL;DR
One paragraph: what we were doing, where we left off, what to do next.

## What got done this session
- <concrete change with file path>
- <...>

## Mid-stream (pick up here)
- <file or task half-finished, with line numbers / cursor location if relevant>
- <...>

## Blockers / open questions
- <thing that needs Andy's decision before next agent can proceed>

## Files touched
- <relative path> -- <one-line what changed>

## Recommended first move next session
The single most useful thing to do in the first 2 minutes of the next session.
``````

## After writing
1. Provide ``[Open handoff](computer://...)`` link
2. Append Activity Log row noting the handoff was written
3. If today's daily note exists, append to its ``## Captures`` section: ``- [[<MM-DD-YY>-<slug>]] -- handoff``

## Don't
- Don't dump the entire conversation - the handoff is a summary, not a transcript
- Don't skip the ``Recommended first move`` - that's the highest-value field
- Don't write a handoff if the session was trivial (under ~5 substantive turns)
"@
    }

    "audit" = @{
        Description = "Invoke Auditor + drift-watcher on demand to scan the vault for drift, broken refs, stale infra, and rule violations. Use when Andy says audit, audit the vault, run a check, what's drifting, find broken stuff, health check."
        Body = @"
# Audit

On-demand wrapper for [[03 - Skills & Rules/Agents/Auditor|Auditor]] + [[03 - Skills & Rules/Agents/Specialists/drift-watcher|drift-watcher]]. Quarterly scheduled audits already exist via ``drift-watcher-quarterly``; this is the same logic, on-demand.

## When to use
Triggers: ``audit``, ``audit the vault``, ``run a check``, ``what's drifting``, ``find broken stuff``, ``health check``, ``vault audit``, ``check for drift``.

## Load
- ``03 - Skills & Rules/Agents/Auditor.md`` - dept-head spec
- ``03 - Skills & Rules/Agents/Specialists/drift-watcher.md`` - drift heuristics
- ``03 - Skills & Rules/Rules/superseded-infra.md`` - registry of retired things to flag
- ``CLAUDE.md`` + ``5S_STANDARD.md`` - rules to check compliance against

## Run

Flip Auditor + drift-watcher to ``status: active``. Then sweep:

1. **Superseded-infra registry sweep** - every "Old" string in the registry, ripgrep the active vault. Any hit outside ``99 - Archived/``, daily notes, Activity Log, or chats = 🔴 finding.
2. **Broken wikilinks** - find ``[[X]]`` where X has no matching file (excluding placeholder examples).
3. **Ghost specialists** - any dept-head's ``delegates_to:`` entry that has no matching ``Specialists/<name>.md``.
4. **CLAUDE.md size** - over 200 lines = 🟡.
5. **Frontmatter coverage** - active projects without ``skills:`` / ``rules:`` / ``agents:`` arrays = 🟡 (would hide them from Dashboard queries).
6. **Stuck status flags** - any agent ``status: active`` for >24h (frontmatter timestamp check) = 🟡.

## Judge protocol (required for substantive audits)

Per [[03 - Skills & Rules/Agents/Auditor#Judge protocol cross-model verification|Auditor's judge protocol]]: after the primary 6-pass produces findings, **dispatch a judge sub-agent in a different model** before committing the report.

Pattern:
1. Primary audit runs in current model. Produces findings + severities.
2. Dispatch judge via Task tool, in different model (if running Sonnet, judge on Opus; or vice versa). Include the TCE preamble.
3. Judge brief: ``⊙ ⧉(audit_findings) - run ⧉ ∂ ⊗ attacks. What's missed/overstated/misrated?``
4. Integrate judge response: add missed findings, re-examine disputed ones.
5. Only then write the report. Include a "Judge findings integrated" section.

Skip judge only when total findings <5 or speed-critical.

## Report
Write findings to ``01 - Daily Notes/<YYYY-MM-DD> - Vault Audit.md`` (or append to today's daily note under ``## Audit`` section). Use the same 🔴/🟡/⚪ severity scheme as quarterly drift report.

Each finding includes: file path, line number if applicable, suggested fix. End the report with a ``## Judge findings integrated`` section noting what the judge added, downgraded, or removed.

## After
Suggest invoking ``/drift-fix`` to apply the fixes. Don't auto-apply.

## Don't
- Don't fix during audit - audit is read-only, separation of concerns
- Don't suppress 🟡 / ⚪ findings - they're the early warning system
- Don't skip the Activity Log row even if zero findings
- Don't skip the judge protocol on substantive audits - that's the integrity gate
"@
    }

    "sweep-inbox" = @{
        Description = "Invoke inbox-sweeper specialist to review what the Sunday Inbox sort routine has accumulated and help file/delete in batch. Use when Andy says sweep the inbox, review my inbox, what's in the inbox, file the inbox, inbox review."
        Body = @"
# Sweep Inbox

Thin runtime wrapper for [[03 - Skills & Rules/Agents/Specialists/inbox-sweeper|inbox-sweeper specialist]]. Runs an on-demand inbox review.

## When to use
Triggers: ``sweep the inbox``, ``review my inbox``, ``what's in the inbox``, ``file the inbox``, ``inbox review``, ``inbox sweep``.

## Load
- ``03 - Skills & Rules/Agents/Specialists/inbox-sweeper.md`` - canonical spec
- ``C:\Users\<YOUR-USERNAME>\OneDrive\Desktop\Inbox\last_run.log`` - what the Sunday routine moved this week
- ``5S_STANDARD.md`` - filing conventions
- Drive map from ``CLAUDE.md`` - where things belong

## Run
1. Flip inbox-sweeper to ``status: active``
2. Read ``last_run.log`` - get the list of files moved into ``Desktop\Inbox\<type>\``
3. For each file: propose a destination based on type + filename + drive map. Group similar items.
4. Walk Andy through batches: ``"5 PDFs look like research papers -- file to E:\Projects\<X>\Research\?"``
5. On approval, move files. Skip files Andy wants to defer.
6. Anything left after the sweep stays in ``_Review_/`` for next week.

## Output
Write a one-paragraph summary to today's daily note under ``## Inbox sweep`` section: ``"Filed N, deferred M, deleted K. Largest batch: <type> -> <destination>."``

## After
1. Append Activity Log row
2. Flip inbox-sweeper to ``status: idle``

## Don't
- Don't bulk-move without batch approval - Andy has judgment calls
- Don't delete without explicit confirmation
- Don't touch files outside ``Desktop\Inbox\`` and ``_Review_/`` - scope is sacred
"@
    }

    "compile-topic" = @{
        Description = "Invoke topic-compiler specialist to synthesize a Karpathy-style topic note from raw sources in 11 - Sources/. Use when Andy says compile a topic, build a topic note, summarize sources on X, make a primer on Y, what do I know about Z."
        Body = @"
# Compile Topic

Wrapper for [[03 - Skills & Rules/Agents/Specialists/topic-compiler|topic-compiler specialist]]. Builds a coherent topic note in ``10 - Topics/`` from raw clipped sources.

## When to use
Triggers: ``compile a topic``, ``build a topic note``, ``summarize sources on X``, ``make a primer on Y``, ``what do I know about Z``, ``synthesize these sources``.

## Load
- ``03 - Skills & Rules/Agents/Specialists/topic-compiler.md`` - canonical spec
- ``11 - Sources/`` - raw inputs (Web Clipper destination)
- An existing topic note as style reference: pick any from ``10 - Topics/AI/`` or related domain
- ``03 - Skills & Rules/Agents/memory/Archivist/universal.md`` - Karpathy-wiki tone

## Confirm inputs
1. Topic name (becomes file slug)
2. Source list - paths, a glob like ``11 - Sources/2026-05-*``, or "everything tagged X"
3. Audience - just-me notes vs. shareable explainer
4. Domain folder under ``10 - Topics/`` (AI, Game Dev, etc.) - create if doesn't exist

## Run
1. Flip topic-compiler to ``status: active``
2. Read every source. Extract key claims, definitions, examples, contradictions.
3. Group by sub-theme. Identify the spine of the topic (3-5 main sections).
4. Draft the note in Karpathy style: dense, linked, definitions inline, examples concrete, no fluff.
5. Cite each source via ``[[11 - Sources/<file>]]`` wikilinks. Every non-obvious claim cites.

## Output
``10 - Topics/<Domain>/<topic-slug>.md`` with frontmatter:

``````yaml
---
type: topic
created: <MM-DD-YY>
domain: <Domain>
sources: [<list of source wikilinks>]
status: draft | reviewed
tags: [topic, <domain-tag>]
---
``````

Body sections: intro, main concepts (each subsectioned), open questions, related topics, sources.

## After
1. Cross-link from related existing topic notes
2. Append Activity Log row
3. Flip topic-compiler to ``status: idle``
4. Provide ``[Open topic note](computer://...)`` link

## Don't
- Don't write from training knowledge alone - this is source-grounded synthesis
- Don't skip contradictions between sources - surface them, don't paper over
- Don't make it longer than the sources warrant - density beats length
- Don't auto-tag - tags are Andy's call
"@
    }

    "retro" = @{
        Description = "Invoke playbook-retro at session end to capture durable lessons and evolve the doctrine. Use when Andy says retro, do a retro, close the loop, what did we learn, end-of-session reflection."
        Body = @"
# Retro

Runtime wrapper for [[03 - Skills & Rules/Rules/playbook-retro|playbook-retro]]. Three-phase metacognitive reflection on the session that just ended.

## When to use
Triggers: ``retro``, ``do a retro``, ``close the loop``, ``what did we learn``, ``end-of-session reflection``, ``session retro``, ``debrief``.

## Load
- ``03 - Skills & Rules/Rules/playbook-retro.md`` - full doctrine (canonical source)
- ``03 - Skills & Rules/Rules/engineering-doctrine.md`` - where global lessons land
- ``03 - Skills & Rules/Rules/vault-conventions.md`` - where vault-specific lessons land
- Current session's Activity Log row(s) for context

## Run

Three phases per playbook-retro:

### Phase 0 - Session analysis
Walk every turn from initial request to now. Capture:
- **Successes** - what core patterns produced efficient, correct outcomes?
- **Failures & user corrections** - where did the approach fail? Pinpoint Andy's corrections.
- **Actionable lessons** - what's transferable to future sessions?

(Chat only, not in report yet.)

### Phase 1 - Lesson distillation
Filter ruthlessly. A lesson qualifies only if:
- Universal & reusable (not a one-off)
- Abstracted (general principle, not session-specific)
- High-impact (prevents failures or significantly improves efficiency)

Categorize each surviving lesson:
- **Global doctrine** -> ``engineering-doctrine.md`` or style/playbook rule
- **Vault doctrine** -> ``vault-conventions.md`` or ``5S_STANDARD.md``
- **Agent-specific** -> the relevant agent's ``.md`` or its memory file

### Phase 2 - Apply
Edit the target doctrine file(s). Each edit is one durable lesson. Quote Andy's correction or paraphrase the trigger that surfaced the lesson.

## Output

Write a session retro to ``00 - Chats/retros/<MM-DD-YY>-<slug>.md``:

``````markdown
---
type: retro
created: <MM-DD-YY>
session_topic: <one-line>
lessons_landed: <count>
tags: [retro]
---

# Retro -- <topic>

## Successes
- <pattern that worked>

## Failures & corrections
- <what broke> -> <Andy's correction or the realization>

## Lessons landed
| Lesson | Type | File updated |
|---|---|---|
| <durable principle> | global / vault / agent | <path> |

## Lessons rejected (didn't pass the filter)
- <session-specific thing that's not worth doctrine>
``````

## After
1. Append Activity Log row
2. Provide ``[Open retro](computer://...)`` link
3. If any doctrine file was edited, list the edits in the response

## Don't
- Don't land session-specific lessons as global doctrine - the filter exists for a reason
- Don't skip the rejected list - it's evidence the filter ran
- Don't run retro on trivial sessions (under ~5 substantive turns) - low signal
"@
    }

    "forge" = @{
        Description = "Mine session history (00 - Chats/, daily notes, brainstorms) for prompting patterns that recur 3+ times across separate sessions. Propose them as new skills, rules, or specialists. Use when Andy says forge, mine the sessions, what patterns am I repeating, find skill candidates, what should be a skill."
        Body = @"
# Forge

Cross-session pattern detector. Scans Andy's recent session history for patterns that have recurred enough to deserve promotion into a skill, rule, or specialist. Inspired by the FORGE archetype from the /goal video — the system-level version of the TCE evolution rule (add a symbol when it's been explained 3+ times).

## When to use
Triggers: ``forge``, ``mine the sessions``, ``what patterns am I repeating``, ``find skill candidates``, ``what should be a skill``, ``promote a pattern``.

Best run after a substantive working week, or before a quarterly drift audit. The /retro skill captures lessons from ONE session; /forge looks ACROSS sessions.

## Load
- ``03 - Skills & Rules/Rules/engineering-doctrine.md`` - research-first habits
- ``00 - Chats/`` - session summaries (not full transcripts — those are too noisy)
- ``00 - Chats/brainstorms/`` - past brainstorms
- ``00 - Chats/handoffs/`` - past handoff notes
- ``01 - Daily Notes/`` - last 30 days
- ``03 - Skills & Rules/Agents/Activity Log.md`` - last ~50 rows
- Current skills list at ``.claude/skills/`` (don't re-propose what exists)

## Run

### Phase 0 — Survey
Walk the source corpus. For each chat / brainstorm / daily note / activity row, extract: what task was being done, what instructions Andy gave repeatedly, what corrections he made, what manual steps recurred.

### Phase 1 — Pattern detection
Cluster by similarity. A pattern qualifies as a candidate when:
- It appears in ≥3 separate sessions (different days, different contexts)
- It involves a workflow that took multiple turns to describe
- Andy's correction pattern is similar across the instances
- A skill could meaningfully wrap it (not just trivial 1-line ops)

### Phase 2 — Propose

Group candidates by promotion target:

| Promotion | When |
|---|---|
| **New skill** | The pattern is invocable via a trigger phrase + has a clear inputs→outputs shape |
| **New rule** | The pattern is a recurring habit / convention (not invocation-shaped) |
| **New specialist** | The pattern has enough scope + judgment to warrant its own agent |
| **Extension to existing skill/specialist** | The pattern is a feature gap in something we already have |
| **No promotion** | Pattern recurs but doesn't earn a slot (under 3 hits, or pattern is too narrow) |

## Output

Write a forge report to ``01 - Daily Notes/<YYYY-MM-DD> - Forge Report.md``:

``````markdown
---
type: forge-report
created: <MM-DD-YY>
sessions_scanned: <count>
candidates_found: <count>
candidates_proposed: <count>
tags: [forge, doctrine-evolution]
---

# Forge Report -- <MM-DD-YY>

## Candidates proposed
| Pattern | Recurrence | Promotion target | Notes |
|---|---|---|---|
| <one-line description> | <N sessions> | new skill /<name> | <why> |

## Candidates rejected (under threshold)
- <pattern>: only <N> hits, watch for more

## Recommended next action
- <which candidate to build first, why>
``````

## After
1. Surface the top 1-3 candidates with concrete proposals for what they'd look like
2. Don't auto-create the skill/rule/specialist — Andy approves the promotion
3. Append Activity Log row
4. If approved, hand off to the relevant creator skill (``/specialist-creator`` for specialists, direct edits to ``setup-claude-skills.ps1`` for new skills, direct edits to ``Rules/`` for new rules)

## Don't
- Don't propose patterns that already exist (re-check the registry before reporting)
- Don't propose anything that recurred only in one mega-session — that's narrowness, not pattern strength
- Don't auto-promote — promotion is Andy's choice, you propose
- Don't include the full source quotes — distill to the pattern, link to source
"@
    }

    "revive" = @{
        Description = "Scan every project in 02 - Projects/ (and follow path: frontmatter to on-disk location), check git activity, surface dormant projects with one-page resurrection plans. Use when Andy says revive, resurrect, dormant projects, what projects could I pick back up, find stalled work."
        Body = @"
# Revive

Inspired by the REVIVE archetype from the /goal video. Walks every project in the vault, follows the frontmatter ``path:`` field to its on-disk location, checks git activity + remaining tests + last-edited dates, and surfaces dormant projects with concrete one-page resurrection plans.

## When to use
Triggers: ``revive``, ``resurrect``, ``dormant projects``, ``what projects could I pick back up``, ``find stalled work``, ``what have I been ignoring``.

Best run quarterly or when Andy is between major sprints and wants to scan for next-up candidates.

## Load
- ``02 - Projects/`` - all project pointer notes (each has ``path:`` frontmatter)
- ``Projects-Index.md`` - the auto-rolled list
- ``CLAUDE.md`` - drive map for context on where projects live
- For each project: the on-disk folder per ``path:`` field

## Run

### Phase 0 — Inventory
List every ``02 - Projects/<category>/<project>.md`` with: status (from frontmatter), category, path on disk.

### Phase 1 — Per-project scan
For each project:
- Read the pointer note
- Visit ``path:`` location on disk
- ``git log -1`` for last commit date
- Count files in the project folder (rough scope signal)
- Check for ``README.md``, ``ROADMAP.md``, ``NEXT-SESSION-HANDOFF.md`` — these are resurrection material
- Look for tests / scripts that might still run

### Phase 2 — Classify

| Classification | Criteria |
|---|---|
| **Active** | Frontmatter ``status: active`` AND last commit within 30 days |
| **Recently dormant** | Last commit 30-90 days ago. Easy revival. |
| **Cold dormant** | Last commit 90-365 days ago. Resurrection takes context-loading effort. |
| **Archived** | Frontmatter ``status: archived`` OR no commits in >1 year. Leave alone unless Andy asks. |
| **Stub** | Pointer note exists but on-disk path is empty / missing. Either delete the stub or scaffold. |

### Phase 3 — Resurrection plan (recently/cold dormant only)

For each dormant candidate, produce a one-paragraph plan:

- **State at pause** — what was the last thing being worked on (from last commit message + latest README/ROADMAP)
- **First move to resume** — the single most useful 30-minute action to get unstuck
- **What's at risk if not revived** — does this depend on something that's bit-rotting?
- **Suggested model + skill** — ``/goal`` if the resumption is iterative; direct work if it's a single step

## Output

Write a revive report to ``01 - Daily Notes/<YYYY-MM-DD> - Revive Report.md``:

``````markdown
---
type: revive-report
created: <MM-DD-YY>
projects_scanned: <count>
active: <count>
recently_dormant: <count>
cold_dormant: <count>
archived: <count>
stubs: <count>
tags: [revive, projects]
---

# Revive Report -- <MM-DD-YY>

## Recommended pickups (ordered by ease + value)

### 1. <project-name>
- **Status:** recently dormant (last commit MM-DD-YY)
- **State at pause:** <one line>
- **First move:** <30-min action>
- **Risk:** <low/medium/high>
- **Suggested approach:** <model + skill>

### 2. <project-name>
...

## Cold dormant (revival possible but costly)
- <project>: <reason it might still matter>

## Stubs to resolve
- <project>: pointer note at <path> but on-disk path missing. Delete or scaffold?

## Leave alone (archived)
- <project>: <reason>
``````

## After
1. Surface the top 1-3 pickup candidates with their first moves
2. Don't auto-resume — Andy chooses what to pick up
3. If Andy picks a candidate, hand off to ``/project-scaffolder`` if scaffolding is needed, or just open the project's path
4. Append Activity Log row

## Don't
- Don't propose reviving archived projects unless Andy explicitly asks
- Don't auto-delete stub pointer notes — surface them, let Andy decide
- Don't grade projects by line count — small-but-shipped beats big-but-stalled
- Don't ignore the ``path:`` frontmatter — projects live on disk, not in the vault
- Don't run on every project list at once if there are >20 — paginate the report
"@
    }

    "report" = @{
        Description = "Voice-and-HTML project report. Invokes the presenter specialist in voice-report mode. Use when Andy says: provide a report on <project>, give me a status report, walk me through <project>, voice report, deck on <project>."
        Body = @"
# Report

Voice-report mode of the [[03 - Skills & Rules/Agents/Specialists/presenter|presenter specialist]]. Generates a synchronized HTML deck + markdown report on a named project and delivers it by voice while the deck renders live.

## When to use
Triggers: ``provide a report on X``, ``give me a status report``, ``walk me through X``, ``voice report``, ``deck on X``, ``where's X at``.

Best run when you have a few minutes and want a structured catch-up on a project you haven't touched in a while.

## Load
- ``03 - Skills & Rules/Agents/Specialists/presenter.md`` - voice-report mode section is canonical
- ``02 - Projects/<category>/<project>.md`` - target project's pointer note
- The project's on-disk location (per ``path:`` frontmatter) - for recent git log + file list
- ``03 - Skills & Rules/Agents/Activity Log.md`` - rows mentioning the project
- ``03 - Skills & Rules/Agents/memory/<dept>/projects/<project>.md`` - any project-scoped agent memory
- ``04 - Templates/Presenter Deck Template.html`` - HTML deck shell

## Confirm inputs
1. Project name (must resolve to a pointer note in ``02 - Projects/``)
2. Length preference (short / medium / long) - shapes how much you pull in

## Run

1. **Acknowledge in voice**: "Pulling the report on <project>."
2. **Research** the project files per the Load list. Don't generate from training knowledge.
3. **Generate two artifacts simultaneously**:
   - HTML deck → ``20 - Decks/<YYYY-MM-DD> Report — <project>.html``
   - MD report → ``00 - Chats/Reports/<YYYY-MM-DD>-<project>-report.md``
4. **Render HTML deck in Cowork's native HTML viewer** in a side panel. Don't open it in a browser — keep voice + visuals in one window.
5. **Deliver the report by voice**, walking the deck slide-by-slide:
   - Title + status
   - TL;DR
   - Recent activity (timeline)
   - Status (working / broken / mid-stream)
   - Open threads
   - What's next
6. **Q&A interlude** at end. Capture new threads into the MD report.
7. **Wrap**: provide ``[Open the deck](computer://...)`` + ``[Open the report](computer://...)`` links in the chat.

## Output paths
- ``20 - Decks/<YYYY-MM-DD> Report — <project>.html`` (visual companion, opens in browser)
- ``00 - Chats/Reports/<YYYY-MM-DD>-<project>-report.md`` (text of record, vault-linked)

The two files reference each other: the MD's frontmatter has ``deck:`` pointing to the HTML; the HTML title slide links back to the MD.

## After
1. Append Activity Log row
2. Surface the two file links
3. Flip presenter.md ``status: idle`` if it was set active during the report

## Don't
- Don't deliver the voice report without the HTML rendering - both together is the point
- Don't read wikilinks aloud
- Don't skip the Q&A
- Don't generate from training - read the actual project files
- Don't run on a project that has no pointer note in ``02 - Projects/``
"@
    }
}

foreach ($name in $skills.Keys | Sort-Object) {
    $skillDir = Join-Path $SkillsDir $name
    New-Item -ItemType Directory -Force -Path $skillDir | Out-Null

    $def = $skills[$name]
    $content = @"
---
name: $name
description: $($def.Description)
---

$($def.Body)
"@
    $path = Join-Path $skillDir "SKILL.md"
    [System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "  [skill] $name/SKILL.md" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done. $(($skills.Keys).Count) skills installed at:" -ForegroundColor Cyan
Write-Host "  $SkillsDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "Test in Claude Code:" -ForegroundColor Yellow
Write-Host "  'scaffold a new project called test-x'           -> project-scaffolder" -ForegroundColor Yellow
Write-Host "  'write the commit message for these changes'     -> commit-message-writer" -ForegroundColor Yellow
Write-Host "  'start today's daily note'                       -> daily-note-writer" -ForegroundColor Yellow
Write-Host "  'codify this as a workflow'                      -> workflow-author" -ForegroundColor Yellow
Write-Host "  'add a specialist called X'                      -> specialist-creator" -ForegroundColor Yellow
Write-Host "  'apply the latest drift audit'                   -> drift-fix" -ForegroundColor Yellow
Write-Host "  'handoff' / 'wrap up'                            -> handoff" -ForegroundColor Yellow
Write-Host "  'audit the vault'                                -> audit" -ForegroundColor Yellow
Write-Host "  'sweep the inbox'                                -> sweep-inbox" -ForegroundColor Yellow
Write-Host "  'compile a topic note on X'                      -> compile-topic" -ForegroundColor Yellow
Write-Host "  'do a retro' / 'close the loop'                  -> retro" -ForegroundColor Yellow
Write-Host "  'forge' / 'mine the sessions'                    -> forge" -ForegroundColor Yellow
Write-Host "  'revive' / 'find dormant projects'               -> revive" -ForegroundColor Yellow
Write-Host "  'report on X' / 'walk me through X' (voice)      -> report" -ForegroundColor Yellow

# === Auto-regen vault skill docs so the Obsidian sidebar stays in sync ===
Write-Host ""
$generator = Join-Path $VaultRoot "22 - Scripts\generate-skill-docs.ps1"
if (Test-Path $generator) {
    Write-Host "[chain] Running generate-skill-docs.ps1 to refresh vault docs..." -ForegroundColor Cyan
    & $generator -VaultRoot $VaultRoot
} else {
    Write-Host "[note] generate-skill-docs.ps1 not found -- vault docs at '03 - Skills & Rules/Skills/' may be stale." -ForegroundColor Yellow
}
