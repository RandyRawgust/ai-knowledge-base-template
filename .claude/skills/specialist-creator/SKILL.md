---
name: specialist-creator
description: Scaffold a new specialist agent definition under 03 - Skills & Rules/Agents/Specialists/ with correct frontmatter. Use when adding a new agent role under one of the 5 dept heads.
---

# Specialist Creator

## When to use
Triggers: add a specialist, new specialist, create a sub-agent, extend Builder/Writer/Archivist/Auditor.

## Load
- Existing specialists as reference: `03 - Skills & Rules/Agents/Specialists/`
- Parent dept-head's spec (Builder.md / Writer.md / Archivist.md / Auditor.md)

## Confirm
1. Specialist slug (lowercase-hyphens)
2. One-line tagline (used in tooltips)
3. Parent dept head (Builder / Writer / Archivist / Auditor / Orchestrator)
4. Rules it uses (uses_rules: array)
5. Skills it uses (uses_skills: array - subset of [docx, pdf, pptx, xlsx])
6. Model (sonnet default; opus for heavy reasoning)

## Create
`03 - Skills & Rules/Agents/Specialists/<slug>.md` with frontmatter:
```yaml
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
```

Body: role description, when invoked, inputs, process steps, outputs, don'ts.

## After creating
Update parent dept-head's `delegates_to:` list to include the new specialist.

## Don't
- Don't promote to `.claude/agents/` - per Andy's decision, specialists stay as dept-head delegates only
- Don't duplicate existing specialists - check the list first
- Don't skip the parent assignment - orphan specialists are an audit finding