# Ofelia Pattern (Repo Standard)

- Jobs are defined via labels on the target service.
- Use `ofelia.enabled=true` and `ofelia.job-exec.*` labels.
- Scripts live in `services/<name>/scripts/`.
- Write status JSON for Homepage ping checks.
- Ofelia status server provides JSON via Traefik.
