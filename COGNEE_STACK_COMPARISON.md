# Palimpsest vs Cognee: Stack Comparison & Strategic Analysis

**Date:** July 9, 2026  
**Purpose:** Layer-by-layer comparison of Palimpsest's architecture against Cognee's stack to validate our path, identify gaps, and sharpen differentiation  
**Status:** Post-Separation Analysis (Skill Repo ↔ Platform Repo now split)

---

## Executive Summary

Cognee is a **multi-backend, infrastructure-sprawl-elimination** platform — they support EVERY vector store, graph DB, and relational backend, letting users choose. Palimpsest is an **opinionated-default, Markdown-native Memory OS** — we optimize for a single, coherent stack with deliberate constraints that enable unique features competitors cannot replicate.

**The verdict: We are on the right path, but must be explicit about WHY our opinionated choices are strategic advantages, not gaps.**

---

## Layer 1: Vector Search Engines (Semantic Layer)

### What Cognee Has
| Backend | Role | Notes |
|---------|------|-------|
| **Qdrant** | Production default | Payload filtering, TurboQuant compression, nearest-neighbor → graph mapping |
| **LanceDB** | Local default | Serverless, embedded, columnar, Arrow-native |
| **PGVector** | PostgreSQL-native | Collapses semantic search into standard DB workflows |
| **ChromaDB** | Lightweight local | Developer-friendly, minimal setup |
| **Milvus** | Enterprise distributed | Community-maintained, high-scale |
| **Weaviate** | Enterprise hybrid | Community-maintained, vector+semantic |

### What Palimpsest Has
| Backend | Role | Notes |
|---------|------|-------|
| **PGVector** | Primary | PostgreSQL extension, single-database architecture |
| **SQLite (fallback)** | Zero-config local | For skill-only deployments without PostgreSQL |
| **LanceDB** | Planned Phase 2 | For high-performance local/embedded analytics |

### Gap Analysis
| Dimension | Cognee | Palimpsest | Assessment |
|-----------|--------|-----------|------------|
| Backend count | 6+ | 2 (PGVector + SQLite) | **GAP — but intentional** |
| Production vector | Qdrant (optimized) | PGVector (adequate) | ⚠️ Moderate gap |
| Local vector | LanceDB (default) | SQLite fallback | ⚠️ Functional but not optimized |
| Enterprise scale | Milvus/Weaviate | Not yet | 🔴 Gap to address |
| Compression | TurboQuant (Qdrant) | None | 🔴 Gap |

### Recommendation
**Stay opinionated. Do NOT add Qdrant/Milvus/Weaviate yet.** Rationale:
1. PGVector handles 1M+ embeddings comfortably — sufficient for 12–18 months of growth
2. Adding backends = operational complexity we can't afford pre-product-market-fit
3. **Differentiation:** Our Markdown-native storage means vector search is SECONDARY to graph traversal + temporal reasoning. Cognee is vector-first; we are graph-first.
4. **Future:** Add LanceDB as Phase 2 (Month 4–6) for analytical workloads, NOT as a replacement.

---

## Layer 2: Graph Databases (Ontology & Topology Layer)

### What Cognee Has
| Backend | Role | Status |
|---------|------|--------|
| **Kuzu** | Local default | ⚠️ **ACQUIRED BY APPLE (Oct 2025) — ARCHIVED, DEAD** |
| **Neo4j** | Production | Mature, Cypher, AuraDB managed |
| **Amazon Neptune** | Enterprise cloud | Fully managed, AWS-native |
| **Memgraph** | In-memory | Ultra-fast, Cypher-compatible |
| **ArcadeDB** | Multi-model | Document + graph unified |

