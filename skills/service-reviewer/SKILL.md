---
name: service-reviewer
description: "Review a homelab service for compliance and readiness when the user asks to review a service, check compliance, or see if it is ready to commit."
---

# Service Reviewer

Use this skill to review a new or updated service against the homelab standards.

## Review focus

Prioritize:
- Secrets or sensitive data in tracked files
- Missing labels (Traefik/Homepage)
- Env hygiene (env_file usage, no `environment:` block)
- Healthcheck present and correct
- README completeness
- Root file edits (should be avoided)
- Taskfile usage only when needed
- Cron setup only when needed

## Workflow

1) Identify changed files for the service.
2) Check compose file for:
   - `env_file` only (no `environment:`)
   - Traefik + Homepage labels
   - Healthcheck
   - Correct ports with defaults matching image
3) Check `.env.<name>.example`:
   - No secrets/paths/domains
   - Optional values commented out
4) Check README:
   - Purpose, URLs, healthcheck, volumes, init steps
5) If cron or hooks exist, confirm they’re justified.
6) Summarize findings by severity.

## Output

- Findings list (highest severity first)
- Any open questions
- Readiness to commit

## Reference

See `references/review-checklist.md`.
