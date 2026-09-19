# Deployment Guide — Deployment Steps

**Index:** `docs/07-release/deployment-guide.md`

1. **Setup**

```bash
sudo apt update && sudo apt upgrade -y
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
sudo apt install -y docker-compose-plugin
```

2. **Clone & checkout**

```bash
git clone https://github.com/<org>/circlefund.git
cd circlefund
git checkout v1.0.0
```

3. **Configure** — copy `docker-compose.production.yml`, set env vars (§01).

4. **Deploy & migrate**

```bash
docker compose -f docker-compose.production.yml up -d
docker compose -f docker-compose.production.yml exec api dotnet ef database update
```

5. **Verify**

```bash
curl https://api.<domain>/health
docker compose -f docker-compose.production.yml ps
```

## Post-Deployment

- Verify backup works (`pg_dump` test + restore sanity).
- Confirm monitoring active (health endpoint check every 30s).
- First-time setup: admin user, Association Types seed, SMTP, integration keys.
- Financial smoke test: create circle → record contribution → check balance.