### What Palimpsest Has
| Backend | Role | Notes |
|---------|------|-------|
| **PostgreSQL recursive CTEs** | Current (skill) | Lightweight, no extra infra, handles ~10M edges |
| **Neo4j Community** | Planned (platform) | Industry standard, Cypher, Browser UI |
| **Kuzu** | Was planned | ❌ **REMOVED** — Apple acquisition killed it |
| **ArcadeDB** | Future (>100M edges) | Multi-model unification, Phase 3+ |

### Gap Analysis
| Dimension | Cognee | Palimpsest | Assessment |
|-----------|--------|-----------|------------|
| Dedicated graph DB | ✅ Neo4j/Neptune/Memgraph | ⚠️ PostgreSQL CTEs now, Neo4j planned | **TRANSITION GAP** |
| Graph query language | Cypher | SQL CTEs → Cypher (planned) | ⚠️ Migration needed |
| Visualization | Neo4j Browser, built-in | None yet | 🔴 Gap |
| Scale ceiling | Unlimited (Neo4j/Neptune) | ~100M edges (PostgreSQL CTE limit) | ⚠️ Acceptable for 18 months |
| Multi-model | ArcadeDB | Not yet | 🔴 Future gap |

### Critical Insight: Kuzu's Death Validates Our Path
Cognee's default local graph DB (Kuzu) was **acquired by Apple and archived**. This is a MAJOR disruption to Cognee's local-development story. Palimpsest never depended on Kuzu — we use PostgreSQL CTEs for local and Neo4j for production. **This is a competitive advantage:** our local→production path is smoother than Cognee's post-Kuzu local story.

### Recommendation
1. **Immediate:** Document PostgreSQL CTE → Neo4j migration path in `MIGRATION.md`
2. **Month 2–3:** Implement Neo4j Community as primary graph backend for platform
3. **Month 6+:** Evaluate ArcadeDB for multi-model unification (only if edges >100M)
4. **Do NOT add Memgraph/Neptune** — unnecessary complexity for our scale

---

## Layer 3: Relational & Metadata Stores (Provenance Layer)

### What Cognee Has
| Backend | Role |
|---------|------|
| **SQLite** | Local metadata, script executions |
| **PostgreSQL** | Production multi-tenant, structured schemas |
| **Redis** | Real-time session management, caching |

### What Palimpsest Has
| Backend | Role | Notes |
|---------|------|-------|
| **PostgreSQL 16** | Primary relational | Users, teams, RBAC, billing, connectors |
| **SQLite** | Skill-only fallback | Zero-config local deployments |
| **Valkey** | Caching (Redis alternative) | Session tokens, rate limiting, hot cache |
| **MinIO** | Object storage | S3-compatible, file uploads, backups |

### Gap Analysis
| Dimension | Cognee | Palimpsest | Assessment |
|-----------|--------|-----------|------------|
| Primary relational | PostgreSQL ✅ | PostgreSQL ✅ | **PARITY** |
| Local fallback | SQLite ✅ | SQLite ✅ | **PARITY** |
| Caching | Redis ✅ | Valkey ✅ | **PARITY** (Valkey = Redis fork, API-compatible) |
| Object storage | Not built-in | MinIO ✅ | **PALIMPSEST ADVANTAGE** |
| Multi-tenant | ✅ | Planned ✅ | **PARITY (after Phase 1)** |

### Recommendation
**No gaps to close.** Our relational layer is at parity with Cognee. Valkey vs Redis is a wash (API-compatible). MinIO gives us object storage Cognee lacks.

---

## Layer 4: Language & Runtime Engines

### What Cognee Has
| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Primary SDK** | Python 3.11+ | Platform SDK, pipeline orchestrator |
| **Performance** | Rust (PyO3 bindings) | On-device inference, optimized parsing (`cognee-litert-lm`) |
| **API Framework** | FastAPI | REST endpoints, auto-docs |
| **ORM** | SQLAlchemy | Database abstractions |

