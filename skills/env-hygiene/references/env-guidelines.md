# Env Guidelines

- No secrets in tracked files.
- No domains or absolute host paths in tracked files.
- `.env.<service>.example` should document all vars.
- Optional/default values should be commented out.
- Avoid empty values.
- Compose files should use env vars; avoid inline `environment:` blocks.
- Root `.env` only for global vars.
