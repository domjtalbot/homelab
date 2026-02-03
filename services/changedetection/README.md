# ChangeDetection

ChangeDetection watches websites and alerts you when page content changes.

## How it is wired in this homelab

- Main app container: `ghcr.io/dgtlmoon/changedetection.io`
- JavaScript rendering container: `dgtlmoon/sockpuppetbrowser`
- Reverse proxy + TLS: Traefik
- Service discovery: Homepage labels
- Persistent data: Docker volume `changedetection_data`

## Access

- UI: `https://changedetection.${BASE_DOMAIN}`
- Healthcheck: `http://127.0.0.1:5000/`

## Environment variables

See `.env.changedetection.example`.

Required for this scaffold:

- `CHANGEDETECTION_PORT`
- `CHANGEDETECTION_SUBDOMAIN`
- `PLAYWRIGHT_DRIVER_URL`
- `DEFAULT_FETCH_BACKEND` (set to `html_webdriver` for screenshot support)

Common optional variables (commented in the example file):

- `BASE_URL`
- `USE_X_SETTINGS`
- `FETCH_WORKERS`
- `MINIMUM_SECONDS_RECHECK_TIME`
- `HIDE_REFERER`
- `DISABLE_VERSION_CHECK`

## Notes

- JavaScript-heavy sites are fetched through the bundled `browser-sockpuppet-chrome` service using `PLAYWRIGHT_DRIVER_URL`.
- Screenshots/JS checks run fully inside Docker (no host browser dependency).
- If you imported/created watches before this setting, edit each watch and set Content Fetcher to `System settings default` or `WebDriver` to enable screenshots.
- No service Taskfile is needed for this service.
