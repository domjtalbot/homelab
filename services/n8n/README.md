# n8n

<p align="center">
  <img src="https://raw.githubusercontent.com/n8n-io/n8n/master/assets/n8n-logo.png" alt="n8n Logo" width="120" />
</p>

[![Docker Pulls](https://img.shields.io/docker/pulls/n8nio/n8n?style=flat-square)](https://hub.docker.com/r/n8nio/n8n)
[![GitHub Stars](https://img.shields.io/github/stars/n8n-io/n8n?style=flat-square)](https://github.com/n8n-io/n8n)
[![License](https://img.shields.io/github/license/n8n-io/n8n?style=flat-square)](https://github.com/n8n-io/n8n/blob/master/LICENSE)

---

n8n is a powerful open-source workflow automation tool. Use it to connect APIs, automate tasks, and orchestrate your AI and homelab services.

## Features
- Visual workflow editor
- 350+ integrations (APIs, databases, webhooks, etc.)
- Self-hosted, privacy-first
- Supports triggers, schedules, and event-driven flows

## Usage
- Web UI: [http://localhost:5678](http://localhost:5678)
- Health: [http://localhost:5678/healthz](http://localhost:5678/healthz)

## Environment Variables
See `.env.n8n.example` for configuration options. For a full list, see the [n8n docs](https://docs.n8n.io/hosting/environment-variables/).

## Volumes
- `n8n_data:/home/node/.n8n` — persistent workflows, credentials, and database

## Healthcheck
The container exposes a health endpoint at `/healthz`.

## Documentation
- [n8n GitHub](https://github.com/n8n-io/n8n)
- [Official Docs](https://docs.n8n.io/)

---

> For production, set a strong `N8N_ENCRYPTION_KEY` and configure user management as needed.
