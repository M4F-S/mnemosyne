# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial package structure
- PostgreSQL + pgvector support
- Markdown vault with YAML frontmatter
- MCP server (JSON-RPC)
- Admission control and salience scoring
- Prospective memory (reminders)
- Memory consolidation (archive + relink)

### Changed
- Restructured from single file to proper Python package
- **Separated skill from platform** — skill now lives at `github.com/M4F-S/kimi-mnemosyne-skill`

### Fixed
- Race condition in Embedder
- MCP exception handler NameError
- Unicode filename handling
- Auto-initialization crash

## [0.1.0] - 2026-07-XX

### Added
- Initial release
