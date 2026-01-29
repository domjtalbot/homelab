# Infisical Service

[Infisical](https://github.com/Infisical/infisical) is an open-source secret management platform for developers and teams.

## Usage

1. Copy `.env.infisical.example` to `.env.infisical` and fill in the required values.
2. Start the service:
   ```sh
   task up SERVICE=infisical
   ```
3. Access Infisical at:  
   `https://infisical.${BASE_DOMAIN}`

## Environment Variables

| Variable                   | Description                                      |
|---------------------------|--------------------------------------------------|
| INFISICAL_PORT             | Port exposed on host (default: 8086)             |
| BASE_DOMAIN                | Your base domain for Traefik routing             |
| INFISICAL_DATABASE_URL     | Database connection string                       |
| INFISICAL_ENCRYPTION_KEY   | 32-byte encryption key for secrets               |
| AUTH_SECRET                | Auth secret for session management               |
| REDIS_URL                  | Redis connection string (default: redis://redis:6379) |

## Healthcheck

The container exposes a healthcheck at `/health` on port 8080.

## Traefik & Homepage

- Traefik is used for HTTPS and reverse proxy.
- Homepage dashboard will auto-discover this service.
