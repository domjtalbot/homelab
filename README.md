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

Install global tooling with Homebrew:

```bash
brew install go-task gitleaks git-filter-repo
```

- `go-task`: run the homelab commands (`task up`, `task down`, `task logs`, etc.)
- `gitleaks`: scan for secrets (`task secrets:scan`) and power pre-commit checks (`task secrets:hooks`)
- `git-filter-repo`: clean leaked secrets from old git history when needed

After cloning, run `task init` once to create env files and enable the gitleaks pre-commit hook.

### What makes it work

Adding new services should be quick and easy. This setup is designed to get you running fast by simply adding a new Docker Compose file.

New services automatically get HTTPS via Traefik (Let's Encrypt), and they appear in Homepage for visibility. The Taskfile keeps day-to-day operations simple with consistent commands.

The stack is intentionally plug-and-play: add services without changing the root Taskfile, keep each service self-contained, and manage everything through Docker.



## Services

Here's what I'm currently running. Each service links to its own README with setup details.

| Service | Description | Category |
|---------|-------------|----------|
| [Homepage](services/homepage/) | Modern dashboard with service auto-discovery | Infrastructure |
| [Traefik](services/traefik/) | Reverse proxy with automatic SSL certificates | Infrastructure |
| [ChangeDetection](services/changedetection/) | Website change monitoring with JS support | Monitoring |
| [n8n](services/n8n/) | Workflow automation platform | Automation |
| [Open WebUI](services/open-webui/) | Chat interface for Ollama and LLMs | AI |
| [Linkwarden](services/linkwarden/) | Collaborative bookmark manager | Tools |
| [MeTube](services/metube/) | YouTube video downloader | Media |
| [Tdarr](services/tdarr/) | Media transcoding | Media |
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
| `task init` | Initialize env files and enable pre-commit hook | `task init` |
| `task logs` | View logs (follows) | `task logs SERVICE=traefik` |
| `task prune` | Remove unused containers/images | `task prune` |
| `task ps` | Show container status | `task ps SERVICE=homepage` |
| `task restart` | Restart a service | `task restart SERVICE=n8n` |
| `task secrets:scan` | Scan repo for secrets (requires gitleaks) | `task secrets:scan` |
| `task secrets:hooks` | Enable gitleaks pre-commit hook | `task secrets:hooks` |
| `task status` | Show all homelab containers | `task status` |
| `task up` | Start all or a specific service | `task up SERVICE=homepage` |

> All commands are designed to work with either all services at once or a single service. If you don't specify a `SERVICE`, the command applies to all services.
