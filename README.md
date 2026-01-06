# Homelab Docker Services

This repository contains a collection of self-hosted services for a Mac-based homelab, managed with Docker Compose. The design prioritizes simplicity, security, and extensibility.

## Usage

### Environment Variables
- All required environment variables are documented in `.env.example` files at the repository root (global variables) and in each service folder (service-specific variables).
- Copy `.env.example` to `.env` at each location and fill in the required values.
- **Never commit `.env` files with secrets.**

### Makefile Commands

| Command         | Description                                 | Example Usage                      |
|-----------------|---------------------------------------------|------------------------------------|
| up              | Start all or a specific service              | `make up` or `make up SERVICE=plex`|
| down            | Stop all or a specific service               | `make down` or `make down SERVICE=plex`|
| logs            | View logs for a service                      | `make logs SERVICE=plex`           |
| ps              | Show running containers for a service        | `make ps SERVICE=plex`             |
| restart         | Restart a service                            | `make restart SERVICE=plex`        |
| prune           | Remove unused containers and images          | `make prune`                       |
| help            | Show available commands and usage            | `make help`                        |

- If `SERVICE` is omitted, the command applies to all services.
- The Makefile automatically detects available services in the `services/` directory.

### Add a New Service
- Create a new folder in `services/` (e.g., `services/mynewservice`).
- Add a `docker-compose.yml` file (and optionally `.env.example`) to that folder.
- The Makefile will automatically detect and manage it—no Makefile changes are required.

## Security
- No secrets or domains are stored in the repository.
- All secrets must be provided via environment variables.

## Contributing
- Pull requests are welcome. Do not include secrets or personal domains.

---

For more details, see each service's folder and `docker-compose.yml`.
