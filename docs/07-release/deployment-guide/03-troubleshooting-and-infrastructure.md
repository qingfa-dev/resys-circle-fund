# Deployment Guide — Troubleshooting & Infrastructure

**Index:** `docs/07-release/deployment-guide.md`

## Troubleshooting

| Symptom | Check / Fix |
| --- | --- |
| API not starting | `docker compose logs api` |
| DB connection failure | `docker compose exec db pg_isready -U circlefund -d circlefund`; verify `DATABASE_CONNECTION_STRING` |
| Migrations failing | `dotnet ef database info`; review migration SQL |
| TLS errors | cert validity; nginx `ssl_certificate` paths |
| Rollback needed | `git checkout v<prev>` → `up -d --force-recreate` |

## Infrastructure (progressive)

- **Phase 1:** single server, Docker Compose, PostgreSQL, Redis.
- **Phase 2+:** scale API horizontally (stateless), load balancer, DB read replicas, object storage.
- **Phase 3+:** CI/CD pipeline, multi-environment, automated deployment.