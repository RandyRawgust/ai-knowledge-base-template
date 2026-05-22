---
type: how-to
created: 05-22-26
updated: 05-22-26
tags: [how-to, cowork, setup]
---

# Cowork Project Setup — AI Knowledge Base

How to configure the **AI Knowledge Base** as a Cowork Project so every chat starts with vault doctrine loaded and obeys [[../../03 - Skills & Rules/Rules/style-announce-role]] from the first token.

## How Cowork projects actually work

A Cowork project has exactly four pieces (per [Anthropic's docs](https://support.claude.com/en/articles/14116274-organize-your-tasks-with-projects-in-claude-cowork)):

- **Instructions** — the text field. Custom system prompt overlay.
- **Context** — a connected folder (the vault), a linked chat project, or a URL.
- **Scheduled tasks** — recurring jobs scoped to the project.
- **Memory** — automatic carryover between conversations.

**There is no separate "Project Knowledge" upload cache.** The "Add files" option that appears in the create-a-project dialog is creation-time-only — it disappears after the project exists, and uploaded files can't be replaced or updated later. So uploading files for doctrine that will *ever* change is a trap: the upload goes stale the moment you edit the source in the vault.

The right architecture is BOOT instructions: tell agents to Read the doctrine from the connected folder at session start. The folder is always current. The instructions are always current. Nothing to sync.

## Architecture: connected folder + BOOT instructions

```
Cowork Project
├── Instructions   ← BOOT directive + style + conventions (text in the field)
├── Context        ← connected to E:\Projects\AI Knowledge Base
├── Scheduled tasks (project-specific; optional)
└── Memory         (automatic)
```

What you get:

| Mechanism | Loads | Always current? |
|---|---|---|
| CLAUDE.md auto-load | Cowork reads vault-root `CLAUDE.md` into every conversation's system prompt | Yes — read from disk each session |
| BOOT directive in Instructions | Agent Reads the listed doctrine files on the first turn of every session | Yes — file tools hit live disk |
| On-demand Reads | Agent Reads specialists, skill bodies, project notes, etc. as needed during the session | Yes |

No upload step. No re-upload step. Edit a doctrine file in the vault and the next session sees the change.

## Creating the project

In Cowork's left nav, click **Projects → "+"** then pick:

- **"Use an existing folder"** — recommended for this vault. Point at `E:\Projects\AI Knowledge Base`. Name the project (e.g. "AI Knowledge Base"). Paste the BOOT instructions below into the Instructions field. **Skip the "Add files" section** — that's the stale-upload trap.
- **"Start from scratch"** — for new sub-projects; not for the master vault.
- **"Import from a Claude project"** — only if you've been working in a Claude.ai web project and want to lift its instructions over.

Click Create. Done.

## Custom Instructions — paste this into the project

```text
You are operating inside Andy's AI Knowledge Base vault at E:\Projects\AI Knowledge Base. CLAUDE.md (auto-loaded by Cowork from the connected folder) is your operating doctrine — read it as authoritative.

BOOT SEQUENCE — on the FIRST turn of every new session, before responding to Andy's message:

Read these doctrine files (they are not auto-loaded; you must Read them via the Read tool):
1. 03 - Skills & Rules/Rules/style-announce-role.md   — header / footer / frontmatter-flip law
2. 03 - Skills & Rules/Rules/style-no-sycophancy.md   — anti-flattery, always-on
3. 03 - Skills & Rules/Rules/engineering-doctrine.md  — research-first, default-to-action
4. 03 - Skills & Rules/Rules/memory.md                — per-agent memory protocol
5. 03 - Skills & Rules/Rules/vault-conventions.md     — frontmatter, dates, paths

Then route via CLAUDE.md's Decision Table to pick the right agent, flip its frontmatter to active per style-announce-role, emit the transparency header, and proceed.

BOOT happens once per session, not every turn. After the first turn, the doctrine is in context for the rest of the conversation.

ANNOUNCE-ROLE LAW. style-announce-role is non-negotiable on every turn. Header + frontmatter flip on every constructive turn. Footer when files are touched. See the rule for the full protocol.

STYLE. style-no-sycophancy applies to all responses — factual acknowledgments only, no flattery, challenge-by-default.

RESEARCH FIRST. engineering-doctrine governs all real work. Read existing notes and frontmatter before acting. Default to action when intent is clear and research is complete. Complete task chains — don't leave dangling threads.

MEMORY. Department heads read their pinned.md + universal.md at the start of every invocation per the memory rule. Project-specific memory loads when a project is in play.

CONVENTIONS. Filenames use ISO YYYY-MM-DD. Frontmatter and prose use MM-DD-YY. Wikilinks [[name]] for vault refs; markdown [label](file:///...) for external paths. Folders use NN - Name tier prefixes. The vault is text-only — no binaries except 04 - Templates/Presenter Deck Template.html.

FILES. The connected folder is the entire vault. Read any file via the Read tool when you need it — specialists at 03 - Skills & Rules/Agents/Specialists/*.md, skill bodies at .claude/skills/<name>/SKILL.md or vault docs at 03 - Skills & Rules/Skills/*.md, projects at 02 - Projects/, daily notes at 01 - Daily Notes/, templates at 04 - Templates/, scripts at 22 - Scripts/. Don't ask Andy to paste files that are already in the vault — go read them.

AT TURN END. Append a row to 03 - Skills & Rules/Agents/Activity Log.md for any constructive turn. Format documented in CLAUDE.md and style-announce-role.md.

PARALLEL DISPATCH. Before running sub-agents sequentially, ask: could these run independently? If yes, dispatch in a single Agent call block with multiple tool-use blocks. Default parallel for audits, research, multi-file refactors. Default sequential only when B truly needs A's output. Every Task-tool dispatch carries the TCE preamble (Section IX of tce-vocabulary.md) so sub-agents can read AND respond in the codec.
```

That's the entire setup. No file uploads. The Instructions field above + the connected folder is everything Cowork needs.

## Verification — first session after setup

In a fresh chat in the new project, ask: *"What's the operating doctrine for this vault?"*

A correctly-configured agent should:

1. Read the 5 BOOT files via file tools — you'll see Read calls in the trace
2. Emit a transparency header on the first response (🟦 / 🟢 / 🟣 / 🟡 / 🔴)
3. Cite CLAUDE.md by name and reference the Decision Table
4. Flip the active agent's frontmatter (check `03 - Skills & Rules/Agents/<Agent>.md` — `status` should be `active` during the response, `idle` after)
5. Not paraphrase or invent doctrine — the answer should be verifiably grounded in what's on disk

If BOOT files don't get Read, the Instructions field didn't save or the BOOT directive wasn't strong enough. Recheck the Instructions text.

## Maintenance — nothing to do

This is the whole point of the BOOT model: there is no maintenance step when you edit doctrine. Edit a file in the vault, and the next session reads the updated version.

The only time you re-touch the Cowork project is if you want to:

- Change the BOOT file list (e.g., promote a new rule to always-load) → edit the Instructions field
- Add a new style directive that should be always-on → either add it to the BOOT list or inline it in the Instructions
- Move the vault → reconnect the folder

## Why I almost got this wrong (history note)

Earlier in this session I drafted a tiered upload plan (Tier 1 mandatory, Tier 2 strongly recommended) modeled on Claude.ai web Projects, which DO have a separate Project Knowledge cache. Cowork projects don't have that — uploads at creation time can't be edited later, making them stale-by-design for any evolving doctrine.

The mid-session course correction:

1. Removed `cowork_tier: N` frontmatter from all 15 doctrine files (was tracking which files to upload — meaningless under BOOT model)
2. Removed the "🔁 NEEDS REUPLOAD to Cowork" footer callout from `style-announce-role.md` (no cache to re-upload to)
3. Rewrote this guide as the BOOT-only doctrine you're reading

If you've already created a Cowork project with files uploaded at creation, those uploads are now redundant and slightly stale — but harmless. The BOOT directive will tell agents to Read the current versions from the folder, so the uploaded copies are just dead weight in the project context. Recreate the project if you want a clean slate; otherwise leave it.

## Related

- [[../../03 - Skills & Rules/Rules/style-announce-role]]
- [[../../CLAUDE]]
- [[../../03 - Skills & Rules/README]]
- [[05-vault-index]] — the index this guide assumes you've at least skimmed
