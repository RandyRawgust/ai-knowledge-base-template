---
name: workflow-author
description: Scaffold a new workflow markdown file with triggers/agents/steps frontmatter, then auto-regenerate the sibling canvas. Use when Andy says codify this as a workflow, make this a workflow, save this recipe.
---

# Workflow Author

## When to use
Triggers: codify this as a workflow, make this a workflow, save this recipe, turn this into a workflow.

## Load
- `03 - Skills & Rules/Rules/workflow-spec.md` - mandatory format
- Existing workflows as reference: `05 - Workflows/audit-pass.md`, `05 - Workflows/git-bootstrap.md`

## Confirm
1. Workflow slug (lowercase-hyphens)
2. Trigger phrases (what user words invoke it)
3. Owning agent(s) (Builder? Auditor? Specialist?)
4. The ordered steps (with optional `[agent-name]` prefix per step)

## Create
`05 - Workflows/<slug>.md` with:
```yaml
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
```

Body sections: When to invoke, Inputs, Steps (numbered, optionally with `[agent]` prefix), Outputs, Status markers, Anti-patterns, Retrospective.

## After creating
Workflow .canvas siblings were retired 05-17-26 — markdown-only is the current convention (see [[03 - Skills & Rules/Rules/superseded-infra]]). No canvas regen step.

## Don't
- Don't create a workflow for one-shot work - workflows are for recurring patterns
- Don't skip the anti-patterns section - that's where the gotchas live
- Don't forget triggers - without them, agents can't auto-route to the workflow