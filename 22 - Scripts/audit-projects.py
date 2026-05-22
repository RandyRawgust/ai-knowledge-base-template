#!/usr/bin/env python3
"""Project audit — disk vs vault parity check.

For each project folder on disk (under E:\\Projects\\ and F:\\Game Dev\\Projects\\),
verify the vault has a corresponding directory-pointer note in
02 - Projects/<Category>/<Project>.md with frontmatter `path:` matching the
on-disk folder.

Run manually:  python 22 - Scripts/audit-projects.py
Auto-runs:     folded into drift-watcher-quarterly's checks

Exit codes:
  0 = clean (every project has a vault note, every vault note resolves)
  1 = drift detected (missing or orphan entries)
"""

import os
import re
import sys
from pathlib import Path

# --- config -----------------------------------------------------------------

VAULT = Path(__file__).resolve().parent.parent  # 22 - Scripts/ -> vault root

DISK_ROOTS = [
    Path(r"E:\Projects"),
    Path(r"F:\Game Dev\Projects"),
]

VAULT_PROJECTS_DIR = VAULT / "02 - Projects"

# Folders under a disk root that aren't projects (utility / system / vault itself)
DISK_NON_PROJECTS = {
    "AI Knowledge Base",  # the vault itself
    "_Archive",
    "_archive",
    "node_modules",
    ".git",
}

# --- frontmatter parse (no yaml dep) ----------------------------------------

PATH_RE = re.compile(r"^path:\s*(.+?)\s*$", re.MULTILINE)

def read_path_frontmatter(md_file: Path) -> str | None:
    """Pull `path:` value from frontmatter. Returns string or None."""
    try:
        text = md_file.read_text(encoding="utf-8")
    except Exception:
        return None
    if not text.startswith("---"):
        return None
    end = text.find("---", 3)
    if end < 0:
        return None
    frontmatter = text[3:end]
    m = PATH_RE.search(frontmatter)
    if m:
        return m.group(1).strip().strip('"').strip("'")
    return None

# --- audit ------------------------------------------------------------------

def normalize(p: str | Path) -> str:
    """Normalize for case-insensitive comparison on Windows."""
    return str(p).rstrip("\\/").lower()

def main():
    # 1) Collect all project folders on disk
    disk_projects: dict[str, Path] = {}  # normalized path -> Path
    for root in DISK_ROOTS:
        if not root.is_dir():
            print(f"  warn: disk root not found: {root}", file=sys.stderr)
            continue
        for child in root.iterdir():
            if not child.is_dir():
                continue
            if child.name in DISK_NON_PROJECTS:
                continue
            if child.name.startswith("_") or child.name.startswith("."):
                continue
            disk_projects[normalize(child)] = child

    # 2) Collect all vault project notes and their declared paths
    vault_notes: dict[str, dict] = {}  # normalized declared path -> {note: Path, declared: str}
    orphan_notes: list[Path] = []      # notes with no path: or unresolvable path

    if VAULT_PROJECTS_DIR.is_dir():
        for md in VAULT_PROJECTS_DIR.rglob("*.md"):
            if md.name.startswith("_") or md.name == "README.md":
                continue
            declared = read_path_frontmatter(md)
            if declared is None:
                orphan_notes.append(md)
                continue
            vault_notes[normalize(declared)] = {"note": md, "declared": declared}

    # 3) Diff
    matched: list[tuple[str, Path, Path]] = []           # (status, disk, note)
    missing: list[Path] = []                              # disk folder, no vault note
    orphan_paths: list[tuple[Path, str]] = []             # vault note, declared path doesn't exist

    disk_keys = set(disk_projects.keys())
    vault_keys = set(vault_notes.keys())

    for k in disk_keys & vault_keys:
        matched.append(("ok", disk_projects[k], vault_notes[k]["note"]))

    for k in disk_keys - vault_keys:
        missing.append(disk_projects[k])

    for k in vault_keys - disk_keys:
        v = vault_notes[k]
        orphan_paths.append((v["note"], v["declared"]))

    # 4) Print report
    print(f"\nProject audit — {len(matched)} ok / {len(missing)} missing / "
          f"{len(orphan_paths)} orphan-paths / {len(orphan_notes)} no-path-frontmatter\n")

    if matched:
        print("OK (disk folder ↔ vault note resolved):")
        for _, disk, note in sorted(matched, key=lambda x: str(x[1])):
            rel_note = note.relative_to(VAULT)
            print(f"  ✓  {disk}  ←→  {rel_note}")
        print()

    if missing:
        print("MISSING (disk folder, no vault note):")
        for p in sorted(missing, key=str):
            print(f"  +  {p}")
        print("    → create a vault note at 02 - Projects/<Category>/<Project>.md")
        print()

    if orphan_paths:
        print("ORPHAN-PATH (vault note, declared path doesn't exist on disk):")
        for note, declared in sorted(orphan_paths, key=lambda x: str(x[0])):
            rel_note = note.relative_to(VAULT)
            print(f"  ?  {rel_note}  →  declared {declared}")
        print("    → fix the `path:` frontmatter or create the folder on disk")
        print()

    if orphan_notes:
        print("NO-PATH-FRONTMATTER (vault note missing `path:` field):")
        for note in sorted(orphan_notes, key=str):
            rel_note = note.relative_to(VAULT)
            print(f"  ?  {rel_note}")
        print("    → add `path: <absolute path>` to the frontmatter")
        print()

    if missing or orphan_paths or orphan_notes:
        return 1
    return 0

if __name__ == "__main__":
    sys.exit(main())
