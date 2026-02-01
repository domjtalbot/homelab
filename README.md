<div align="center">

# 🏠 Homelab

**My collection of services running on my homelab**

[![Docker](https://img.shields.io/badge/Platform-Docker-blue?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)


</div>

---

## Overview

This is my homelab — a collection of self-hosted services running on Docker Compose. I've designed it to be simple and extensible, with each service self-contained in its own directory so you can easily add, remove, or customize anything.

## Prerequisites

This project uses [Task](https://taskfile.dev) for task automation. You'll need to install it globally:

**macOS:**
```bash
brew install go-task
```

**Linux:**  
See the [official installation guide](https://taskfile.dev/installation/)

### What makes it work

Adding new services should be quick and easy right? the setup is design to get up and running quickly, by simply adding a new docker compose file. new services automaticslly get assigned valid HTTPS with Lets encrypt via Traefik, automatically added to the homepage dashboard. the Taskfile allows easy interaction.

The setup is plug-and-play — you can add new services without touching the Taskfile. Traefik handles reverse proxy and automatic HTTPS with Let's Encrypt. There's a Homepage dashboard that auto-discovers all your services, and everything runs natively in Docker containers.



## Services

Here's what I'm currently running. Each service links to its own README with setup details.

| Service | Description | Category |
|---------|-------------|----------|
| [Homepage](services/homepage/) | Modern dashboard with service auto-discovery | Infrastructure |
| [Traefik](services/traefik/) | Reverse proxy with automatic SSL certificates | Infrastructure |
| [n8n](services/n8n/) | Workflow automation platform | Automation |
| [Open WebUI](services/open-webui/) | Chat interface for Ollama and LLMs | AI |
| [Linkwarden](services/linkwarden/) | Collaborative bookmark manager | Tools |
| [MeTube](services/metube/) | YouTube video downloader | Media |
| [Tdarr](services/tdarr/) | media transcoding | Media |
| [Web-Check](services/web-check/) | Website analysis toolkit | Tools |
| [Tugtainer](services/tugtainer/) | Docker container update automation | Infrastructure |
| [Wyoming Faster Whisper](services/wyoming-faster-whisper/) | Speech-to-text server | AI |
| [Wyoming Piper](services/wyoming-piper/) | Text-to-speech server | AI |

## Commands

I use Task to make managing my services easier: from wrapping docker commands, to automatic env file injection and env file validation.


| Command | Description | Example |
|---------|-------------|---------|
| `task check-env` | Validate environment files | `task check-env` |
| `task clean` | Remove all homelab resources | `task clean` |
| `task down` | Stop all or a specific service | `task down SERVICE=homepage` |
| `task init` | Initialize environment files | `task init` |
| `task logs` | View logs (follows) | `task logs SERVICE=traefik` |
| `task prune` | Remove unused containers/images | `task prune` |
| `task ps` | Show container status | `task ps SERVICE=homepage` |
| `task restart` | Restart a service | `task restart SERVICE=n8n` |
| `task status` | Show all homelab containers | `task status` |
| `task up` | Start all or a specific service | `task up SERVICE=homepage` |

> All commands are designed to work with either all services at once or a signle service. If you don't specify a `SERVICE`, the command will apply to all services.
