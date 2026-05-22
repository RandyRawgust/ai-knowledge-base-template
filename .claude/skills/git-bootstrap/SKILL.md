---
name: git-bootstrap
description: Initialize git on a project, set up .gitignore, first commit, create the GitHub repo, push. Use when starting version control on any project for the first time.
---

# Git Bootstrap

## When to use
Triggers: git init, set up git, bootstrap git, put this on GitHub.

## Preferred path
Run the existing script:
```powershell
cd "<project-path>"
& "E:\Projects\AI Knowledge Base\22 - Scripts\git-bootstrap.ps1" -Path "<project-path>" -Name "<repo-name>"
```
Add `-Public` if shareable.

## Per-project visibility defaults
- AI Knowledge Base, TerraWatt, KSP*, Command Center: `private`
- Fundamentals of Coding: `public` when ready

## Don't
- Don't init without .gitignore (sweeps junk)
- Don't commit secrets - check .env / API keys first
- Don't push vault publicly (personal memory + activity log)