---
name: tdd
description: Test-driven development with red-green-refactor in vertical slices. Use when building features or fixing bugs test-first, mentions of red-green-refactor, integration tests, tracer-bullet TDD, or test-first development.
---

# Test-Driven Development

## Philosophy

**Core principle**: Tests should verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.

**Good tests** are integration-style: they exercise real code paths through public APIs. They describe *what* the system does, not *how*. A good test reads like a specification — "user can checkout with valid cart" tells you exactly what capability exists. These tests survive refactors because they don't care about internal structure.

**Bad tests** are coupled to implementation. They mock internal collaborators, test private methods, or verify through external means (querying a database directly instead of using the interface). The warning sign: your test breaks when you refactor, but behavior hasn't changed.

## Anti-Pattern: Horizontal Slices

**DO NOT write all tests first, then all implementation.** This is "horizontal slicing" — treating RED as "write all tests" and GREEN as "write all code."

This produces **bad tests**:
- Tests written in bulk verify *imagined* behavior, not *actual* behavior
- You end up testing the *shape* of things (data structures, function signatures) rather than user-facing behavior
- Tests become insensitive to real changes — pass when behavior breaks, fail when behavior is fine
- You commit to test structure before understanding the implementation

**Correct approach: vertical slices via tracer bullets.** One test → one implementation → repeat. Each test responds to what you learned from the previous cycle.

```
WRONG (horizontal):
  RED:   test1, test2, test3, test4, test5
  GREEN: impl1, impl2, impl3, impl4, impl5

RIGHT (vertical):
  RED→GREEN: test1→impl1
  RED→GREEN: test2→impl2
  RED→GREEN: test3→impl3
```

## Workflow

### 1. Planning

Before exploring the codebase, get clear on the project's domain vocabulary. Test names and interface vocabulary should match the project's `CONTEXT.md` (or README, if no CONTEXT exists). Inconsistent naming is itself a smell.

Before writing any code:
- Confirm with the user what interface changes are needed
- Confirm which behaviors to test (prioritize — you can't test everything)
- Identify opportunities for **deep modules** (small interface, deep implementation)
- Design interfaces for testability
- List the behaviors to test (not implementation steps)
- Get user approval on the plan

Ask: "What should the public interface look like? Which behaviors are most important to test?"

### 2. Tracer Bullet

Write ONE test that confirms ONE thing about the system:

```
RED:   Write test for first behavior → test fails
GREEN: Write minimal code to pass → test passes
```

This is your tracer bullet — proves the path works end-to-end.

### 3. Incremental Loop

For each remaining behavior:

```
RED:   Write next test → fails
GREEN: Minimal code to pass → passes
```

Rules:
- One test at a time
- Only enough code to pass the current test
- Don't anticipate future tests
- Keep tests focused on observable behavior

### 4. Refactor

After all tests pass, look for refactor candidates:
- Extract duplication
- Deepen modules (move complexity behind simple interfaces)
- Apply SOLID principles where natural
- Consider what new code reveals about existing code
- Run tests after each refactor step

**Never refactor while RED.** Get to GREEN first.

## Checklist Per Cycle

- [ ] Test describes behavior, not implementation
- [ ] Test uses public interface only
- [ ] Test would survive internal refactor
- [ ] Code is minimal for this test
- [ ] No speculative features added

## Mocking guideline (compressed)

Prefer real collaborators wherever the test will still be fast and deterministic. Mock at the **edge of your code** (HTTP, time, filesystem, random) — never at internal seams. If you find yourself mocking an internal module to make a test pass, that's usually the test telling you the module above it is shallow.

## Source
Imported from [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering/tdd) — 05-21-26. Helper files (tests.md, mocking.md, deep-modules.md, interface-design.md, refactoring.md) were not pulled in; their key points are summarised inline above.

## Integrates with
- `03 - Skills & Rules/Rules/engineering-doctrine.md` — research-first, complete task chains
- `03 - Skills & Rules/Skills/diagnose.md` — when a bug needs a regression test, this is the loop
- `03 - Skills & Rules/Skills/improve-codebase-architecture.md` — refactor candidates surfaced during step 4
