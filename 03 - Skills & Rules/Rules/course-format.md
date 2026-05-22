---
type: rule
scope: courses
applies_when: AI is creating or modifying course content
tags: [rule, courses]
---

# Course Format

Standard structure for courses + lessons. Used by [[course-builder]] and
[[lesson-writer]] agents.

## Folder layout

```
13 - Courses\<course-slug>\
├─ README.md          (course meta + lessons list)
├─ 01-<lesson>.md
├─ 02-<lesson>.md
├─ ...
└─ exercises\         (optional)
```

## Course README frontmatter

```yaml
---
type: course
status: active | paused | completed
created: MM-DD-YY
topic: <one-line description>
total_lessons: <N>
audience: <beginner | intermediate | advanced>
estimated_hours: <N>
format: markdown | interactive-html       # which lesson format the course uses
disk_path:                                 # required if format: interactive-html
  # The on-disk folder where this course's HTML lessons live.
  # E.g., E:\Projects\Courses\fundamentals-of-coding
  # Each course picks its own path; no global location.
tags: [course]
---
```

Body sections (in this order):
1. Title (h1)
2. One-paragraph synopsis
3. `## Lessons` — wikilink list to each lesson note
4. `## Status` — current progress
5. `## Resources` — external links, books, related notes
6. `## Notes` — anything else

## Lesson frontmatter

```yaml
---
type: lesson
course: <course-slug>
order: <N>
status: not-started | in-progress | completed
completed:           # YYYY-MM-DD when marked completed
estimated_minutes: <N>
tags: [lesson]
---
```

Body sections (in this order):
1. Title (h1) — `<N> — <Lesson Title>`
2. `## What you'll learn` — 2-4 bullets
3. `## Content` — main lesson body
4. `## Exercises` — numbered list, with answer keys at bottom or hidden
5. `## Next` — wikilink to next lesson

## Two lesson formats

**Plain markdown** (default) — body content is prose, code blocks, exercises directly in the `.md`. Lives in the vault at `13 - Courses\<course-slug>\<NN>-<lesson>.md`.

**Interactive HTML + MD wrapper (split between disk and vault)** — for richer lessons. Per CLAUDE.md the vault is text-only; HTML files live on disk in a folder of the course author's choosing, and the vault keeps only the tracker `.md`:

```
On disk (per-course path, declared in the course README's `disk_path:` frontmatter):
<chosen disk path, e.g. E:\Projects\Courses\<course-slug>\>
├─ 01-<lesson>.html       (the actual interactive lesson — open in browser)
├─ 02-<lesson>.html
└─ ...

In vault:
13 - Courses\<course-slug>\
├─ README.md              (course meta + lessons list + `disk_path:` declaration)
├─ 01-<lesson>.md         (tracker: frontmatter + link to the HTML + reflections)
├─ 02-<lesson>.md
└─ ...
```

Each course picks its own disk path — there's no universal "all HTML courses go here" folder. For example, `fundamentals-of-coding` lives at `E:\Projects\Courses\fundamentals-of-coding\`, but a game-dev tutorial course might live under `F:\Game Dev\Tutorials\<slug>\`. Whatever fits the course's domain.

The `.md` keeps `format: interactive-html` in frontmatter and a top-of-body link to the on-disk HTML at the course's chosen path:

```markdown
## Open the lesson

[Open in browser](file:///<disk-path>/<NN>-<lesson>.html)

> HTML lesson lives on disk at `<disk-path>` (vault holds only this tracker `.md`).
```

Use HTML+MD when the lesson benefits from interactivity (quizzes with feedback, progress bars, custom typography, inline diagrams). Use plain markdown for straightforward conceptual lessons.

[[fundamentals-of-coding]] uses the hybrid pattern. Its README's `disk_path:` points to `E:\Projects\Courses\fundamentals-of-coding\` — that's specific to this course, not a global rule.

## Why HTML on disk, not in vault

CLAUDE.md doctrine: "Vault holds text only. No binary files in vault (PNG / JPG / SVG / MP4 / PDF / ZIP / HTML — exceptions for `04 - Templates/Presenter Deck Template.html`)." HTML lesson files don't qualify for the Presenter exception, so they live on disk. The vault keeps the tracker `.md` (lightweight, queryable via Dataview, frontmatter-driven). When a course gets retired or archived, the on-disk folder can be moved/deleted independently of the vault tracker.

## Used by

- [[course-builder]] — agent that builds whole courses
- [[lesson-writer]] — agent that writes individual lessons
- [[02 - Projects/Misc/Education]] — project that consumes courses
- [[fundamentals-of-coding]] — concrete course following this rule (HTML+MD variant)
