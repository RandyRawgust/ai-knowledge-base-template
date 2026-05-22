---
type: workflow
project: AI-OS-Setup
name: git-bootstrap
status: active
created: 2026-05-14
updated: 2026-05-14
agents: [Builder, project-scaffolder]
triggers: ["git init", "set up git", "bootstrap git", "start using git"]
tags: [workflow, git, bootstrap]
---

# Workflow — Git Bootstrap

**When to invoke:** starting version control on a project (or the vault) for the first time. Andy wants all projects in version control on GitHub.

## Inputs
- Project root path (e.g., `E:\Projects\AI Knowledge Base`)
- GitHub username (default: `<YOUR-GH-HANDLE>`)
- Repo name (default: derived from folder name, lowercase-hyphenated)
- Visibility: `private` (default) or `public`

## Steps

1. **[Builder]** `cd` into the project root.
2. **[Builder]** Check if it's already a repo: `git rev-parse --is-inside-work-tree` — if yes, halt and report (don't double-init).
3. **[Builder]** Confirm `.gitignore` exists at root. For the vault, the canonical version lives at `E:\Projects\AI Knowledge Base\.gitignore`. For a new project, copy from `04 - Templates/_gitignore-template` (TBD if it exists) or write one matching the project type.
4. **[Builder]** `git init` + `git branch -M main`.
5. **[Builder]** First commit: `git add . && git commit -m "Initial commit — <project>"`.
6. **[Builder]** Create the GitHub repo via `gh`:
   ```bash
   gh repo create <YOUR-GH-HANDLE>/<repo-name> --private --source=. --remote=origin --push
   ```
   *(Requires `gh auth login` once. Use `--public` instead of `--private` for shareable projects.)*
7. **[Builder]** Verify: `git remote -v` shows origin, `git log --oneline` shows the first commit, `gh repo view` shows the repo.
8. **[Builder]** Update Activity Log:
   `| <date> | Builder | Git bootstrap for <project> — pushed to github.com/<YOUR-GH-HANDLE>/<repo> | .gitignore, git init | ✅ done | Repo live |`
9. **[Builder]** Add the repo to `MODEL_USAGE`-style config — there's no Repos config currently (Repos panel was removed), but when re-added, surface it there.

## Outputs
- Local git repo initialized
- GitHub repo created + pushed
- Activity Log row

## Status markers
- ✅ — repo on GitHub, pushed
- ⚠️ — local init done, push failed (auth or network) — report and retry
- 🚧 — blocked on `gh auth login` or missing GitHub access

## Anti-patterns

- **Don't `git init` without a `.gitignore`.** First commit will sweep up junk you have to undo later.
- **Don't commit secrets.** Re-check the `.gitignore` for `.env` files, API keys, OAuth tokens before the first push.
- **Don't push the vault publicly without reviewing memory + activity-log content.** They contain personal facts about Andy and conversation history.
- **Don't squash the initial commit.** Keep a clean "Initial commit" anchor so `git log --reverse` makes sense.

## Per-project guidance

| Project | Visibility default | Notes |
|---|---|---|
| AI Knowledge Base (this vault) | private | Memory + activity log have personal context |
| TerraWatt | private until released | C/Raylib game — release later |
| KSP Series | private | Video scripts + research |
| KSP RPG | private | Google Sheets export + design notes |
| Command Center | private | Single-file Python; nothing sensitive but no reason to publicize |
| Augys Lab (the site) | depends on existing setup | Probably already a repo |
| Fundamentals of Coding course | public when ready | The course content could be shared |

## Retrospective
> Append durable lessons.

- 