### What Palimpsest Has
| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Primary SDK** | Python 3.11+ | Skill + platform runtime |
| **Performance** | ❌ No Rust bindings | Pure Python + psycopg2 |
| **API Framework** | ❌ No FastAPI yet | Plain Python classes (skill), FastAPI planned (platform) |
| **ORM** | ❌ No SQLAlchemy | Raw SQL (psycopg2) + Pydantic models |
| **Frontend** | Next.js 14 (planned) | Dashboard, graph viz, billing |
| **Task Queue** | Celery + Redis/Valkey (planned) | Background ingestion, sync |
| **Scheduler** | APScheduler/Temporal (planned) | Periodic tasks, prospective memory triggers |

### Gap Analysis
| Dimension | Cognee | Palimpsest | Assessment |
|-----------|--------|-----------|------------|
| Python maturity | ✅ Mature (80+ contributors) | ✅ Functional but smaller | ⚠️ Catching up |
| Rust performance | ✅ PyO3 bindings | ❌ None | 🔴 **Significant gap** |
| API framework | ✅ FastAPI | ❌ Not yet | 🔴 **Critical gap for platform** |
| ORM | ✅ SQLAlchemy | ❌ Raw SQL | ⚠️ Technical debt risk |
| Frontend | ❌ No first-party UI | ✅ Next.js planned | **PALIMPSEST ADVANTAGE** |
| Task queue | ✅ Celery | ✅ Planned | **PARITY (after Phase 1)** |

### Recommendation
1. **Critical (Month 1):** Implement FastAPI for platform REST API — this is table stakes
2. **High (Month 2–3):** Add SQLAlchemy ORM layer — raw SQL won't scale with team contributions
3. **Medium (Month 4–6):** Evaluate Rust bindings for embedding generation (not urgent — sentence-transformers is fine for now)
4. **Advantage:** Next.js frontend is something Cognee lacks (they only have CLI + localhost:3000 explorer). This is a genuine differentiator.

---

## Layer 5: Extraction, Ingestion & Data Formats

### What Cognee Has
| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Document parsing** | Unstructured, Firecrawl | PDF, HTML, complex docs |
| **Schema enforcement** | JSON, Pydantic, BAML, Instructor | Force LLM output into rigid schemas |
| **LLM Router** | LiteLLM | Unified translation for ANY provider (OpenAI, Anthropic, Gemini, Azure, Ollama) |
| **Format support** | 38+ formats | PDF, CSV, JSON, audio, images, code, SQL, APIs |

### What Palimpsest Has
| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Document parsing** | ❌ No Unstructured/Firecrawl | Manual markdown/YAML only |
| **Schema enforcement** | ✅ Pydantic | Memory models, config validation |
| **LLM Router** | ❌ No LiteLLM | Hardcoded: sentence-transformers + Ollama fallback |
| **Format support** | Markdown, YAML, JSON | Obsidian-compatible vault format |
| **Ingestion** | Manual (`add_memory()`) | No automated connectors yet |

### Gap Analysis
| Dimension | Cognee | Palimpsest | Assessment |
|-----------|--------|-----------|------------|
| Document parsing | ✅ Unstructured/Firecrawl | ❌ None | 🔴 **Major gap** |
| Schema enforcement | ✅ Pydantic/BAML/Instructor | ✅ Pydantic only | ⚠️ Partial parity |
| LLM provider flexibility | ✅ LiteLLM (any provider) | ❌ Hardcoded (Ollama) | 🔴 **Major gap** |
| Format breadth | ✅ 38+ formats | ❌ 3 formats | 🔴 **Major gap** |
| Automated ingestion | ✅ Connectors (Slack, GitHub, etc.) | ❌ None | 🔴 **Major gap** |

### Recommendation
**This is our biggest functional gap.** However, it's also where our differentiation is STRONGEST:

1. **Cognee's approach:** Ingest everything (38 formats), store in DB, build graph from DB
2. **Palimpsest's approach:** Markdown is the source of truth. Files ARE the database. Git-diffable, human-readable, Obsidian-compatible.

