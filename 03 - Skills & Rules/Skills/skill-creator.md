---
type: skill
category: meta
source: cowork-builtin
tags: [skill, meta]
source: anthropic
external: true
---

# skill-creator — Skills Workshop

Meta-skill for creating, modifying, and measuring other skills.

## Capabilities

- Create new skills from scratch
- Edit / improve existing skills
- Run evals to test skill triggering accuracy
- Benchmark skill performance
- Optimize skill descriptions for better triggering

## Used by

- This vault — when we want to package a frequently-used prompt as a real
  Cowork skill instead of just a Markdown agent note

## Pattern

When you find yourself running the same agent prompt 5+ times, that's a
signal it should become a skill. Use skill-creator to formalize it.
