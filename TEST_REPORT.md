# Phase 0 Test Report

## Environment
- Python version: Python 3.9.6
- PostgreSQL: Available (Docker container `mnemosyne-pg-test` on port 15432)

## Unit Tests
```
pytest tests/ -v -m "not integration" -p no:postgresql
============================= test session starts ==============================
platform darwin -- Python 3.9.6, pytest-8.4.2, pluggy-1.6.0
collecting ... collected 13 items / 2 deselected / 11 selected

tests/test_embedder.py::TestEmbedder::test_embed_single_text PASSED
tests/test_embedder.py::TestEmbedder::test_embed_empty_list PASSED
tests/test_embedder.py::TestEmbedder::test_embed_multiple_texts PASSED
tests/test_mcp.py::TestMCPServer::test_initialize_request PASSED
tests/test_mcp.py::TestMCPServer::test_tools_list PASSED
tests/test_security.py::TestAdmissionControl::test_valid_note_passes FAILED
tests/test_security.py::TestAdmissionControl::test_injection_detection PASSED
tests/test_security.py::TestAdmissionControl::test_too_long_content_fails PASSED
tests/test_vault.py::TestVaultManager::test_write_and_read_note PASSED
tests/test_vault.py::TestVaultManager::test_safe_filename_unicode PASSED
tests/test_vault.py::TestVaultManager::test_wiki_links_extraction PASSED

============ 1 failed, 10 passed, 2 deselected, 1 warning in 17.65s ===========
```

**Failure:**
- `tests/test_security.py::TestAdmissionControl::test_valid_note_passes`
  - Expected: `(True, "")`
  - Actual:   `(True, "All checks passed")`
  - The `validate()` method returns a success message instead of an empty string.

## Integration Tests
```
export MEMORY_DB_DSN="postgresql://mnemosyne:mnemosyne@localhost:15432/mnemosyne"
pytest tests/ -v -m integration -p no:postgresql
============================= test session starts ==============================
platform darwin -- Python 3.9.6, pytest-8.4.2, pluggy-1.6.0
collecting ... collected 13 items / 11 deselected / 2 selected

tests/test_integration.py::TestIntegration::test_remember_and_recall PASSED
tests/test_integration.py::TestIntegration::test_hybrid_search PASSED

================= 2 passed, 11 deselected, 1 warning in 11.34s =================
```

## Linting

### flake8
Numerous `E501` (line too long), `E302` (blank lines), and `F401` (unused imports) violations across `mnemosyne/` and `tests/`.

### mypy
29 type-checking errors including missing type annotations, missing stub packages (`psycopg2`, `yaml`), and implicit `Optional` defaults.

## Import Checks
| Import | Result |
|--------|--------|
| `from mnemosyne import UnifiedMemorySystem, MemoryMCPServer` | OK |
| `from mnemosyne.core import UnifiedMemorySystem` | OK |
| `from mnemosyne.vault import VaultManager, safe_filename` | OK |
| `from mnemosyne.embedder import Embedder` | OK |
| `from mnemosyne.stores.postgres import PgVectorStore` | OK |
| `from mnemosyne.security import AdmissionControl, SalienceEngine` | OK |
| `from mnemosyne.mcp_server import MemoryMCPServer` | OK |

## Summary
- Unit tests: **FAIL** (1 failed — test/code mismatch in `test_valid_note_passes`)
- Integration tests: **PASS** (2 passed when `MEMORY_DB_DSN` is set)
- Linting: **FAIL** (flake8 style violations; mypy: 29 type errors)
- Imports: **PASS**

## Issues Found

### 1. Test/Code Mismatch in `test_security.py`
**Fix:** Either update the test to expect `"All checks passed"` or change `AdmissionControl.validate()` to return an empty string on success.

### 2. `make test` Fails
**Cause:** `pytest` not on PATH when installed via `pip install --user`. `pytest-postgresql` plugin auto-loads and crashes.

**Workaround:**
```bash
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
pytest tests/ -v -m "not integration" -p no:postgresql
```

### 3. Integration Test Default DSN Uses Port 5432
Consider updating the fallback DSN or documenting the requirement more prominently.

### 4. Linting Violations
- **flake8:** Many style violations
- **mypy:** 29 type-checking errors

### 5. Missing psycopg3 libpq Support
The `pytest-postgresql` dependency pulls in `psycopg` v3, which requires `libpq` on macOS.
