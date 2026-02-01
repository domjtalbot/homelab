# Service Review Checklist

- Compose uses env_file only (no environment block)
- Traefik labels present
- Homepage labels present
- Healthcheck present
- Ports use env vars with image defaults
- No secrets/domains/host paths in tracked files
- README documents usage, URLs, healthcheck, volumes, init steps
- Optional Taskfile only if hooks are needed
- Cron only if required
