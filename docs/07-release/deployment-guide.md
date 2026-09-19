# Deployment Guide — CircleFund

## Prerequisites

### Server Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| CPU | 2 cores | 4+ cores |
| RAM | 4 GB | 8+ GB |
| Disk | 50 GB SSD | 100+ GB SSD |
| OS | Linux (Ubuntu 22.04 LTS) | Ubuntu 22.04 LTS or similar |
| Network | Broadband | Broadband with static IP |

### Software Requirements

| Software | Version | Notes |
|----------|---------|-------|
| Docker | 24+ | Required for deployment |
| Docker Compose | 2.0+ | Or Docker Compose V2 |
| .NET Runtime | 8.0 | For API server |
| Node.js | 20+ | Only for build (not production) |
| PostgreSQL | 15+ | Database |
| Redis | 7+ | Caching (progressive) |

### Domain & DNS

- Domain pointing to server IP
- SSL certificate (Let's Encrypt or managed)
- DNS configured for:
  - `circlefund.example.com` (frontend)
  - `api.circlefund.example.com` (backend)

## Deployment Steps

### 1. Server Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# Install Docker Compose V2 (plugin)
sudo apt install docker-compose-plugin -y
```

### 2. Clone Repository

```bash
git clone https://github.com/your-org/circlefund.git
cd circlefund
git checkout v0.1.0  # Desired version
```

### 3. Configure Environment

Copy and edit environment file:

```bash
cp docker-compose.yml docker-compose.production.yml
# Edit docker-compose.production.yml
```

Required environment variables:

```bash
# Database
POSTGRES_HOST=db
POSTGRES_PORT=5432
POSTGRES_DB=circlefund
POSTGRES_USER=circlefund
POSTGRES_PASSWORD=<strong-random-password>

# Authentication
JWT_SECRET=<very-long-random-string-min-32-chars>
JWT_EXPIRY_MINUTES=15

# Application
ASPNETCORE_ENVIRONMENT=Production
ASPNETCORE_URLS=https://+:5001

# Email (for notifications)
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=circlefund@example.com
SMTP_PASSWORD=<email-password>
```

### 4. Deploy

```bash
# Start all services
docker compose -f docker-compose.production.yml up -d

# Run database migrations
docker compose -f docker-compose.production.yml exec api dotnet ef database update

# Verify services are running
docker compose -f docker-compose.production.yml ps
```

### 5. Verify

```bash
# Check health endpoint
curl https://api.circlefund.example.com/health

# Check frontend
curl https://circlefund.example.com

# Check database connection (from API container)
docker compose -f docker-compose.production.yml exec api \
  dotnet ef database info
```

## Docker Compose Configuration

```yaml
version: '3.8'

services:
  api:
    build:
      context: .
      dockerfile: src/CircleFund.Api/Dockerfile
    ports:
      - "5001:5001"
    environment:
      - ASPNETCORE_ENVIRONMENT=Production
      - Database__ConnectionString=${DATABASE_CONNECTION_STRING}
      - JWT_SECRET=${JWT_SECRET}
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: circlefund
      POSTGRES_USER: circlefund
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - pgdata:/var/lib/postgresql/data
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./certs:/etc/nginx/certs:ro
    depends_on:
      - api
    restart: unless-stopped

volumes:
  pgdata:
```

## Post-Deployment

### Database Backup Verification

```bash
# Test backup works
docker compose -f docker-compose.production.yml exec db \
  pg_dump -U circlefund circlefund > /tmp/backup-test.sql

# Verify backup content
grep "CREATE TABLE" /tmp/backup-test.sql | head -5
```

### Monitoring Setup

- Health check endpoint: `/health`
- Application logs: check container logs
- Database monitoring: pg_stat_activity
- Error alerting: configure log-based alerts

### First-Time Setup

1. Create initial admin user (if not seeded)
2. Configure circle types and defaults
3. Set up notification email
4. Configure SMTP/email service
5. Verify all integrations

## Troubleshooting

### Services not starting

```bash
docker compose -f docker-compose.production.yml logs api
docker compose -f docker-compose.production.yml logs db
docker compose -f docker-compose.production.yml ps
```

### Database connection issues

```bash
docker compose -f docker-compose.production.yml exec api \
  dotnet ef database info
docker compose -f docker-compose.production.yml exec db \
  pg_isready -U circlefund -d circlefund
```

### Rollback

```bash
# Revert to previous version
git checkout v0.0.9
docker compose -f docker-compose.production.yml up -d --force-recreate
```

## Infrastructure Notes

CircleFund infrastructure is progressive:

- **Phase 1:** Single server, Docker Compose, PostgreSQL, Redis
- **Phase 2+:** Scaling, load balancing, database read replicas, object storage
- **Phase 3+:** CI/CD pipeline, automated deployment, multi-environment
