# Homelab Service Checklist

Use this checklist when adding a new service.

## Required artifacts

- `services/<name>/docker-compose.yml`
- `services/<name>/.env.<name>.example`
- `services/<name>/README.md`

## Compose rules

- Must use `env_file`.
- Must not include `environment:` block.
- Ports use env vars with defaults matching image defaults.
- Traefik labels included.
- Homepage labels included.
- Healthcheck included.
- External `traefik` network when web‑facing.

## Env example rules

- Comment out optional/default values.
- No secrets (keys, tokens, domains, or personal paths).
- Use placeholders with guidance for generation.

## Documentation rules

- Describe service purpose and homelab wiring.
- Provide URLs and health endpoints.
- List required and optional env vars.
- Document volumes and data paths.
- Include init/unseal steps if applicable.

## Cron rules (optional)

- Only add cron if needed; ask first.
- Use Ofelia labels for jobs.
- Put scripts in `services/<name>/scripts/`.
- Write status JSON for Homepage ping checks.

## Hooks (optional)

- Add `services/<name>/Taskfile.yml` only if a hook is required.

## Validation

- `task up SERVICE=<name>`
- Confirm healthcheck is healthy
- Confirm Traefik route works
- Confirm Homepage entry appears
