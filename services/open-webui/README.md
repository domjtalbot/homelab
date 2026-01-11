# Open WebUI

<p align="center">
  <img src="https://raw.githubusercontent.com/open-webui/open-webui/main/public/logo.svg" alt="Open WebUI Logo" width="120" />
</p>

[![Docker Pulls](https://img.shields.io/docker/pulls/open-webui/open-webui?style=flat-square)](https://hub.docker.com/r/open-webui/open-webui)
[![GitHub Stars](https://img.shields.io/github/stars/open-webui/open-webui?style=flat-square)](https://github.com/open-webui/open-webui)
[![License](https://img.shields.io/github/license/open-webui/open-webui?style=flat-square)](https://github.com/open-webui/open-webui/blob/main/LICENSE)

---

Open WebUI provides a modern, feature-rich chat interface for Ollama and other OpenAI-compatible LLMs. This service connects to an Ollama instance running on the host and exposes a web UI at [http://localhost:3000](http://localhost:3000).

## Features
- Multi-model chat with history
- RAG (document upload)
- Image generation
- Voice support (STT/TTS)
- Role-based access control
- Healthcheck endpoint

## Usage
- Web UI: [http://localhost:3000](http://localhost:3000)
- Health: [http://localhost:3000/health](http://localhost:3000/health)

## Environment Variables
See `.env.open-webui.example` for available options.

## Volumes
- `open-webui_data:/app/backend/data` — persistent app data

## Healthcheck
The container exposes a health endpoint at `/health`.

## Documentation
- [Open WebUI GitHub](https://github.com/open-webui/open-webui)
- [Official Docs](https://docs.openwebui.com)

---

> This service does not provide HTTPS. Use a reverse proxy or third-party service for TLS termination if required.
