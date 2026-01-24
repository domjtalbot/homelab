# Homepage Service

This service runs [Homepage](https://github.com/gethomepage/homepage) - a modern, fully static, fast, secure dashboard with service auto-discovery.

## Usage

1. Copy the example env file and customize:
   
   ```sh
   cp .env.homepage.example .env.homepage
   ```

2. Start the service:
   
   ```sh
   make up SERVICE=homepage
   ```

3. Access the dashboard at [http://localhost:3002](http://localhost:3002)

## Service Auto-Discovery

Services are automatically discovered via Docker labels. Each service in this homelab has labels configured for Homepage to discover them.

Labels used:
- `homepage.group` - Group name (e.g., Media, Infrastructure)
- `homepage.name` - Display name
- `homepage.icon` - Icon name (from https://github.com/walkxcode/dashboard-icons)
- `homepage.href` - URL to access the service
- `homepage.description` - Service description

## Configuration

- `config/docker.yaml` - Docker socket configuration
- `config/services.yaml` - Manual service definitions (optional, auto-discovery is enabled)
- `config/settings.yaml` - Dashboard settings (theme, layout, etc.)
- `config/widgets.yaml` - Information widgets (resources, time, etc.)
- `config/bookmarks.yaml` - Bookmark links

## Healthcheck

The container healthcheck pings port 3000 internally.

## Documentation

See [Homepage documentation](https://gethomepage.dev/) for more configuration options.
