# Monitoring — Metrics & Alerts

**Index:** `docs/08-operations/monitoring.md`

## System
CPU >80% (5 min); Memory >80% allocated (5 min); Disk >85% (5 min).

## Application
HTTP 5xx >1% (5 min); HTTP 4xx >10% (5 min); avg/P95 response >1s/>3s (5 min); DB connections >80% max; health failures >2 consecutive.

## Security
Failed logins >10/IP (5 min); authorization denials >20 (1h).

## Business & Sync
Failed contributions >5% (1h); failed payout draws >2 (1h); pending-sync queue depth unbounded; sync conflicts unresolved rising; sync failures >3 consecutive; reconciliation discrepancies any unresolved.