---
type: rule
created: 2026-05-13
applies_to: [all-agents, all-projects]
tags: [rule, workflow, format]
---

# Workflow Spec

Defines the format of a workflow file. Workflows describe **how a recurring task is sequenced inside a project**. They sit alongside Skills, Rules, and Agents as the fourth category in the system.

## Where workflows live

| Scope | Path |
|---|---|
| **Project-specific** (TerraWatt, KSP RPG, future projects) | `<project-root>/workflows/<slug>.md` next to the project's `CLAUDE.md` |
| **AI OS itself** (the vault is the project) | `<vault-root>/05 - Workflows/<slug>.md` |

One workflow per file. One project can have many workflows. Workflows are markdown-only — no canvas siblings (deprecated 05-17-26; the canvas-mirror system was removed in favor of `14 - How To/` for visual tutorials).

## The workflow.md format

```markdown
---
type: workflow
project: <project name>
name: <slug, kebab-case>
status: active | dormant | archived
created: YYYY-MM-DD
updated: YYYY-MM-DD
agents: [list of agents/specialists owning steps]
triggers: ["phrase 1", "phrase 2"]
tags: [workflow]
---

# Workflow — <Human-readable name>

**When to invoke:** one-sentence description of the trigger condition.

## Inputs
- What the workflow needs to start (file paths, parameters, context).

## Steps

1. **[agent-name]** Specific action taken by that agent.
2. **[agent-name]** Next action.
3. Plain step with no specific agent (just the action).
4. **[agent-name]** Action with conditional notes: *if X, do Y; else, skip.*
...

## Outputs
- What gets produced when the workflow completes.

## Status markers used in this workflow
- ✅ — step complete
- ⚠️ — recoverable issue handled autonomously
- 🚧 — blocked, awaiting input

## Anti-patterns
- Don't skip step N — it's there because of [reason].
- Don't combine steps M and N — they need to happen separately because [reason].

## Retrospective
> Append durable lessons after major runs of this workflow.
- 
```

## Step formatting rules

- **Numbered list**, always. Steps are sequential by default.
- **`[agent-name]` prefix is OPTIONAL.** Only use it when the step is genuinely owned by a specific agent or skill. Plain prose steps are fine.
- One step = one verb. If you want to combine two verbs ("read X AND fix Y"), they're really two steps — split them.
- Edge cases / conditionals go *inside* the step in italics, not as separate steps.
- Parallel steps: use a sub-list under a parent step that says "in parallel:".

## CLAUDE.md integration

Every project's `CLAUDE.md` should have a section like:

```markdown
## Workflows

Detailed sequences for recurring work in this project live in `./workflows/`:

- [[workflows/<slug>|<workflow name>]] — one-line summary
- [[workflows/<slug>|<workflow name>]] — one-line summary
```

When an agent loads a project's CLAUDE.md per the [[memory|memory rule]], it sees the workflow list. If the current task matches a workflow's trigger phrases, the agent reads that workflow.md and follows it.

## Examples in this vault

- [[../../05 - Workflows/audit-pass|audit-pass]] — vault drift sweep
- [[../../05 - Workflows/git-bootstrap|git-bootstrap]] — init + commit + push to GitHub
- [[../../05 - Workflows/new-phase-kickoff|new-phase-kickoff]] — what to do when starting a new AI OS phase

## Anti-patterns for workflows themselves

- **Don't write a workflow that's only one step.** It's not a workflow, it's a Skill or a one-off.
- **Don't write a workflow for a task that happens once.** Workflows are for recurring patterns.
- **Don't bake project-specific details into a workflow that should be reusable.** If it could apply elsewhere, abstract it.
