---
type: course
status: active
created: 05-06-26
topic: Computer literacy → terminal fluency → Python → reading C → working with Claude
audience: beginner
total_lessons: 12
estimated_hours: 18
schedule: Wednesdays 7:15-8:45 PM (90 min)
format: interactive-html
disk_path: E:\Projects\Courses\fundamentals-of-coding
aliases: [fundamentals-of-coding]
tags: [course, coding, education]
---

# Fundamentals of Coding

A 12-week on-ramp from "I just got comfortable with a computer" to "I can read code, use a terminal, and contribute to my own game project."

Custom-built path: not a generic Python course. Optimized for getting Andy from total beginner → functional with [[02 - Projects/Game Dev/TerraWatt]] (C/Raylib game) and confident working with [[claude-code]] / [[cowork]].

## Format

Each lesson is an **interactive HTML file** with sections, hands-on activities, and a quiz at the end. **HTMLs live on disk** at `E:\Projects\Courses\fundamentals-of-coding\`, not in the vault — per CLAUDE.md doctrine the vault is text-only. The vault keeps `.md` tracker files (progress, frontmatter, reflections) and Dataview queries; the `.md` files point at the HTMLs via `file:///` links.

Why HTML, not markdown? The lessons have interactive quizzes with feedback, progress bars, and richer typography than markdown supports. The on-disk HTML + in-vault `.md` split keeps the vault clean while giving the lessons full browser capabilities.

## Schedule

Wednesday 7:15-8:45 PM blocks. One lesson per week. Don't try to double up; the spaced practice matters more than speed.

## Lessons

| # | Title | Status |
|---|-------|--------|
| 1 | [[01-computer-and-terminal-basics\|Computer & terminal basics]] | available |
| 2 | [[02-files-paths-and-vs-code\|Files, paths, and a real text editor (VS Code)]] | available |
| 3 | [[03-what-is-code\|What is "code"? Variables, data, your first Python script]] | not-yet-built |
| 4 | [[04-loops-and-conditionals\|Loops and conditionals]] | not-yet-built |
| 5 | [[05-functions\|Functions: bundling instructions you'll reuse]] | not-yet-built |
| 6 | [[06-lists-and-dictionaries\|Lists and dictionaries]] | not-yet-built |
| 7 | [[07-reading-and-writing-files\|Reading and writing files with code]] | not-yet-built |
| 8 | [[08-errors-and-debugging\|Errors, debugging, and reading what's broken]] | not-yet-built |
| 9 | [[09-git-basics\|Git basics: saving snapshots of your work]] | not-yet-built |
| 10 | [[10-reading-c-code\|Reading C code (so TerraWatt stops looking like hieroglyphs)]] | not-yet-built |
| 11 | [[11-working-with-claude\|Working with Claude effectively as you code]] | not-yet-built |
| 12 | [[12-capstone\|Capstone: build something small from scratch]] | not-yet-built |

## Status

Active. Week 1 built and ready to run. Weeks 2-12 scaffolded; build them as you finish the prior week (don't pre-build all 12 in case Week 1 needs calibration).

## How to use this

1. Wednesday block: open the HTML for the current week alongside PowerShell
2. Work through sections, do activities in PowerShell, take the quiz
3. Mark the lesson `status: completed` and set `completed: <date>` in its `.md` frontmatter
4. After completing, leave a note in the `.md` "Reflections" section — what worked, what was confusing
5. Tell [[lesson-writer]] (or just Claude in this vault) to build next week's HTML, calibrated to your reflections

## Resources

- [[claude-code]] — terminal AI sibling, good practice partner once you're past Week 1
- [[python]] — installed at `C:\Users\<YOUR-USERNAME>\AppData\Local\Programs\Python\Python312`
- [[git]] — installed at `C:\Program Files\Git`
- [[02 - Projects/Game Dev/TerraWatt]] — the eventual destination project
