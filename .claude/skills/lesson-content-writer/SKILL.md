---
name: lesson-content-writer
description: Write the body of a course lesson following the lesson template (intro/concepts/exercises/answer key). Use when Andy says write lesson N, fill out lesson X, build out week Y.
---

# Lesson Content Writer

## When to use
Triggers: write lesson N, fill out lesson X, build out week Y, draft this lesson.

## Load
- `03 - Skills & Rules/Rules/course-format.md` - lesson template
- `03 - Skills & Rules/Agents/Specialists/lesson-writer.md` - canonical spec
- Writer's universal memory for tone: `03 - Skills & Rules/Agents/memory/Writer/universal.md`
- Existing lesson 1 as reference: `13 - Courses/fundamentals-of-coding/week-01-*/lesson-01-*.md`

## Confirm
1. Which course + week + lesson
2. Specific concept(s) the lesson covers
3. Difficulty assumption (what did the prior lesson cover?)

## Structure
```markdown
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
```

## Tone (per Writer memory)
- Warm, direct, professional. Human, not corporate.
- No "honestly", "genuinely", "feel free to", "great question".
- Sentence case. Length matches substance.

## Don't
- Don't write all 12 lessons in one go - one at a time
- Don't skip exercises - that's where learning happens
- Don't add tangential concepts - the lesson stays scoped