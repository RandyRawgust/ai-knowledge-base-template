---
name: course-builder
description: Scaffold a 12-week course skeleton per course-format rule, or add new week to existing course. Use when starting a new course or extending the Fundamentals of Coding curriculum.
---

# Course Builder

## When to use
Triggers: build a course, scaffold a course, add week N, new lesson series, course outline.

## Load
- `03 - Skills & Rules/Rules/course-format.md` - mandatory structure
- `03 - Skills & Rules/Agents/Specialists/course-builder.md` - canonical spec
- Existing course as reference: `13 - Courses/fundamentals-of-coding/`

## Confirm inputs
1. Course slug (lowercase-hyphens, e.g. `fundamentals-of-coding`)
2. Audience level (beginner / intermediate / advanced)
3. Topic / domain (Python? React? Game dev?)
4. Number of weeks (default 12)

## Create
`13 - Courses/<slug>/` with:
- `README.md` (course-format-compliant; intro, prereqs, week index, completion criteria)
- `week-01-<topic>/` through `week-12-<topic>/` folders
- Each week: `README.md` (week intro) + `lesson-01-<topic>.md` stub
- `capstone/` folder for the final project

## Don't
- Don't auto-write lesson CONTENT - that's lesson-content-writer's job
- Don't pick week topics without confirming with Andy - course design is his call
- Don't duplicate Fundamentals - if topic overlaps, ask whether to extend or start fresh