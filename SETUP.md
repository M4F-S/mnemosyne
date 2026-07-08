# Mnemosyne v3.0 — Setup Guide

This guide walks you through installing and running the Mnemosyne AI Memory Platform.

## What Was Installed

| Component | Technology | Status |
|-----------|-----------|--------|
| Database | PostgreSQL 16 + pgvector (Docker) | ✅ Running on port 15432 |
| Embeddings | sentence-transformers (all-MiniLM-L6-v2) | ✅ Using Apple MPS |
| Python API | UnifiedMemorySystem | ✅ 9 notes indexed, 5 links |
| Vault | Obsidian markdown files | ✅ 10 files in `~/Mnemosyne/obsidian-vault/` |
| MCP Server | JSON-RPC 2.0 over stdio | ✅ Ready |

## Quick Start (Already Done)

```bash
# The database is already running
docker ps --filter name=mnemosyne-pg

# Environment variables are set
export MEMORY_DB_DSN="postgresql://mnemosyne:mnemosyne_secret@localhost:15432/mnemosyne"
export MEMORY_VAULT_PATH="/Users/mohamedfathy/Documents/Kimi/Workspaces/Mnemosyne/obsidian-vault"

# Use it in Python
python3 -c "
from mnemosyne import UnifiedMemorySystem
memory = UnifiedMemorySystem()
print(memory.stats())
"
```

## Docker Management

```bash
# View logs
docker logs mnemosyne-pg

# Stop
docker stop mnemosyne-pg

# Start
docker start mnemosyne-pg

# Remove everything (WARNING: deletes all data)
docker rm -f mnemosyne-pg
docker volume rm mnemosyne-pg-data
```

## Connecting Other Agents

### Claude Code

Add to `claude_mcp_settings.json`:

```json
{
  "mcpServers": {
    "mnemosyne": {
      "command": "python3",
      "args": [
        "-c",
        "import sys; sys.path.insert(0, '/path/to/mnemosyne'); from mnemosyne import MemoryMCPServer; MemoryMCPServer().run()"
      ],
      "env": {
        "MEMORY_DB_DSN": "postgresql://mnemosyne:mnemosyne_secret@localhost:15432/mnemosyne",
        "MEMORY_VAULT_PATH": "/Users/mohamedfathy/Documents/Kimi/Workspaces/Mnemosyne/obsidian-vault"
      }
    }
  }
}
```

## File Locations

| File | Path |
|------|------|
| Python module | `mnemosyne/` package |
| Vault (your notes) | `~/Documents/Kimi/Workspaces/Mnemosyne/obsidian-vault/` |

## Verification

Run the test suite:

```bash
cd /path/to/mnemosyne
make test
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `psycopg2 not found` | `pip3 install psycopg2-binary` |
| `sentence-transformers not found` | `pip3 install sentence-transformers` |
| Docker not running | Start Docker Desktop |
| Port 15432 in use | Change `DB_PORT` in setup script |
| Database connection refused | `docker start mnemosyne-pg` |

## Next Steps

1. **Install Obsidian** (optional) to browse your vault visually
2. **Run `memory.consolidate()` weekly** via cron job
3. **Back up your vault** with `git init` in the vault directory
