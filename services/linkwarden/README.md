# Linkwarden

<p align="center">
  <img src="https://raw.githubusercontent.com/linkwarden/linkwarden/main/assets/logo.png" alt="Linkwarden Logo" width="120" />
</p>

[![Docker Pulls](https://img.shields.io/badge/ghcr.io-linkwarden-blue?style=flat-square)](https://github.com/linkwarden/linkwarden/pkgs/container/linkwarden)
[![GitHub Stars](https://img.shields.io/github/stars/linkwarden/linkwarden?style=flat-square)](https://github.com/linkwarden/linkwarden)
[![License](https://img.shields.io/github/license/linkwarden/linkwarden?style=flat-square)](https://github.com/linkwarden/linkwarden/blob/main/LICENSE.md)

---

Linkwarden is a self-hosted, open-source collaborative bookmark manager to collect, read, annotate, and fully preserve what matters, all in one place.

## Features

- 📸 Auto capture screenshots, PDFs, and single HTML files of each webpage
- 📖 Reader view with highlighting and annotation support
- 📂 Organize links by collections, sub-collections, and tags
- 👥 Collaborate on gathering links with other users
- 🔍 Full-text search with MeiliSearch
- ✨ Optional AI tagging with Ollama or OpenAI
- 🔐 SSO integration support
- 📱 Native iOS and Android mobile apps
- 🧩 Browser extension available

## Usage

- Web UI: `https://linkwarden.${BASE_DOMAIN}`
- Health: `http://localhost:3000/api/v1/health`

## Environment Variables

See `.env.linkwarden.example` for configuration options. For a full list, see the [Linkwarden docs](https://docs.linkwarden.app/self-hosting/installation).

### Required Variables

- `NEXTAUTH_URL` — Full URL to the app (for auth callbacks)
- `NEXTAUTH_SECRET` — Secret for session encryption
- `POSTGRES_PASSWORD` — PostgreSQL database password
- `MEILI_MASTER_KEY` — MeiliSearch master key

## Volumes

- `linkwarden_data:/data/data` — Archived pages, screenshots, PDFs
- `linkwarden_pgdata:/var/lib/postgresql/data` — PostgreSQL database
- `linkwarden_meilidata:/meili_data` — MeiliSearch index

## Architecture

This service includes three containers:

1. **linkwarden** — Main application (Next.js)
2. **linkwarden-postgres** — PostgreSQL 16 database
3. **linkwarden-meilisearch** — MeiliSearch for full-text search

## Healthcheck

The main container exposes a health endpoint at `/api/v1/health`.

## Documentation

- [Linkwarden GitHub](https://github.com/linkwarden/linkwarden)
- [Official Docs](https://docs.linkwarden.app/)
- [Demo](https://demo.linkwarden.app/)

---

> For production, generate strong secrets for `NEXTAUTH_SECRET`, `POSTGRES_PASSWORD`, and `MEILI_MASTER_KEY` using `openssl rand -base64 32`.
