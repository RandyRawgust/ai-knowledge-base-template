---
type: software
category: ai-tools
installed: false
install_location: cloud
publisher: OpenAI
license: subscription (ChatGPT)
last_used: 
tags: [ai, agent, dev]
---

# Codex

OpenAI's cloud-based coding agent. Different model family from
[[cowork]] / [[claude-code]] (Claude). You give it a repo + a goal, it works
autonomously and pushes a branch.

## Touches

- Your GitHub repos (or cloned repos in the cloud sandbox)
- Doesn't run locally — it's hosted, like Codespaces with an agent

## When to reach for it vs Claude tools

- **Codex** — long-running autonomous coding tasks where you want to delegate
  and check back later. Strong on test-driven work.
- **[[claude-code]]** — local terminal, full file system access, interactive
- **[[cursor]]** — when you want to be in the loop, editing alongside the AI
- **[[cowork]]** — chat-driven multi-step tasks, MCP integrations, file tools

## Related software

- [[claude-code]] — closest competitor by capability
- [[cursor]] — overlapping but different use case (IDE vs delegated agent)
- [[git]] — Codex commits work via PRs
