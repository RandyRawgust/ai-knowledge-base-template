---
type: software
category: ai-tools
installed: false
install_location: 
publisher: Nous Research
license: free (MIT)
last_used: 
tags: [ai, agent, self-hosted, mcp]
---

# Hermes Agent

Self-hosted autonomous AI agent platform. Open source, MIT licensed, released
February 2026 by Nous Research. The "AI OS Phase 5" candidate for when we
want a 24/7 always-on agent.

## What makes it different

Unlike [[cowork]] (chat session, fresh each time) or [[claude-code]]
(terminal, on-demand), Hermes runs as a *persistent process*:

- **Memory**: remembers across sessions; autonomous skill creation
- **Multi-platform**: Telegram, Discord, Slack, WhatsApp, Signal, CLI from
  one gateway
- **Built-in dashboard**: tracks every session — model, tokens, tool calls,
  last active. Embeddable in Obsidian via [[Custom Frames]].
- **MCP support**: same protocol [[cowork]] uses, so connectors are reusable
- **BYO model**: any provider (Anthropic, OpenAI, OpenRouter, local)

## Why we don't have it yet

Phases 1-4 of the AI OS work without it. We add it in Phase 5 if and when
a recurring autonomous task makes us reach for it (auto-clip newsletters,
gmail triage, scheduled digests, etc.). Until then it's a placeholder.

The Hermes embed in [[obsidian]] via [[Custom Frames]] is pre-configured at
`http://localhost:8080` — will show "can't connect" until installed.

## Touches (planned)

- Localhost web dashboard (browser, embedded in Dashboard.md)
- Vault read/write via MCP filesystem
- Calendar / Gmail via MCP

## Related software

- [[cowork]] — interactive sibling
- [[claude-code]] — terminal sibling
- n8n — alternative for workflow-style automation (workflows vs autonomous agents)

## Sources

- [hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com/)
