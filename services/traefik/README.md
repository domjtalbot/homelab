# Traefik Reverse Proxy

Traefik is a modern reverse proxy and load balancer that automatically discovers Docker containers and routes traffic to them via subdomains.

## Features

- **Automatic Docker Discovery**: Containers with `traefik.enable=true` labels are automatically proxied
- **Let's Encrypt SSL**: Automatic TLS certificates via Cloudflare DNS challenge
- **Wildcard Certificates**: Single certificate covers `*.home.example.com`
- **Dashboard**: Web UI at `https://traefik.home.example.com`

## Setup

### 1. Configure Environment Variables

Copy the example env file and fill in your values:

```bash
cp services/traefik/.env.traefik.example .env.traefik
```

Edit `.env.traefik` and set:

| Variable | Description |
|----------|-------------|
| `CF_DNS_API_TOKEN` | Cloudflare API token with DNS edit permissions |
| `ACME_EMAIL` | Email for Let's Encrypt certificate notifications |

### 2. Create Cloudflare API Token

1. Go to [Cloudflare Dashboard → Profile → API Tokens](https://dash.cloudflare.com/profile/api-tokens)
2. Click **Create Token**
3. Use the **Edit zone DNS** template, or create custom:
   - **Permissions**: Zone → DNS → Edit
   - **Zone Resources**: Include → Specific zone → `your-domain.com`
4. Copy the token to `CF_DNS_API_TOKEN` in `.env.traefik`

### 3. Configure Base Domain

In your root `.env` file, set:

```bash
BASE_DOMAIN=home.yourdomain.com
```

### 4. Cloudflare DNS Setup

Add a wildcard A record pointing to your server:

| Type | Name | Content | Proxy |
|------|------|---------|-------|
| A | `*.home` | `YOUR_SERVER_IP` | DNS only (grey cloud) |

> ⚠️ **Important**: Use "DNS only" (grey cloud), not "Proxied" (orange cloud). Traefik handles TLS termination, not Cloudflare.

### 5. Start Traefik

```bash
make up SERVICE=traefik
```

## Adding Services

Services are automatically discovered when they have Traefik labels:

```yaml
services:
  myapp:
    image: myapp:latest
    labels:
      - traefik.enable=true
      - traefik.http.routers.myapp.rule=Host(`myapp.${BASE_DOMAIN}`)
      - traefik.http.routers.myapp.entrypoints=websecure
      - traefik.http.routers.myapp.tls.certresolver=cloudflare
      - traefik.http.services.myapp.loadbalancer.server.port=8080
    networks:
      - traefik

networks:
  traefik:
    external: true
```

## Proxying External Services

For services running on other machines (NAS, Home Assistant, etc.), create a dynamic config file:

```bash
cp services/traefik/dynamic/external-services.yml.example services/traefik/dynamic/external-services.yml
```

Edit the file to add your external services. Changes are picked up automatically.

## Ports

| Port | Purpose |
|------|---------|
| 80 | HTTP (redirects to HTTPS) |
| 443 | HTTPS |

## Troubleshooting

### Check Traefik logs
```bash
make logs SERVICE=traefik
```

### Verify certificate
```bash
docker exec homelab-traefik cat /letsencrypt/acme.json | jq '.cloudflare.Certificates'
```

### Test DNS resolution
```bash
dig +short myapp.home.yourdomain.com
```

### Common Issues

1. **Certificate not issued**: Check Cloudflare API token permissions and DNS propagation
2. **502 Bad Gateway**: Ensure the service is on the `traefik` network
3. **404 Not Found**: Check the Host rule matches your domain exactly
