# Web-Check Service

This service runs [web-check](https://github.com/Lissy93/web-check) in Docker.

## Usage

1. Edit `config/config.yaml` to define your checks.
2. Start the service:
   
   ```sh
   make up SERVICE=web-check
   ```

3. Access the dashboard at [http://localhost:3000](http://localhost:3000)

## Healthcheck
- The container healthcheck pings `/api/status` on port 3000.

## Configuration
- See [web-check documentation](https://github.com/Lissy93/web-check?tab=readme-ov-file) for config options.
