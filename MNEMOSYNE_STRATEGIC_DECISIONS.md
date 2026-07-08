# MNEMOSYNE: KEEP / KILL / INTRODUCE — Strategic Decision Framework

**Date:** July 2026 | **Comparing:** Original Platform (code) vs. Old Plan (v2.0 brief) vs. New Plan (v3.0 rebuild)

---

## 🗺️ THE THREE LAYERS WE'RE COMPARING

| Layer | What It Is | Status |
|-------|-----------|--------|
| **Original Platform** (Unified Memory) | Working code: FastAPI MCP server, Cognee bridge, 20+ connectors, NEAR NFTs, x402 payments, PostgreSQL + Neo4j + Redis + MinIO | **Functional but fragmented** |
| **Old Plan** (v2.0 Brief) | Architecture document: Three-layer stack (Redis→PostgreSQL→S3), scheduler, admission control, MCP, markdown, 4-month phases | **Strategically sound but incomplete** |
| **New Plan** (v3.0 Rebuild) | Research-synthesized plan: Microkernel + plugins, SMSR security, prospective memory, emotional salience, versioning, multi-agent, 12-month phases | **Comprehensive but 12-month timeline** |

---

## ✅ KEEP FROM THE ORIGINAL PLATFORM (Working Code)

### 1. The Core FastAPI Server Architecture
**Verdict:** ✅ **Keep the server scaffold, refactor into microkernel**

### 2. The Cognee Bridge (`ingestion/cognee_bridge.py`)
**Verdict:** ✅ **Keep as a plugin, not the core**

### 3. The Memory Classification Pipeline (`ingestion/cognee_synthesis.py`)
**Verdict:** ✅ **Keep and expand (7 types → 6 types in v3.0, but richer metadata)**

### 4. The Connector Architecture
**Verdict:** ✅ **Keep the pattern, make it plugin-based**

### 5. The NEAR Consent + x402 Payment Flow
**Verdict:** ⚠️ **Keep as optional Web3 layer, remove as mandatory gate**

### 6. The Demo Data (`demo/cognee_hackathon_demo.py`)
**Verdict:** ✅ **Keep and expand as benchmark dataset**

---

## ❌ KILL FROM THE ORIGINAL PLATFORM (Technical Debt & Wrong Bets)

### 1. Cognee as the ONLY Backend
**Verdict:** ❌ **Kill Cognee-as-core, keep as plugin**

### 2. SQLite as the Primary Database
**Verdict:** ❌ **Kill SQLite, migrate to PostgreSQL**

### 3. Redis (Hot State) — LICENSE RISK
**Verdict:** ❌ **Kill Redis, migrate to Valkey immediately**

### 4. NEAR as Mandatory Authentication
**Verdict:** ❌ **Kill mandatory NEAR, make it optional**

### 5. LanceDB as the Vector Store
**Verdict:** ❌ **Kill LanceDB, use pgvector + pgvectorscale**

### 6. Ladybug as the Graph Engine
**Verdict:** ❌ **Kill Ladybug, use ArcadeDB or Neo4j**

### 7. The "Unified Memory" Branding
**Verdict:** ❌ **Kill "Unified Memory", keep "Mnemosyne"**

---

## ✅ KEEP FROM THE OLD PLAN (v2.0 Brief — Strategic Direction)

### 1. "Memory OS" Positioning
**Verdict:** ✅ **Keep — this is the core brand strategy**

### 2. Three-Layer Stack Concept
**Verdict:** ✅ **Keep the concept, update the technologies**

### 3. The Scheduler (Query Router)
**Verdict:** ✅ **Keep and elevate to kernel**

### 4. Admission Control (Security Gate)
**Verdict:** ✅ **Keep and harden with SMSR**

### 5. Markdown as Universal Format
**Verdict:** ✅ **Keep and expand metadata**

### 6. MCP as Primary Integration
**Verdict:** ✅ **Keep MCP, update to 2026-07-28 spec**

### 7. Emotional Salience Scoring
**Verdict:** ✅ **Keep and make it a plugin**

### 8. Prospective Memory (Reminders)
**Verdict:** ✅ **Keep and expand (the v3.0 plan has the full implementation)**

### 9. Observability Dashboard
**Verdict:** ✅ **Keep and elevate to kernel (not Phase 4)**

### 10. Sleep-Time Consolidation
**Verdict:** ✅ **Keep and expand to full consolidation engine**

---

## ❌ KILL FROM THE OLD PLAN (v2.0 — Outdated or Wrong)

### 1. The 4-Month Timeline
**Verdict:** ❌ **Kill the 4-month plan, use 12-month plan**

### 2. Neo4j as Default Graph Database
**Verdict:** ❌ **Kill Neo4j-as-default, use PostgreSQL CTEs + ArcadeDB**

### 3. SSE as MCP Transport
**Verdict:** ❌ **Kill SSE, use Streamable HTTP**

### 4. GraphQL
**Verdict:** ✅ **Already correct — keep "no GraphQL"**

