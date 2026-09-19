# Synchronization Design — Conflict Resolution

## Detection

Conflict occurs when the server detects a mutation would overwrite a change it doesn't know about — detected via optimistic concurrency (`ServerVersion`) on the target record, or a business-rule violation that implies divergence (e.g., member already removed).

Server returns:

```json
{ "error": { "code": "SYNC_CONFLICT",
  "details": { "localVersion": {...}, "serverVersion": {...} } } }
```

## Resolution UX

1. Surface both versions side by side:
   - **Local** — what this device recorded (timestamp, actor, field values).
   - **Server** — current authoritative state.
2. Offer three actions:
   - **Accept server** → discard local (mark `synced` as no-op).
   - **Keep local** → retry with the conflict resolved (mark pending, re-submit).
   - **Defer** → leave `conflict` for later.
3. Record the resolution in the audit trail.

```typescript
async function resolve(op: Operation, choice: 'server' | 'local') {
  if (choice === 'server') { op.status = 'synced'; op.lastError = undefined }
  else { op.status = 'pending'; op.retryCount = 0 }          // re-submit
  await db.operations.put(op)
  await audit.log('SyncConflictResolved', { op, choice })
}
```

## Financial Escalation (FR-I2-048)

For financial mutation types (`Contribution`, `PayoutDraw`, `Bid`, transfers), conflict **never auto-resolves** and **never auto-merges** — it escalates to a Treasurer for manual reconciliation via `POST /sync/conflicts/{id}/resolve`.

## Non-Financial Conflicts

Non-financial records (e.g., share edits per FR-I1-043) may be resolved by the affected user choosing server/local with the same three actions.