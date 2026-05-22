---
type: topic
tags: [agents, multi-agent, hermes, claude-code, agent-sdk]
created: 2026-05-09
sources: 
  - "[Eric Michaud — Build an Obsidian SYSTEM](https://www.youtube.com/watch?v=OZ3ZNhrPbF4)"
  - "[Mark Kashef — I Replaced OpenClaw and Hermes With Claude Code Setup](https://www.youtube.com/watch?v=rVzGu5OYYS0)"
  - "[Hermes Agent docs](https://hermes-agent.nousresearch.com/)"
---

# Multi-Agent Architecture

Design space for the "AI OS Phase 5" agent layer — the platform that hosts
your specialized agents, lets you chat with them individually or in
conference, and surfaces their work in the dashboard.

## Two paths

There are two viable patterns; they have very different trade-offs.

### Path A — Hermes Agent (Nous Research)

A complete pre-built platform. You install Hermes, configure it, and it
gives you everything in one box.

**What you get:**
- Web dashboard (localhost:8080) showing every agent session, model used,
  tokens, last active
- Persistent memory across sessions
- Multi-platform gateway: Telegram, Discord, Slack, WhatsApp, Signal, CLI
  all from one process
- BYO model (Anthropic, OpenAI, OpenRouter, local)
- MCP support — same protocol Cowork uses, connectors are reusable
- Self-hosted, $5 VPS or local machine
- Open source MIT, free

**Cost:** LLM API only. Setup time ~30-60 min.

**Best when:** you want a finished product, not a project. You want voice
and Telegram and Discord all "just working." You don't want to maintain
~500 lines of glue code.

### Path B — Claude Code Agent SDK (Mark Kashef pattern)

Build a thin command center on top of the Claude Code Agent SDK
(or Cowork's underlying SDK — same family). Per Mark Kashef's
April 2026 video, ~200-500 lines of Python is enough for a polished
multi-agent system.

**What you build:**
- N specialized agents (course-builder, lesson-writer, vault-archivist,
  inbox-sweeper, dispatcher) defined as named SDK invocations
- Shared SQLite memory ("hive mind") that every agent reads/writes
- Telegram bot frontend with per-agent chat IDs
- Mission Control dashboard (small Flask/FastAPI app, served via Cloudflare
  tunnel for remote access)
- Voice War Room: Pipecat for voice routing + Gemini Live for low-latency
  speech-to-speech
- Memory pipeline: filter, decay, pin, consolidate every 30 min, inject
  recent context into Obsidian via the vault filesystem
- launchd / Windows Task Scheduler service that auto-starts on boot
- Security layer: chat ID allowlist, exfiltration guard

**Cost:** LLM API only. Setup time ~1-2 weekends to v0, more polish as you go.

**Best when:** you want to deeply understand and tweak each layer. You
already use Claude Code as your foundation. You want voice + dashboard +
Telegram and don't mind being the maintainer.

### Mark Kashef's reasoning for B over A

From his video description: *"I chose this over OpenClaw, Hermes Agent, and
every other framework. The short version is that my foundation is Claude
Code itself, and everything else is a removable layer on top."*

Translation: if Cowork/Claude Code is your daily driver, adding Hermes is
a parallel system that duplicates capability. The Agent SDK pattern keeps
one foundation and adds removable layers.

### When Path A still wins

- You DON'T already use Claude Code / Cowork as a daily driver, OR
- You want the platform "done" rather than "built," OR
- You want multi-LLM provider flexibility baked in (Hermes is BYO model
  cleanly, Agent SDK ties you to Anthropic), OR
- You want a Telegram/Discord/WhatsApp gateway with zero code

## What "agents" would mean for Andy specifically

Five candidate agent roles, mapping to vault [[03 - Skills & Rules/Agents]]:

| Agent | What it does | Already a vault note |
|---|---|---|
| **dispatcher** | Triage layer — figures out which other agent should handle a request | (new) |
| **course-builder** | Scaffolds new courses from a topic | [[course-builder]] |
| **lesson-writer** | Builds / deepens individual lessons (HTML or MD) | [[lesson-writer]] |
| **vault-archivist** | Compiles topic notes from `11 - Sources/`, Karpathy-style | [[vault-archivist]] |
| **inbox-sweeper** | Reviews `Desktop\Inbox\` weekly, suggests filing decisions | (new — to write) |

The "**war room / conference**" pattern: the user voice-talks to the
dispatcher, dispatcher fans the request out to relevant agents, each
agent contributes, dispatcher synthesizes. Same pattern as Cowork's
existing subagent Task tool, just with voice + persistent memory.

## How it integrates with the vault

Either path:
- Agents read CLAUDE.md + project notes for context (already in place)
- Agents write back to the vault — daily note summaries, course progress,
  topic compilations, software map updates
- Dashboard.md surfaces agent activity (last 5 sessions, pending tasks,
  voice transcript snippets)
- Hermes path: dashboard embeds Hermes UI via Custom Frames (already
  pre-configured at localhost:8080)
- Agent SDK path: dashboard embeds your custom Mission Control web app

## Recommendation

**Don't commit yet.** Get more reps with the current system first:
- Use Cowork for a few weeks of actual work
- Notice which agent invocations you do most
- See where voice would actually save time (vs. typing)

Then pick:
- If "voice + multi-platform + zero maintenance" matters most → Hermes
- If "I want to know exactly what's running and tweak it" matters most → Agent SDK

In either case, the Skills & Rules registry in this vault stays — it's
the source of truth for what each agent knows. Both platforms read from
it the same way.

## What we could build TODAY

Without committing to either platform:

1. **Define the dispatcher agent prompt** in `03 - Skills & Rules/Agents/`
2. **Add inbox-sweeper agent prompt** (the missing fifth)
3. **Add a "session log" pattern** to `00 - Chats/` so every important AI
   session leaves a summary that any future agent can read for context
4. **Update CLAUDE.md** to teach the dispatcher pattern: when given a
   complex request, decide which sub-agent to invoke

That's all vault-side, no platform decision needed. When Phase 5 kicks
off, both paths inherit this groundwork.

## Related

- [[hermes]] — software map node
- [[cowork]] · [[claude-code]] · [[codex]] · [[cursor]] — current AI tools
- [[ROADMAP]] — Phase 5 detail
- [[course-builder]] · [[lesson-writer]] · [[vault-archivist]] — existing agent prompts
