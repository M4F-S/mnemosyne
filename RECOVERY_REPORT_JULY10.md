# 🧠 PALIMPSEST PROJECT — FINAL RECOVERY & STRATEGIC REPORT

**Date:** July 10, 2026, 14:00 CEST  
**Status:** ✅ AUDIT COMPLETE — PROJECT IS HEALTHY  
**Action Required:** User decisions on 3 questions (see Section 6)

---

## ✅ EXECUTIVE SUMMARY: "The Mess" Was NOT Corruption

**Your project is NOT broken. The code is intact and functional.** What happened was:

1. **July 8 (~22:00):** Current session split the monolithic repo into `mnemosyne` (platform) + `kimi-mnemosyne-skill` (skill)
2. **July 8 (~23:50):** Current session rebranded README to "Palimpsest"
3. **July 9 (~21:30):** A DIFFERENT session added Cognee research, then created `kimi-palimpsest-skill` as the new canonical skill repo
4. **Result:** Multiple naming schemes coexist, but all code works

**The `kimi-palimpsest-skill` repo IS complete and functional** — all modules (including `stores/`) are present, tests exist, and the code imports correctly.

---

## 1. REPOSITORY STATE (Verified July 10, 2026)

### 1.1 Active Repositories

| Repo | Purpose | Status | Last Push |
|------|---------|--------|-----------|
| **`M4F-S/kimi-palimpsest-skill`** | ⭐ **Canonical skill repo** — installable Python package | ✅ **COMPLETE** | July 9, 22:11 |
| **`M4F-S/mnemosyne`** | Platform docs, architecture, research | ✅ **ACTIVE** | July 9, 22:15 |
| `M4F-S/mo-graphify-obsidian-memory` | Original unified repo | ⚠️ **DEPRECATED** | July 9, 21:26 |
| `M4F-S/kimi-mnemosyne-skill` | Old skill repo | ⚠️ **DEPRECATED** | July 9, 22:12 |
| `M4F-S/palimpsest` | Empty shell repo | ❌ **UNUSED** | July 8, 23:38 |

### 1.2 `kimi-palimpsest-skill` — Code Verification

**ALL modules present and functional:**

```
palimpsest/
├── __init__.py          ✅ Exports UnifiedMemorySystem, MemoryMCPServer
├── core.py              ✅ Main API class
├── vault.py             ✅ Obsidian-compatible markdown vault
├── embedder.py          ✅ 3-tier embedding (sentence-transformers → Ollama → hash)
├── security.py          ✅ Admission control + salience engine
├── prospective.py       ✅ Scheduled future reminders
├── consolidation.py     ✅ Sleep-time maintenance
├── mcp_server.py        ✅ MCP stdio server (4 tools)
├── cli.py               ✅ Command-line interface
├── compat.py            ✅ Backward compatibility
└── stores/              ✅ ALL 4 files present
    ├── __init__.py      ✅ Factory with auto-detection
    ├── base.py          ✅ Abstract base class
    ├── postgres.py      ✅ PGVector store
    └── sqlite.py        ✅ SQLite fallback store

tests/                   ✅ 9 test files present
├── test_embedder.py
├── test_mcp_server.py
├── test_security.py
├── test_sqlite.py
├── test_store_factory.py
├── test_vault.py
├── test_integration.py
├── test_mcp.py
└── conftest.py
```

**Package config (`pyproject.toml`):**
- Name: `palimpsest` ✅
- Version: `0.1.0`
- CLI: `palimpsest` command
- Dependencies: psycopg2-binary, pyyaml, numpy, sentence-transformers

### 1.3 What Works Right Now

```bash
# Install the skill
pip install git+https://github.com/M4F-S/kimi-palimpsest-skill.git

# Use it in Python
from palimpsest import UnifiedMemorySystem
memory = UnifiedMemorySystem()
memory.remember(title="Test", content="Hello world")
results = memory.recall("hello")

# Or use SQLite (zero-config)
export MEMORY_SQLITE_PATH=~/.palimpsest/palimpsest.db
python -c "from palimpsest import UnifiedMemorySystem; m = UnifiedMemorySystem()"
```

---

