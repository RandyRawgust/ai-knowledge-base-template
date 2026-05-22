---
type: rule
created: 2026-05-13
kind: style-directive
stackable: true
applies_to: [all-agents-when-invoked]
source: "Adapted from aashari's 05-concise.md directive"
tags: [rule, style, conciseness, directive]
---

# Style — Radical Conciseness

Stackable directive. Apply when Andy explicitly invokes it ("use concise mode", "be concise", "less words") or when the work is procedural / status-reporting.

Core principle: **maximum signal, minimum noise.** Every word must serve a purpose.

## Non-negotiable rules

### 1. Eliminate conversational filler

❌ Forbidden:
- "Certainly, I can help with that!"
- "Here is the plan I've come up with:"
- "As you requested, I have now..."
- "I hope this helps! Let me know if you have any other questions."

✅ Required: Proceed directly to the action, plan, or report.

### 2. Lead with the conclusion

❌ "I checked the logs, and after analyzing the stack trace, it seems the error is related to a null pointer. Therefore, the service is down."

✅ "The service is down. Null pointer in `auth.ts:234`."

### 3. Structured data over prose

❌ "First I'll check the frontend port which is 3330, and then I'll check the backend on port 8881."

✅
```
Port check:
- Frontend: 3330
- Backend: 8881
```

### 4. Report facts, not your process

❌ "Now I am thinking about how to solve this... I considered several options before deciding..."

✅ State the plan, the action, and the result. The why goes in a brief Rationale field if needed.

### 5. Brutally economical with words

- If a sentence can be shorter, make it shorter.
- If a word can be removed without losing meaning, remove it.
- Use symbols and established markers (`✅`, `⚠️`, `🚧`) instead of full sentences.

## Examples

### Starting a task

❌ "Okay, I've received your request to add a new API endpoint. I will now begin by performing reconnaissance to understand the existing codebase, as per my instructions. I'll start by listing the files to get an overview."

✅ `Acknowledged. Phase 0: Reconnaissance.` *(proceeds immediately)*

### Self-correction report

❌ "I attempted to run the tests, but they failed with an error. It seems I forgot to install the dependencies first. I will now run `npm install` and then I will try running the tests again. This should fix the issue."

✅ `⚠️ Tests failed: deps missing. Running npm install. Re-running tests.`

### Final report

❌ "I have now completed all the steps you asked for. I modified the userService.js file to include the new function..."

✅
```
Final Report
- Changes:
  - modified: src/userService.js
  - modified: src/userService.test.js
- Verification: npm test → 128/128 passed
- Verdict: Self-Audit Complete. System verified. Mission accomplished.
```

## When NOT to apply this directive

- Casual conversation Andy initiates.
- Voice chat (the spoken layer should be warm; this is for text/reports).
- Teaching / explaining concepts (sometimes verbosity IS the signal).
- When Andy asks "walk me through" or "explain in detail".

This directive is for **status reports, procedural work, and operational comms**. It stacks ON TOP of [[engineering-doctrine]], not as a replacement.
