# Rollback Plan — Procedures

**Index:** `docs/07-release/rollback-plan.md`

## Code Issue (no DB impact)
1. Identify issue → 2. notify → 3. revert to prior tag → 4. redeploy → 5. verify → 6. notify.

```bash
git checkout v<previous>
docker compose up -d --force-recreate
curl https://api.<domain>/health
```

## Database Migration Failed
1. Stop deployments → 2. assess DB → 3. restore from backup (if corrupt) → 4. revert code → 5. redeploy → 6. verify.

## Configuration Error
1. Revert config values → 2. restart services → 3. verify.

## Verification Checklist
Health OK; login; create circle; record contribution; balances correct; dashboard; monitoring back to baseline; no error spikes.