### 5. The Monolithic Stack Architecture
**Verdict:** ❌ **Kill monolithic, use microkernel + plugins**

---

## 🆕 INTRODUCE FROM NEW RESEARCH (v3.0 Plan)

### 1. Microkernel + Plugin Architecture (HIGHEST PRIORITY)
**Verdict:** 🆕 **INTRODUCE — Foundation of the platform**

### 2. SMSR-Certified Security (HIGHEST PRIORITY)
**Verdict:** 🆕 **INTRODUCE — Non-negotiable for production**

### 3. Temporal Valididity (`valid_at`/`invalid_at`/`superseded_by`)
**Verdict:** 🆕 **INTRODUCE — Schema change before data accumulation**

### 4. Memory Versioning (Git-Style)
**Verdict:** 🆕 **INTRODUCE — Month 4 (Phase 4)**

### 5. Multi-Agent Namespaces + Federation
**Verdict:** 🆕 **INTRODUCE — Month 4 (Phase 4)**

### 6. Drop-In OpenAI-Compatible Proxy
**Verdict:** 🆕 **INTRODUCE — Month 1 (Phase 1)**

### 7. Plugin Marketplace
**Verdict:** 🆕 **INTRODUCE — Alpha Month 3, Beta Month 7**

### 8. pgvectorscale (Timescale Extension)
**Verdict:** 🆕 **INTRODUCE — Mandatory at >10M vectors**

### 9. Valkey (Redis Replacement)
**Verdict:** 🆕 **INTRODUCE — Immediate (Phase 0)**

### 10. R2 (Cloudflare) for Cold Storage
**Verdict:** 🆕 **INTRODUCE — Phase 0**

### 11. EU AI Act Compliance (August 2, 2026)
**Verdict:** 🆕 **INTRODUCE — Phase 5 (Months 5-6)**

---

## 📋 ANSWERS TO SPECIFIC QUESTIONS

### Q1: Do we still build the extension?
**Answer:** YES, but reprioritize. VS Code extension first (Month 6), then Obsidian sync, browser extension, mobile app.

### Q2: Do we still create connectors to all websites?
**Answer:** YES, but as **plugins, not core code**. 5 official connectors (Gmail, GitHub, Slack, Notion, Spotify) as plugins. Community builds the rest via marketplace.

### Q3: Do we still offer cloud storage?
**Answer:** YES, but with a **self-hosted option**. 3 deployment modes: Cloud (managed), Self-Hosted (Docker Compose, FREE), Hybrid (local + cloud sync).

### Q4: Do we need a free or trial version for self storage?
**Answer:** YES — **free self-hosted is the adoption engine**. Self-hosted = completely free. Cloud = 14-day trial then $19/month (Pro) or $49/user/month (Team).

### Q5: Do we make it open source?
**Answer:** YES — **Open Core model**. Core kernel + plugins = Apache 2.0 (open source). Enterprise features = proprietary. Cloud hosting = SaaS.

---

## 📊 FINAL STRATEGIC RECOMMENDATION

### The Platform You Should Build

**Mnemosyne** is an **open-core Memory OS** with a microkernel architecture, built on PostgreSQL + pgvector + pgvectorscale, secured by SMSR-certified admission control, exposed through stateless MCP (stdio + Streamable HTTP) and OpenAI-compatible proxy, with emotional salience scoring, prospective memory scheduling, and a plugin marketplace for connectors and extensions.

### The Three Deployment Modes

| Mode | Stack | User | Price | Open Source |
|------|-------|------|-------|-------------|
| **Self-Hosted** | Docker Compose on your VPS | Privacy-conscious developers | **FREE** | ✅ Apache 2.0 |
| **Cloud (Pro)** | Managed PostgreSQL + Valkey + S3 + R2 | Individual developers | **$19/month** | ❌ SaaS |
| **Cloud (Team)** | Managed + ArcadeDB + SSO | Teams, startups | **$49/user/month** | ❌ SaaS |
| **Enterprise** | On-premise + TEE + SOC 2 | Large enterprises | **Custom** | ⚠️ Source available |

### The One-Sentence Summary

> **Build Mnemosyne as an open-core Memory OS: a microkernel with plugins, open source (Apache 2.0) for the core and self-hosted use, proprietary SaaS for cloud features, with a drop-in proxy for instant adoption, a VS Code extension for developer workflow, and a plugin marketplace for connectors. Keep the original platform's server architecture, classification pipeline, and connector pattern. Kill Cognee-as-core, SQLite, Redis, mandatory NEAR, and monolithic architecture. Introduce microkernel + plugins, SMSR security, temporal validity, memory versioning, multi-agent namespaces, and EU AI Act compliance.**

---

*Document: Mnemosyne Strategic Decision Framework — Keep / Kill / Introduce*
*Synthesized from: Original platform code, v2.0 brief, v3.0 rebuild plan, 6 research streams, 31,924+ lines*
*Date: July 2026*
*Status: Ready for implementation decisions*
