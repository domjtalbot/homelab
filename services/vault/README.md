# Vault

<p align="center">
  <img src="https://raw.githubusercontent.com/hashicorp/vault/main/website/public/img/logo-hashicorp.svg" alt="Vault Logo" width="140" />
</p>

[![Docker Pulls](https://img.shields.io/badge/docker-hashicorp%2Fvault-blue?style=flat-square)](https://hub.docker.com/r/hashicorp/vault)
[![GitHub Stars](https://img.shields.io/github/stars/hashicorp/vault?style=flat-square)](https://github.com/hashicorp/vault)
[![License](https://img.shields.io/github/license/hashicorp/vault?style=flat-square)](https://github.com/hashicorp/vault/blob/main/LICENSE)

---

HashiCorp Vault is a secrets management system for storing, controlling access to, and auditing sensitive data.

## Usage

- Web UI: `https://vault.${BASE_DOMAIN}`
- API: `https://vault.${BASE_DOMAIN}/v1/`
- Health: `http://localhost:8200/v1/sys/health`

## Environment Variables

See `.env.vault.example` for configuration options.

### Required Variables

- `VAULT_PORT` — Host port mapped to container port 8200
- `VAULT_SUBDOMAIN` — Subdomain for Traefik routing

### Optional Variables

- `VAULT_API_ADDR` — Public API address for clients and UI
- `VAULT_CLUSTER_ADDR` — Cluster address for Raft
- `VAULT_LOG_LEVEL` — Logging verbosity
- `VAULT_UI` — Enable or disable the UI
- `VAULT_BACKUP_DIR` — Container path for snapshots (default: /backups)
- `CRON_STATUS_DIR` — Container path for status JSON (default: /cron-status)
- `VAULT_BACKUP_HOST_DIR` — Host path for snapshot storage
- `VAULT_CRON_STATUS_HOST_DIR` — Host path for status JSON files
- `VAULT_BACKUP_TOKEN` — Token used for snapshot jobs
- `VAULT_BACKUP_DAILY_RETENTION` — Daily snapshot retention
- `VAULT_BACKUP_WEEKLY_RETENTION` — Weekly snapshot retention
- `VAULT_BACKUP_MONTHLY_RETENTION` — Monthly snapshot retention

## Volumes

- `vault_raft:/vault/raft` — Vault integrated Raft storage data
- `vault_audit:/vault/audit` — Audit log storage

## Configuration

The Vault server uses the config file at `vault.hcl` and runs in production mode with Raft storage.
TLS is disabled inside the container and is expected to be terminated by Traefik.
If you previously ran Vault with file storage, switching to Raft requires re-initialization because the backend has changed.

## Initialization and Unseal

After the container is running, initialize and unseal Vault once:

```bash
export VAULT_ADDR=http://127.0.0.1:8220
vault operator init
vault operator unseal
```

Store the unseal keys and root token securely.

## Audit Logging

Audit logs are written to `/vault/audit/vault_audit.log` inside the container and persisted in `vault_audit`.

## Backups (Raft Snapshots)

Backups are created by the Ofelia scheduler via labels on the Vault container.
Snapshots are written to `${VAULT_BACKUP_DIR}` (container path) with tiered retention. The host path is configured via `VAULT_BACKUP_HOST_DIR` in `.env.vault`.

- Daily: 7
- Weekly: 4
- Monthly: 6

Status JSON files are written to `${CRON_STATUS_DIR}` (container path). The host path is configured via `VAULT_CRON_STATUS_HOST_DIR` in `.env.vault`. They are served at:

- `https://cron-status.${BASE_DOMAIN}/vault-daily.json`
- `https://cron-status.${BASE_DOMAIN}/vault-weekly.json`
- `https://cron-status.${BASE_DOMAIN}/vault-monthly.json`

Schedules (default, in Ofelia TZ):

- Daily: 02:00
- Weekly: Sunday 03:00
- Monthly: 1st 04:00

### Backup Token

Create a token with access to Raft snapshots and store it in `VAULT_BACKUP_TOKEN`.

Example policy:

```hcl
path "sys/storage/raft/snapshot" {
  capabilities = ["read"]
}
```

Create the policy and token:

```bash
vault policy write raft-snapshot -<<EOF
path "sys/storage/raft/snapshot" {
  capabilities = ["read"]
}
EOF

vault token create -policy=raft-snapshot
```

## Healthcheck

The container healthcheck polls `/v1/sys/health` and treats sealed/uninitialized states as healthy so the container remains up while you initialize it.

## Documentation

- [Vault GitHub](https://github.com/hashicorp/vault)
- [Official Docs](https://developer.hashicorp.com/vault/docs)
- [Configuration Reference](https://developer.hashicorp.com/vault/docs/configuration)
