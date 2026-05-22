---
type: skill
category: document
source: cowork-builtin
path: C:\Users\<YOUR-USERNAME>\AppData\Roaming\Claude\local-agent-mode-sessions\skills-plugin\...\skills\docx
tags: [skill, document]
source: anthropic
external: true
---

# docx — Word Document Handler

Cowork skill for creating, reading, editing, manipulating `.docx` files.
Triggered by mentions of "Word doc", ".docx", "letter", "memo", "report",
"resume", etc.

## Capabilities

- Create polished Word documents (TOCs, headings, page numbers, letterheads)
- Extract / reorganize content from existing .docx
- Insert / replace images
- Find and replace
- Track changes / comments
- Convert content INTO a polished Word document

## When to invoke

Whenever the user wants a `.docx` deliverable — resume, formal letter,
report, structured document.

## When NOT to invoke

- PDFs (use [[pdf]])
- Spreadsheets (use [[xlsx]])
- Plain markdown notes (just write directly)

## Used by

- [[Career]] (resume work)
- [[KSP RPG]] (rulebook drafts, mission reference docs)
- Any project producing professional Word deliverables
