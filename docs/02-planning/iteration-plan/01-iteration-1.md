# Iteration Plan — Iteration 1 (Offline-First Core)

**Sequence:** Identity (offline login) → Local Storage & Queue → Savings Circle → Round → Members → Share → Contribution → Balance → Dashboard → Notifications → Sync & Conflict.

## Sprint 1 — Identity & Local Queue

**Epics:** I1-E01 Identity & Account; I1-E02 Local Storage & Operation Queue.

| Item | Detail |
| --- | --- |
| Objective | Auth with offline credential cache; local-first data layer; operation queue with local IDs |
| Dependencies | Repository/tooling, CI, base architecture |
| Exit criteria | login/logout/register/profile; offline read-only unlock; queue add/read with localId + idempotencyKey |

## Sprint 2 — Circle & Round

**Epics:** I1-E03 Savings Circle; I1-E04 Round.
**Objective:** circle aggregate, ROSCA types, lifecycle; round generation — all via local queue. **Exit:** create/edit/pause/close circle; generate/view/open rounds.

## Sprint 3 — Members, Share, Contribution, Balance

**Epics:** I1-E05 Members & Share; I1-E06 Contribution; I1-E07 Balance.
**Objective:** membership, share assignment, membership invariants, contribution recording, balance derivation. **Exit:** add/assign/suspend members; record contribution (atomic + ledger + audit); balance from ledger.

## Sprint 4 — Dashboard & Sync

**Epics:** I1-E08 Dashboard; I1-E09 Synchronization & Conflict Detection.
**Objective:** dashboard/reminders; sync engine, conflict detection, per-record sync status. **Exit:** dashboard aggregates; offline->online exactly-once sync; conflict surfacing.

**Release outcome:** a Circle Organizer can create a circle, add members, generate rounds, record payments, and see balances — fully offline, syncing automatically once back online.