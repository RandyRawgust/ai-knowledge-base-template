---
name: setup-pre-commit
description: Set up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests in the current repo. Use when Andy wants to add pre-commit hooks, set up Husky, configure lint-staged, or add commit-time formatting / typechecking / testing to a JS/TS project.
---

# Setup Pre-Commit Hooks

## What this sets up

- **Husky** pre-commit hook
- **lint-staged** running Prettier on all staged files
- **Prettier** config (if missing)
- **typecheck** and **test** scripts in the pre-commit hook

## When to use
Triggers: `set up pre-commit`, `add husky`, `lint on commit`, `commit-time formatting`, `pre-commit hook`.

Note: this is for **JS/TS** projects with `package.json`. For Andy's PowerShell-bootstrapped projects (TerraWatt, the vault), use `git-bootstrap` plus the hook PowerShell scripts in `22 - Scripts/`.

## Steps

### 1. Detect package manager
Check for `package-lock.json` (npm), `pnpm-lock.yaml` (pnpm), `yarn.lock` (yarn), `bun.lockb` (bun). Use whichever is present. Default to npm if unclear.

### 2. Install dependencies
Install as devDependencies:
```
husky lint-staged prettier
```

### 3. Initialize Husky
```
npx husky init
```
This creates `.husky/` and adds `prepare: "husky"` to package.json.

### 4. Create `.husky/pre-commit`
Write this file (no shebang needed for Husky v9+):
```
npx lint-staged
npm run typecheck
npm run test
```
**Adapt**: replace `npm` with the detected package manager. If repo has no `typecheck` or `test` script, omit those lines and tell Andy.

### 5. Create `.lintstagedrc`
```json
{
  "*": "prettier --ignore-unknown --write"
}
```

### 6. Create `.prettierrc` (if missing)
Only create if no Prettier config exists. Defaults:
```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

### 7. Verify
- `.husky/pre-commit` exists and is executable
- `.lintstagedrc` exists
- `prepare` script in package.json is `"husky"`
- Prettier config exists
- Run `npx lint-staged` to verify

### 8. Commit
Stage all changed/created files and commit with message: `chore: add pre-commit hooks (husky + lint-staged + prettier)`

This runs through the new pre-commit hooks — a good smoke test that everything works.

## Notes
- Husky v9+ doesn't need shebangs in hook files
- `prettier --ignore-unknown` skips files Prettier can't parse (images, etc.)
- The pre-commit runs lint-staged first (fast, staged-only), then full typecheck and tests

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/misc/setup-pre-commit) — 05-21-26. Added a note steering Andy's PowerShell projects toward `22 - Scripts/` hook scripts.

## Integrates with
- `03 - Skills & Rules/Skills/git-bootstrap.md` — typical predecessor; this skill runs after initial git setup
- `03 - Skills & Rules/Skills/commit-message-writer.md` — the commit hook respects whatever commit-message convention you're already using
