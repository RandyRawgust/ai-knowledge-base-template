---
type: index
created: 2026-05-09
updated: 2026-05-13
tags: [index, skills, rules, agents]
---

# Skills & Rules

Central registry for AI capability across Andy's system. Lets you see, in one
place, what your AI tools know how to do, what conventions they follow, and
which projects use which.

## The four categories

| Category | What it is | Examples |
|---|---|---|
| **Skills** | Capabilities — things the AI can *do* | docx, pdf, course-builder, schedule |
| **Rules** | Conventions / format guides — how to do it | engineering-doctrine, vault-conventions, memory |
| **Agents** | Named prompts — packaged "ask the AI to X" | Orchestrator, Builder, Writer, Archivist, Auditor |
| **Workflows** | Project-specific sequenced recipes — how a recurring task is run | audit-pass, git-bootstrap, new-phase-kickoff |

## Rules

Foundational doctrine that all agents reference via `uses_rules:` frontmatter:

| Rule | Scope | Type |
|---|---|---|
| [[Rules/engineering-doctrine]] | Universal | Foundational doctrine — research-first, code over docs, autonomous execution, etc. |
| [[Rules/memory]] | Universal | Per-agent memory protocol (pinned / universal / project / recent) |
| [[Rules/workflow-spec]] | Universal | Format spec for workflow.md files (4th category) |
| [[Rules/claude-features]] | Universal | Living registry of Claude/Cowork features with when-to-suggest guidance |
| [[Rules/vault-conventions]] | Vault | Frontmatter, links, dates, naming |
| [[Rules/project-readme]] | Vault | Standard project README layout |
| [[Rules/course-format]] | Vault | Course lesson format |
| [[5S_STANDARD]] | Vault | File standard + 5S audit cadence (at vault root) |

Playbooks (structured mission templates):

| Playbook | When to use |
|---|---|
| [[Rules/playbook-request]] | New features, refactors, planned changes |
| [[Rules/playbook-refresh]] | Persistent bugs where prior fixes failed |
| [[Rules/playbook-retro]] | Post-session: distill durable lessons → update doctrine |

Stackable style directives:

| Style | When |
|---|---|
| [[Rules/style-concise]] | Procedural / reports, when Andy wants tight comms |
| [[Rules/style-no-sycophancy]] | Always on — no flattery, factual acknowledgments only |

## How to use it

1. **Browse**: open `Skills/`, `Rules/`, or `Agents/` to see what's available
2. **Compose**: a project note declares its toolbox in frontmatter:

   ```yaml
   skills: [course-builder, lesson-writer]
   rules: [course-format, vault-conventions, engineering-doctrine]
   ```

3. **Apply at the project level**: drop a `CLAUDE.md` into a project folder
   (or paste it into a Claude.ai project's "Project knowledge"). That
   CLAUDE.md references the relevant skills/rules so any AI working there
   has consistent behavior.

4. **Visualize**: Obsidian Graph view shows skill ↔ project connections.
   Dashboard has live agent status boards driven by Dataview frontmatter queries.

## Conventions

- One markdown file per skill / rule / agent
- Filename = slug (lowercase, hyphenated)
- Frontmatter declares `type` and what it links to
- Body is short — links + the actual prompt/rule text + which projects use it

## Existing Cowork skills (docs to populate)

These are the skills that ship with your Cowork install. Each should have a
node here so the graph can reference them:

- [[Skills/docx]] — Word doc creation, editing, manipulation
- [[Skills/pdf]] — PDF read/extract/create/merge/split/forms
- [[Skills/pptx]] — PowerPoint deck creation, slide editing
- [[Skills/xlsx]] — Excel spreadsheet handling, formulas, charts
- [[Skills/schedule]] — Scheduled task creation
- [[Skills/skill-creator]] — Create / edit / measure new skills

## Agents (the team)

5 department heads + specialists + project-specific agents. See [[Dashboard]] for live view.

### Department Heads (universal)

| Agent | Role | Color |
|---|---|---|
| [[Orchestrator]] | front-door routing | 🔴 red |
| [[Builder]] | creates new things | 🔵 blue |
| [[Writer]] | improves text content | 🟣 purple |
| [[Archivist]] | compiles + organizes | 🟢 green |
| [[Auditor]] | watches + reports | 🟡 amber |

### Specialists (delegated from dept heads)

Live in `Agents/Specialists/`:

**Builder's:**
- [[Specialists/course-builder]] — scaffolds new courses
- [[Specialists/project-scaffolder]] — standard project folder skeletons

**Writer's:**
- [[Specialists/lesson-writer]] — writes lesson content
- [[Specialists/doc-improver]] — rewrites existing docs
- [[Specialists/presenter]] — live HTML deck during voice chat

**Archivist's:**
- [[Specialists/topic-compiler]] — Karpathy-wiki style topic notes from sources
- [[Specialists/summary-writer]] — chat / session summaries

**Auditor's:**
- [[Specialists/inbox-sweeper]] — Inbox review
- [[Specialists/drift-watcher]] — vault drift detector
- [[Specialists/weekly-summarizer]] — Sunday digest

### Project-specific agents

Live in `Agents/Projects/<project>/`. Each project that needs forked-from-universal agents (per the doctrine: don't bake project-specific rules into universal agents) maintains its own roster under its own folder. See each project's README for its current agent list. The Dashboard "Project-specific agents" Dataview table surfaces all of them live.

See [[Activity Log]] for what each agent has been doing.
Each dept head has a memory folder at `Agents/memory/<DeptHead>/` per [[Rules/memory]].


## Workflows (per-project sequenced recipes)

A workflow is a markdown file describing how a recurring task is executed within a project. One `.md` per workflow; an auto-generated `.canvas` sibling visualizes the steps. See [[Rules/workflow-spec]] for the format.

### Where they live

| Scope | Path |
|---|---|
| **AI OS (this vault)** | `05 - Workflows/<slug>.md` at vault root |
| **Project workflows** | `<project-root>/workflows/<slug>.md` (e.g., TerraWatt's workflows ship with the project) |

### Current AI OS workflows

- [[../05 - Workflows/audit-pass|audit-pass]] — vault drift sweep
- [[../05 - Workflows/git-bootstrap|git-bootstrap]] — init git, write .gitignore, first commit, push to GitHub
- [[../05 - Workflows/new-phase-kickoff|new-phase-kickoff]] — declare a new phase, update ROADMAP, seed memory

(Note: workflow `.canvas` sibling files were retired 05-17-26 — workflows are markdown-only now. See [[03 - Skills & Rules/Rules/superseded-infra|superseded-infra registry]].)

[[Specialists/drift-watcher]] also rebuilds the