**Strategic decision:** Do NOT chase Cognee's 38-format ingestion. Instead:
- **Month 1–2:** Add LiteLLM for provider flexibility (easy win, high impact)
- **Month 2–3:** Build Markdown → Graph pipeline (our core competency)
- **Month 3–4:** Add Firecrawl for web→Markdown conversion (bridges the gap without losing our substrate)
- **Month 4–6:** Selective connectors (Gmail, GitHub, Slack) that OUTPUT Markdown, not raw DB storage

**Key insight:** Cognee stores data in opaque databases. Palimpsest stores data in human-readable Markdown that lives in YOUR file system. This is a philosophical difference, not just technical.

---

## Layer 6: Protocol & Integration Layer

### What Cognee Has
| Component | Status | Notes |
|-----------|--------|-------|
| **MCP Server** | ✅ First-party, standalone | 14 tools, stdio + HTTP |
| **Cursor** | ✅ MCP | Native integration |
| **Claude Code** | ✅ MCP | Native integration |
| **LangGraph** | ✅ Native | `create_react_agent` pattern |
| **CrewAI** | ✅ Native | Winning Weaviate hackathon demo |
| **OpenAI Agents SDK** | ✅ Native | `function_tool` pattern |
| **n8n** | ✅ First-party | No-code memory workflows |
| **HTTP REST API** | ✅ Full | `/add`, `/cognify`, `/memify`, `/search` |

### What Palimpsest Has
| Component | Status | Notes |
|-----------|--------|-------|
| **MCP Server** | ✅ stdio (skill) | 4 tools: remember, recall, improve, forget |
| **HTTP REST API** | ❌ Not yet | Planned for platform (FastAPI) |
| **LangGraph** | ❌ Not yet | Planned |
| **CrewAI** | ❌ Not yet | Planned |
| **n8n** | ❌ Not yet | Planned |
| **Cursor/Claude Code** | ✅ Via MCP | Works via stdio MCP |

### Gap Analysis
| Dimension | Cognee | Palimpsest | Assessment |
|-----------|--------|-----------|------------|
| MCP maturity | ✅ 14 tools, stdio+HTTP | ✅ 4 tools, stdio only | ⚠️ Cognee has more tools |
| HTTP API | ✅ Full REST | ❌ Not yet | 🔴 **Critical gap** |
| Agent framework hooks | ✅ LangGraph, CrewAI, OpenAI | ❌ None | 🔴 **Gap** |
| No-code integration | ✅ n8n first-party | ❌ None | 🔴 **Gap** |
| IDE integration | ✅ Cursor, Claude, VS Code | ✅ Via MCP (works) | **PARITY** |

### Recommendation
1. **Critical (Month 1):** HTTP REST API via FastAPI — this unlocks ALL other integrations
2. **High (Month 2):** Expand MCP to 8–10 tools (add `query_graph`, `list_entities`, `get_stats`)
3. **Medium (Month 3–4):** LangGraph + CrewAI native hooks
4. **Low (Month 4–6):** n8n node (community contribution opportunity)

---

## Differentiation Map: Where Palimpsest Beats Cognee

