---
name: commit-message-writer
description: Draft a conventional commit message from the staged git diff. Use before any commit when the user asks you to write the message or generate one. Triggers: commit message, write a commit msg, generate commit, what should I commit this as.
---

# Commit Message Writer

## When to use
User about to commit, asks for a message. Or you're about to commit on their behalf and need to draft one.

## Process
1. Run `git diff --staged --stat` to see scope
2. Run `git diff --staged` to see actual changes
3. Identify the type:
   - `feat` - new feature
   - `fix` - bug fix
   - `docs` - documentation only
   - `refactor` - code change, no behavior change
   - `style` - formatting, whitespace
   - `test` - test additions or fixes
   - `chore` - build, deps, config
   - `perf` - performance
4. Identify the scope (e.g. `cc`, `vault`, `snake`, `hooks`, `agents`)
5. Write a one-liner: `<type>(<scope>): <imperative present-tense summary>`
6. First line max 72 chars. If more context needed, blank line + body.

## Examples
- `feat(cc): add script output dialog with stdout/stderr capture`
- `fix(snake): revert sprite-sheet to static PNG after animation glitches`
- `docs(roadmap): mark phase 10 complete, refresh status header`
- `chore(vault): propagate <YOUR-GH-HANDLE> GitHub handle to 5 dept-head memories`

## Don't
- Don't write "Updated X" - use imperative present: "update X"
- Don't add a period at the end of the subject line
- Don't reference internal session details Andy wouldn't want public
- Don't lie about scope if changes span multiple areas - use `misc` or split commits