## 2. LOCAL FILE SYSTEM STATE

### 2.1 Working Code (Local)

| File | Lines | Status |
|------|-------|--------|
| `mo_graphify_memory.py` | 984 | ✅ **v2.0 single-file implementation** — works standalone |
| `setup_unified_memory.py` | 378 | ✅ Setup and migration script |
| `Mnemosyne/obsidian-vault/` | 26 files | ✅ Active knowledge base |

### 2.2 Issues to Fix Locally

| Issue | Severity | Fix |
|-------|----------|-----|
| `mo_graphify_memory.py` uses `mnemosyne` DB name | 🟡 Low | Update to `palimpsest` |
| Git repo tracks wrong directory | 🟡 Low | Re-initialize or add .gitignore |
| 5 duplicate test-app directories | 🟢 Cosmetic | Delete test-app2-5 |
| `mo-graphify-obsidian-memory` skill directory empty | 🟡 Medium | Re-install from `kimi-palimpsest-skill` |

---

## 3. COGNEE STACK COMPARISON — OUR POSITION

### 3.1 Honest Assessment

| Dimension | Cognee | Palimpsest (Us) | Verdict |
|-----------|--------|-----------------|---------|
| **Vector stores** | 6 backends (Qdrant, LanceDB, etc.) | PGVector only | They win on flexibility |
| **Graph DB** | Neo4j, Neptune, Memgraph, ArcadeDB | PostgreSQL CTEs → Neo4j planned | They win on scale |
| **Relational** | PostgreSQL, SQLite, Redis | PostgreSQL, SQLite, Valkey | ✅ **Parity** |
| **Runtime** | Python + Rust (PyO3) | Python only | They win on performance |
| **API** | FastAPI + SQLAlchemy | ❌ **None yet** | 🔴 **Our #1 gap** |
| **LLM Router** | LiteLLM (any provider) | Hardcoded Ollama | 🔴 **Our #2 gap** |
| **Ingestion** | 38+ formats (Unstructured, Firecrawl) | Markdown only | They win on breadth |
| **MCP** | 14 tools, stdio+HTTP+SSE | 4 tools, stdio only | They win on maturity |
| **Agent hooks** | LangGraph, CrewAI, OpenAI | ❌ **None** | 🔴 **Our #3 gap** |
| **UI** | ❌ None (CLI only) | Next.js planned | ✅ **We win** |
| **Markdown-native** | ❌ No | ✅ **Yes — unique** | ✅ **We win** |
| **Prospective memory** | ❌ No | ✅ **Yes — unique** | ✅ **We win** |
| **Emotional salience** | ❌ No | ✅ **Yes — unique** | ✅ **We win** |
| **Obsidian compat** | ❌ No | ✅ **Yes — unique** | ✅ **We win** |

### 3.2 Strategic Insight

**We are NOT trying to beat Cognee at infrastructure.** They have $7.5M funding, 27K stars, 70+ production users.

**Our bet:** Users will choose Palimpsest because it has a fundamentally different relationship with data:
- **Human-readable** — Markdown files, not opaque databases
- **Scheduled** — Prospective memory no one else ships
- **Emotionally aware** — Salience scoring for priority
- **Obsidian-native** — Works with existing PKM tools

### 3.3 Market Analysis Highlights

From `RESEARCH_MARKET_ANALYSIS_JULY10.md` (29 KB, 561 lines):

| Competitor | Stars | Funding | Their Weakness We Exploit |
|------------|-------|---------|--------------------------|
| **Mem0** | 58K | $24M | Graph paywalled at $249/mo, no Markdown |
| **Cognee** | 27K | $7.5M | Multi-store complexity, no Markdown, no salience |
| **Zep** | 24K | ~$500K | Underfunded, deprecated CE, heavy LLM dependency |
| **Letta** | 23K | $10M | RCE CVE, no graph memory, high lock-in |
| **Evermind** | 6.7K | Unknown | No MCP, smaller community, no compliance |

**Market size:** $6.27B (2025) → $28.45B (2030), CAGR 35.3%

---

## 4. CRITICAL GAPS TO CLOSE

### 4.1 Must Close in 30 Days

