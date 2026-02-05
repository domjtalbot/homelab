---
name: service-removal
description: "Remove a service from the homelab repo and Docker runtime safely. Use when the user asks: remove a service, delete a service, decommission a service."
---

# Service Removal

## Core rules

- Confirm the service name and whether to remove volumes/images before destructive steps.
- Stop the service via `task down SERVICE=<name>` before removal.
- Remove the service folder under `services/<name>/` and its env files (`.env.<name>`, `services/<name>/.env.<name>.example`).
- Remove service references from root README and any other docs.
- Remove Homepage entries only if they are not label-driven.
- Do not edit unrelated services.

## Workflow

1) Confirm service name and whether to remove:
   - Docker containers
   - Docker volumes
   - Docker images
2) Stop the service with `task down SERVICE=<name>`.
3) Remove runtime artifacts based on user confirmation.
4) Delete `services/<name>/` and related `.env.<name>` files.
5) Update docs (root README, service lists, and any referenced docs).
6) Verify no orphaned references remain.

## Notes

- If the service uses shared volumes, ask before deleting them.
- If the service has data retention requirements, ask before removal.
