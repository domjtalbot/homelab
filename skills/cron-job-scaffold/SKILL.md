---
name: cron-job-scaffold
description: "Add scheduled jobs using the Ofelia pattern when the user asks to add a cron job, schedule a job, or add backups."
---

# Cron Job Scaffold

Use this skill to add scheduled jobs that follow the Ofelia pattern used in this repo.

## When to use

Use only when scheduled execution is required. If not required, do nothing.

## Workflow

1) Confirm the schedule(s) and retention needs.
2) Add Ofelia labels to the target service:
   - `ofelia.enabled=true`
   - `ofelia.job-exec.<name>.schedule=...`
   - `ofelia.job-exec.<name>.command=...`
   - `ofelia.job-exec.<name>.container=<stack>-<service>`
3) Add scripts under `services/<name>/scripts/`.
4) Write status JSON for Homepage ping checks.
5) Add/adjust `services/homepage/config/services.yaml` only if labels cannot express the UI.
6) Ensure no secrets/domains/host paths in tracked files.

## Output

- Updated service compose labels
- Script(s)
- Status JSON generation

## Reference

See `references/ofelia-pattern.md`.
