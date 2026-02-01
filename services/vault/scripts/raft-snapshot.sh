#!/bin/sh
set -eu

tier="${1:-}"
if [ -z "$tier" ]; then
  echo "Usage: raft-snapshot.sh <daily|weekly|monthly>" >&2
  exit 2
fi

case "$tier" in
  daily|weekly|monthly) ;; 
  *)
    echo "Invalid tier: $tier" >&2
    exit 2
    ;;
esac

backup_dir="${VAULT_BACKUP_DIR:-/backups}"
status_dir="${CRON_STATUS_DIR:-/cron-status}"

case "$tier" in
  daily) retention="${VAULT_BACKUP_DAILY_RETENTION:-7}" ;;
  weekly) retention="${VAULT_BACKUP_WEEKLY_RETENTION:-4}" ;;
  monthly) retention="${VAULT_BACKUP_MONTHLY_RETENTION:-6}" ;;
esac

mkdir -p "$backup_dir/$tier" "$status_dir"

ts="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
file_ts="$(date -u +"%Y%m%d%H%M%S")"
snapshot_path="$backup_dir/$tier/vault-$tier-$file_ts.snap"
status_file="$status_dir/vault-$tier.json"

status="failed"
message="unknown error"

write_status() {
  size_bytes="0"
  if [ -f "$snapshot_path" ]; then
    size_bytes="$(wc -c < "$snapshot_path" | tr -d ' ')"
  fi
  cat > "$status_file" <<JSON
{
  "service": "vault",
  "tier": "$tier",
  "status": "$status",
  "timestamp": "$ts",
  "snapshot": "$snapshot_path",
  "size_bytes": $size_bytes,
  "retention": $retention,
  "message": "$message"
}
JSON
}

trap 'write_status' EXIT

token="${VAULT_TOKEN:-${VAULT_BACKUP_TOKEN:-}}"
if [ -z "$token" ]; then
  message="missing VAULT_BACKUP_TOKEN"
  exit 1
fi

export VAULT_TOKEN="$token"
export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"

vault operator raft snapshot save "$snapshot_path"

count=0
for f in $(ls -1t "$backup_dir/$tier"/*.snap 2>/dev/null || true); do
  count=$((count + 1))
  if [ "$count" -gt "$retention" ]; then
    rm -f "$f"
  fi
done

status="success"
message="snapshot created"
write_status
trap - EXIT
