# Ofelia (Scheduler)

Ofelia provides label-driven cron scheduling for Docker containers. In this homelab it runs scheduled jobs (like Vault snapshots) defined via Docker labels, and exposes a simple status endpoint for Homepage.

## Usage

- Start: `task up SERVICE=ofelia`
- Status JSON: `https://cron-status.${BASE_DOMAIN}/`

## Environment Variables

See `.env.ofelia.example` for configuration options.

### Required Variables

- `OFELIA_TZ` — Timezone for cron schedules (e.g., UTC, America/Los_Angeles)
- `OFELIA_STATUS_SUBDOMAIN` — Subdomain for the status JSON endpoint
- `CRON_STATUS_HOST_DIR` — Host directory served by the status endpoint

## Status Endpoint

The `ofelia-status` container serves JSON files written by scheduled scripts. For Vault backups:

- `https://cron-status.${BASE_DOMAIN}/vault-daily.json`
- `https://cron-status.${BASE_DOMAIN}/vault-weekly.json`
- `https://cron-status.${BASE_DOMAIN}/vault-monthly.json`

## Notes

- Jobs are declared via Docker labels on the target service containers.
- Ofelia reads labels via the Docker socket.


## Label Requirements

Ofelia only reads jobs from containers that include `ofelia.enabled=true`.