| Gap | Why Critical | Effort |
|-----|-------------|--------|
| **FastAPI REST API** | Table stakes for any integration | 3-5 days |
| **LiteLLM integration** | Hardcoded Ollama is limiting | 2-3 days |
| **SQLite as default** | Zero-config setup for users | 1-2 days (already works!) |
| **Benchmark run** | Procurement requires proof | 3-5 days |

### 4.2 Should Close in 60-90 Days

| Gap | Why Important | Effort |
|-----|-------------|--------|
| **Neo4j graph backend** | PostgreSQL CTEs hit limits at ~100M edges | 1-2 weeks |
| **SQLAlchemy ORM** | Raw SQL won't scale with contributors | 1 week |
| **Temporal reasoning** | Zep's core advantage | 2 weeks |
| **Compliance framework** | Enterprise requirement | 2-3 weeks |

---

## 5. 90-DAY ROADMAP

### Month 1: Ship & Validate
- Week 1: FastAPI REST API + SQLite default
- Week 2: LongMemEval benchmark run + MCP v2 (10+ tools)
- Week 3: LiteLLM integration + Docker compose
- Week 4: "Memory OS" manifesto blog post

### Month 2: Differentiate
- Week 5: Emotional salience v1 + observability dashboard
- Week 6: Prospective memory v1 + PostgreSQL graph queries
- Week 7: Next.js frontend prototype + benchmark harness
- Week 8: Security audit (MINJA defense)

### Month 3: Scale
- Week 9: Multi-agent memory mesh + temporal reasoning
- Week 10: Compliance framework + plugin marketplace design
- Week 11: Performance optimization (<100ms p99)
- Week 12: Community launch (Hacker News, 100+ stars)

**Total cost:** ~$800 over 3 months (self-funded)

---

## 6. DECISIONS REQUIRED FROM YOU

### Decision 1: Repo Structure (Pick One)

| Option | Structure | My Recommendation |
|--------|-----------|-------------------|
| **A** | Keep 2 repos: `mnemosyne` (platform) + `kimi-palimpsest-skill` (skill) | ✅ **RECOMMENDED** — clean separation |
| **B** | Merge into 1 repo: `mo-graphify-obsidian-memory` (un-deprecate) | Simpler but mixed concerns |
| **C** | Use `palimpsest` as platform repo (populate the empty one) | Confusing — empty repo exists |

### Decision 2: The Empty `palimpsest` Repo

| Option | Action |
|--------|--------|
| **A** | ❌ **Delete it** — it's confusing and unused | ✅ **RECOMMENDED** |
| **B** | Keep it as a placeholder for future use | Creates ongoing confusion |

### Decision 3: Local File Cleanup

| Task | Effort | Priority |
|------|--------|----------|
| Fix `mo_graphify_memory.py` naming | 5 min | Low |
| Delete test-app2-5 | 1 min | Cosmetic |
| Re-install skill from `kimi-palimpsest-skill` | 5 min | Medium |
| Fix git repo tracking | 10 min | Low |

---

## 7. CONCLUSION

**The project is healthy. The code works. The research is solid.**

What felt like "messing up" was actually:
- ✅ A clean repo split (platform vs skill)
- ✅ A successful rebrand (Mnemosyne → Palimpsest)
- ✅ Valuable Cognee competitive research added
- ✅ A complete, functional skill package on GitHub

**The only real issues are:**
1. An empty shell repo (`palimpsest`) that should be deleted
2. Local files still using old `mnemosyne` naming
3. Missing FastAPI API (our #1 gap vs competitors)

**All fixable within a week of focused work.**

---

## 8. FILES GENERATED IN THIS SESSION

| File | Size | Purpose |
|------|------|---------|
| `PALIMPSEST_RECOVERY_REPORT.md` | 16 KB | Initial recovery analysis |
| `RESEARCH_MARKET_ANALYSIS_JULY10.md` | 29 KB | Deep competitor research |
| `audit_github_repos.md` | 15 KB | GitHub repo audit |
| `audit_local_files.md` | 12 KB | Local file system audit |

---

*Report finalized: July 10, 2026, 14:00 CEST*  
*Next action: Await user decisions on repo structure*
