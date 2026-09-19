# Deployment Guide — Prerequisites

**Index:** `docs/07-release/deployment-guide.md`

## Server Requirements

| Component | Minimum | Recommended |
| --- | --- | --- |
| CPU | 2 cores | 4+ cores |
| RAM | 4 GB | 8+ GB |
| Disk | 50 GB SSD | 100+ GB SSD |
| OS | Ubuntu 22.04 LTS | Ubuntu 22.04 LTS |

## Software

Docker 24+ · Docker Compose v2 · .NET 8 runtime · Node 20 (build only) · PostgreSQL 15 · Redis 7.

## Domain & DNS

- Domain → server IP.
- TLS cert (Let's Encrypt) with auto-renew.
- DNS: `app.<domain>` (frontend) + `api.<domain>` (backend).

## Required Environment Variables

```bash
POSTGRES_DB=circlefund
POSTGRES_USER=circlefund
POSTGRES_PASSWORD=<strong-random>
DATABASE_CONNECTION_STRING=Host=db;Port=5432;Database=circlefund;Username=circlefund;Password=<...>
JWT_SECRET=<min-32-chars>
JWT_EXPIRY_MINUTES=15
ASPNETCORE_ENVIRONMENT=Production
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=circlefund@example.com
SMTP_PASSWORD=<email-password>
```

## Nginx (TLS termination)

```nginx
server {
  listen 443 ssl;
  server_name api.<domain>;
  ssl_certificate /etc/nginx/certs/fullchain.pem;
  ssl_certificate_key /etc/nginx/certs/privkey.pem;
  location / {
    proxy_pass http://api:5001;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
```

## Docker Compose (summary)

`api` (build `src/CircleFund.Api/Dockerfile`, port 5001) · `db` (postgres:15, volume `pgdata`) · `redis` (redis:7-alpine) · `nginx` (ports 80/443). `restart: unless-stopped` on all.