---
type: software
category: dev-tool
installed: true
install_location: C:\Program Files\Git
publisher: Git SCM
license: free
last_used: 
tags: [version-control, dev]
---

# Git

Version control. For any project that grows past a single file or that you
might want to roll back, init a git repo.

## Touches

- Any [E:\Projects\<project>](file:///E:/Projects) folder that's a repo
- [E:\Projects\AI Knowledge Base](file:///E:/Projects/AI%20Knowledge%20Base) — *consider* git-tracking the vault for note history (or use Obsidian's File Recovery instead)

## Powers / Used by

- [[02 - Projects/Game Dev/TerraWatt]] — C+Raylib project, definitely tracked
- [[KSP RPG]] — Apps Script project, tracked via clasp + git
- Any future code project

## Related software

- [[python]], [[claude-code]] — common pairings
- GitHub CLI (`gh`) — separate install, lets you create/clone/PR from terminal

## Notes

- Don't commit secrets (use `.gitignore` + `.env`)
- For the vault: `git init` in `E:\Projects\AI Knowledge Base`, ignore
  `.obsidian/workspace.json` (changes too often to be useful in history)
- Suggested vault `.gitignore`:
  ```
  .obsidian/workspace.json
  .obsidian/workspace-mobile.json
  .obsidian/cache
  ```