| Feature | Palimpsest | Cognee | Winner |
|---------|-----------|--------|--------|
| **Markdown as source of truth** | ✅ Native | ❌ DB-only | **Palimpsest** |
| **Prospective memory (scheduled reminders)** | ✅ Unique | ❌ None | **Palimpsest** |
| **Emotional salience scoring** | ✅ Full multi-factor | ⚠️ Partial | **Palimpsest** |
| **Memory versioning (git-style)** | ✅ Planned | ❌ None | **Palimpsest** |
| **Security gates (SMSR-certified)** | ✅ Planned | ⚠️ Basic | **Palimpsest** |
| **Plugin marketplace** | ✅ Planned (Month 3) | ❌ None | **Palimpsest** |
| **35-minute context rotation** | ✅ Unique | ❌ None | **Palimpsest** |
| **NIST-ready compliance** | ✅ JWT + RBAC + audit | ❌ 44% unauthenticated MCP | **Palimpsest** |
| **First-party UI (Next.js)** | ✅ Planned | ❌ CLI only | **Palimpsest** |
| **Obsidian compatibility** | ✅ Native | ❌ None | **Palimpsest** |
| **Multi-backend flexibility** | ❌ Opinionated | ✅ 6+ vector, 5+ graph | **Cognee** |
| **Ingestion breadth (38 formats)** | ❌ 3 formats | ✅ 38+ formats | **Cognee** |
| **Rust performance bindings** | ❌ None | ✅ PyO3 | **Cognee** |
| **Enterprise graph scale** | ❌ ~100M edges | ✅ Unlimited | **Cognee** |
| **Community size** | ❌ New | ✅ 24.8K stars, 80+ contributors | **Cognee** |

**Score: Palimpsest 10 unique features vs Cognee 5 — but Cognee's 5 are "table stakes" for enterprise adoption.**

---

## Strategic Assessment: Are We on the Right Path?

### ✅ YES — With Caveats

**Why we're right:**
1. **Opinionated defaults beat configurability for startups.** Cognee's multi-backend approach is correct for a VC-funded company serving 70+ enterprises. Palimpsest's single-database approach is correct for a bootstrapped product finding product-market-fit.
2. **Markdown-native is a moat.** Cognee cannot easily add "files as source of truth" — their entire architecture assumes DB-centric storage. This is a durable differentiator.
3. **Prospective memory is genuinely unique.** No competitor (Cognee, Mem0, Zep, Letta, Evermind) has scheduled future reminders. This is our #1 demo feature.
4. **Kuzu's death hurt Cognee more than us.** We never depended on it.

### ⚠️ Risks to Address

| Risk | Severity | Mitigation |
|------|----------|------------|
| No HTTP REST API | 🔴 Critical | FastAPI in Month 1 |
| No LiteLLM | 🔴 Critical | Add in Month 1–2 |
| Raw SQL (no ORM) | 🟡 High | SQLAlchemy in Month 2 |
| No ingestion pipeline | 🟡 High | Firecrawl → Markdown in Month 3 |
| No Rust bindings | 🟢 Low | Not urgent — Python is fine for 12 months |
| Community size gap | 🟡 High | Open-source everything, blog aggressively |

### 🎯 The 90-Day Priority Stack

```
Month 1 (Foundation):
  ├── FastAPI REST API
  ├── LiteLLM integration
  ├── Neo4j graph backend
  └── Expanded MCP tools (8+)

Month 2 (Integration):
  ├── SQLAlchemy ORM layer
  ├── LangGraph native hook
  ├── Firecrawl → Markdown pipeline
  └── Prospective memory scheduler (APScheduler)

Month 3 (Differentiation):
  ├── Plugin marketplace (alpha)
  ├── Memory versioning (git-style)
  ├── Next.js dashboard (basic)
  └── Benchmark harness (LongMemEval + LoCoMo)
```

---

## Conclusion

**Palimpsest is NOT trying to be "Cognee but smaller."** We are building a different CATEGORY of product:

- **Cognee = Infrastructure layer** ("use any backend you want")
- **Palimpsest = Memory OS** ("your files ARE your memory, with intelligence layered on top")

Our stack gaps (no Qdrant, no Milvus, no Rust) are **deliberate constraints** that enable our unique features (Markdown-native, prospective memory, emotional salience). The gaps that ARE genuine risks (no FastAPI, no LiteLLM, no ORM) are all closable within 60 days.

**The bet:** Users will choose Palimpsest not because it has more backends, but because it has a fundamentally different relationship with their data — human-readable, file-based, scheduled, and emotionally aware.

---

*Analysis completed July 9, 2026. Next review: August 9, 2026 or upon major Cognee release.*
