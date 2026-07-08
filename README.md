# 🧠 Mnemosyne

> **The AI Memory Platform** — Give your AI agents persistent, secure, graph-based memory.
>
> All memories are plain markdown files you own. Search by meaning, traverse relationships, schedule reminders, and protect against poisoned data.

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue)](https://python.org)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14%2B-336791)](https://postgresql.org)
[![License](https://img.shields.io/badge/License-Apache%202.0-green)](LICENSE)

---

## What is Mnemosyne?

Mnemosyne is a **production-grade memory platform for AI agents**. Unlike simple chat history or RAG, it gives agents:

- **Long-term persistent memory** — survives restarts, works across sessions
- **Semantic search** — find ideas by meaning, not just keywords
- **Graph memory** — notes link via `[[wiki-links]]`, traverse relationships
- **Security gates** — injection detection, contradiction flagging, near-duplicate checks
- **Prospective memory** — "remind me in 3 days" — and it actually happens
- **Sleep consolidation** — nightly maintenance: archive stale, merge duplicates
- **MCP server** — Claude Code, Cursor, any MCP client can read/write memory

## Architecture

```
┌─────────────────────────────────────────────┐
│  Your Question                              │
│  "What did we decide about API rate limit?" │
└──────────────────┬──────────────────────────┘
                   │
┌──────────────────▼──────────────────────────┐
│  Mnemosyne Memory Platform                  │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐     │
│  │ Semantic │ │ Keyword  │ │  Graph   │     │
│  │ Search   │ │ Search   │ │ Search   │     │
│  │(pgvector)│ │(tsvector)│ │(wikilinks│     │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘     │
│       └────────────┬────────────┘             │
│                    │                          │
│            ┌───────▼────────┐               │
│            │ RRF Merge      │               │
│            └───────┬────────┘               │
│                    │                          │
│  ┌─────────────────▼──────────────────────┐  │
│  │ Markdown Vault (source of truth)     │  │
│  │ ~/Mnemosyne/obsidian-vault/*.md      │  │
│  └──────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

## Quick Start

```bash
# Clone the platform
git clone https://github.com/M4F-S/mnemosyne
cd mnemosyne

# Install (SQLite works out of the box)
pip install -e ".[dev]"

# Or with PostgreSQL + pgvector for production:
docker run -d --name mnemosyne-pg -p 15432:5432 \
  -e POSTGRES_USER=mnemosyne \
  -e POSTGRES_PASSWORD=mnemosyne_secret \
  -e POSTGRES_DB=mnemosyne \
  ankane/pgvector:latest
```

```python
from mnemosyne import UnifiedMemorySystem

memory = UnifiedMemorySystem()

# Save a memory
memory.remember(
    title="API Rate Limit Decision",
    content="100 req/min with burst to 200. Alert if p95 > 200ms.",
    tags=["api", "decision"],
    salience=0.9
)

# Search by meaning
results = memory.recall("rate limiting policy", mode="hybrid", top_k=5)

# Schedule a reminder
memory.remind_me("Review API metrics", "2026-07-07T09:00:00", recurring="weekly")

# Run nightly maintenance
memory.consolidate()
```

## Kimi Skill

For the **Kimi AI skill** (minimal installable version):

👉 **[github.com/M4F-S/kimi-mnemosyne-skill](https://github.com/M4F-S/kimi-mnemosyne-skill)**

The skill repo contains only the essential files for Kimi integration: `SKILL.md`, `mnemosyne/` package, and tests.

## Hackathon Prototype

The original **AI Agents Berlin Hackathon 2026** project with NEAR blockchain consent NFTs, Cloudflare Workers, 20+ platform connectors, and x402 USDC payments:

👉 **[github.com/M4F-S/unified-memory](https://github.com/M4F-S/unified-memory)**

## Documentation

| Document | Purpose |
|----------|---------|
| [PLATFORM_BUILDER_BRIEF.md](PLATFORM_BUILDER_BRIEF.md) | Architecture and design decisions |
| [SETUP.md](SETUP.md) | Installation and configuration guide |
| [MNEMOSYNE_V3_REBUILD_PLAN.md](MNEMOSYNE_V3_REBUILD_PLAN.md) | V3 roadmap and rebuild strategy |
| [MNEMOSYNE_STRATEGIC_DECISIONS.md](MNEMOSYNE_STRATEGIC_DECISIONS.md) | Strategic decisions log |
| [RESEARCH_*.md](RESEARCH_*.md) | Research reports and competitive analysis |
| [TEST_REPORT.md](TEST_REPORT.md) | Test coverage and results |
| [CHANGELOG.md](CHANGELOG.md) | Version history |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `MEMORY_DB_DSN` | (none) | PostgreSQL connection string |
| `MEMORY_SQLITE_PATH` | `~/.mnemosyne/mnemosyne.db` | SQLite database path |
| `MEMORY_VAULT_PATH` | `~/Documents/Kimi/Workspaces/Mnemosyne/obsidian-vault` | Markdown vault directory |
| `EMBEDDING_MODEL` | `all-MiniLM-L6-v2` | Sentence-transformers model |
| `OLLAMA_URL` | `http://localhost:11434` | Ollama server for embeddings |

## License

Apache 2.0
