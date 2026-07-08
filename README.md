# 🧠 Palimpsest

> **The Context Engine for AI Agents** — Give your AI agents persistent, observable, compliant memory.
>
> All memories are plain markdown files you own. Search by meaning, traverse relationships, schedule reminders, and protect against poisoned data.

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue)](https://python.org)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14%2B-336791)](https://postgresql.org)
[![License](https://img.shields.io/badge/License-Apache%202.0-green)](LICENSE)

---

## ⚠️ Rebrand Notice

This project was formerly known as **Mnemosyne**. We rebranded to **Palimpsest** in July 2026 to avoid confusion with an unrelated project that adopted the same name.

**Why Palimpsest?** A palimpsest is a manuscript on which later writing has been superimposed on earlier writing — yet traces of the original remain. It's the perfect metaphor for layered, persistent, evolving memory.

---

## What is Palimpsest?

Palimpsest is a **production-grade memory platform for AI agents**. Unlike simple chat history or RAG, it gives agents:

- **Long-term persistent memory** — survives restarts, works across sessions
- **Semantic search** — find ideas by meaning, not just keywords
- **Graph memory** — notes link via `[[wiki-links]]`, traverse relationships
- **Security gates** — injection detection, contradiction flagging, near-duplicate checks
- **Prospective memory** — "remind me in 3 days" — and it actually happens
- **Sleep consolidation** — nightly maintenance: archive stale, merge duplicates
- **MCP server** — Claude Code, Cursor, any MCP client can read/write memory
- **Observability** — audit trails, contamination detection, memory health dashboard
- **Compliance** — GDPR Article 17, EU AI Act ready

## Architecture

```
┌─────────────────────────────────────────────┐
│  Your Question                              │
│  "What did we decide about API rate limit?" │
└──────────────────┬──────────────────────────┘
                   │
┌──────────────────▼──────────────────────────┐
│  Palimpsest Memory Platform               │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐   │
│  │ Semantic │ │ Keyword  │ │  Graph   │   │
│  │ Search   │ │ Search   │ │ Search   │   │
│  │(pgvector)│ │(tsvector)│ │(wikilinks│   │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘   │
│       └────────────┬────────────┘          │
│                    │                       │
│            ┌───────▼────────┐             │
│            │ RRF Merge      │             │
│            └───────┬────────┘             │
│                    │                       │
│  ┌─────────────────▼────────────────────┐ │
│  │ Markdown Vault (source of truth)     │ │
│  │ ~/Palimpsest/vault/*.md             │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

## Quick Start

```bash
# Clone the platform
git clone https://github.com/M4F-S/palimpsest
cd palimpsest

# Install (SQLite works out of the box)
pip install -e ".[dev]"

# Or with PostgreSQL + pgvector for production:
docker run -d --name palimpsest-pg -p 15432:5432 \
  -e POSTGRES_USER=palimpsest \
  -e POSTGRES_PASSWORD=palimpsest_secret \
  -e POSTGRES_DB=palimpsest \
  ankane/pgvector:latest
```

```python
from palimpsest import UnifiedMemorySystem

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

👉 **[github.com/M4F-S/kimi-palimpsest-skill](https://github.com/M4F-S/kimi-palimpsest-skill)**

The skill repo contains only the essential files for Kimi integration: `SKILL.md`, `palimpsest/` package, and tests.

## Documentation

| Document | Purpose |
|----------|---------|
| [PLATFORM_BUILDER_BRIEF.md](PLATFORM_BUILDER_BRIEF.md) | Architecture and design decisions |
| [SETUP.md](SETUP.md) | Installation and configuration guide |
| [PALIMPSEST_V3_REBUILD_PLAN.md](PALIMPSEST_V3_REBUILD_PLAN.md) | V3 roadmap and rebuild strategy |
| [PALIMPSEST_STRATEGIC_DECISIONS.md](PALIMPSEST_STRATEGIC_DECISIONS.md) | Strategic decisions log |
| [RESEARCH_*.md](RESEARCH_*.md) | Research reports and competitive analysis |
| [TEST_REPORT.md](TEST_REPORT.md) | Test coverage and results |
| [CHANGELOG.md](CHANGELOG.md) | Version history |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `MEMORY_DB_DSN` | (none) | PostgreSQL connection string |
| `MEMORY_SQLITE_PATH` | `~/.palimpsest/palimpsest.db` | SQLite database path |
| `MEMORY_VAULT_PATH` | `~/Documents/Kimi/Workspaces/Palimpsest/vault` | Markdown vault directory |
| `EMBEDDING_MODEL` | `all-MiniLM-L6-v2` | Sentence-transformers model |
| `OLLAMA_URL` | `http://localhost:11434` | Ollama server for embeddings |

## License

Apache 2.0
