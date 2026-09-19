# Requirements Traceability — CircleFund

## Purpose

This matrix traces requirements from the SRS (`docs/01-requirements/srs.md`) through design and verification, ensuring nothing is lost during development. It mirrors the SRS's Appendix B and extends it with test traceability.

## Traceability Matrix

| Requirement | Design Item | Test | Verified |
| --- | --- | --- | --- |
| FR-I1-001 to 007 Identity | `03-architecture/domain-model.md` (Identity) | Unit + Integration + API | ☐ |
| FR-I1-008 to 014 Savings Circle | Domain Model (Circle aggregate); Data Model (Circles) | Integration + API + E2E | ☐ |
| FR-I1-015 to 020 Round | Domain Model (Round lifecycle) | Unit + Integration | ☐ |
| FR-I1-021 to 027 Member & Share | Domain Model (Member, Share) | Unit + Integration | ☐ |
| FR-I1-028 to 032 Contribution | Domain Model (Contribution); ADR-003/004 | Unit + Integration + Concurrency + E2E | ☐ |
| FR-I1-033 to 036 Balance | Domain Model (Balance derivation) | Unit | ☐ |
| FR-I1-037 to 039 Dashboard/Notifications | `04-design/ui-design.md` (Dashboard) | Integration | ☐ |
| FR-I1-040 to 045 Offline Capture & Sync | `04-design/synchronization-design.md`; ADR-001/002 | Offline/Sync + Integration + E2E | ☐ |
| FR-I2-001 to 005 Payout Draw | Domain Model (Payout); ADR-003 | Unit + Concurrency + E2E | ☐ |
| FR-I2-006 to 011 Bidding | Domain Model (Bid, Winner) | Unit + Concurrency + E2E | ☐ |
| FR-I2-012 to 016 Rotation/Lottery | Domain Model | Unit | ☐ |
| FR-I2-017 to 020 Fixed Interest | Domain Model (Interest); BR-FIN-006/007 | Unit | ☐ |
| FR-I2-021 to 024 Reconciliation | BR-REC-001/002 | Unit + Integration | ☐ |
| FR-I2-025 to 028 Debt | Domain Model (Outstanding Debt) | Unit | ☐ |
| FR-I2-029 to 033 Ledger | ADR-003; Domain Model (Ledger) | Unit + Integration | ☐ |
| FR-I2-034 to 036 P&L | Domain Model | Unit | ☐ |
| FR-I2-037 to 039 Audit | BR-AUD-001/002; Domain Model (Audit) | Integration | ☐ |
| FR-I2-040 to 046 Reports/Export | `04-design/api-design.md` | Integration | ☐ |
| FR-I2-047 to 049 Offline Financial | `04-design/synchronization-design.md` | Offline/Sync | ☐ |
| FR-I3-001 to 005 Notification | `04-design/api-design.md`; BR-INT-001 | Integration | ☐ |
| FR-I3-006 to 010 File Storage | NFR-031 | Integration | ☐ |
| FR-I3-011 to 013 External Auth | `04-design/security-design.md` | Integration | ☐ |
| FR-I3-014 to 018 AI Entry | NFR-030; BR-INT-002 | Integration | ☐ |
| FR-I3-019 to 022 Analytics | `04-design/api-design.md` | Integration | ☐ |
| FR-I3-023 to 026 Subscription | `04-design/api-design.md` | Integration | ☐ |
| FR-I3-027 to 031 Backup | `08-operations/backup-recovery.md` | Integration + Drill | ☐ |
| FR-I4-001 to 037 Group Collaboration | Domain Model (Group, Roles, etc.) | Integration + E2E | ☐ |
| FR-I5-001 to 031 Platform | Domain Model (Accounts, Budget, etc.) | Integration | ☐ |
| NFR-001 to 040 | `04-design/security-design.md`, §5.41 matrix | See test plans | ☐ |

## Verification Completeness Checklist

- [ ] Every functional requirement has at least one unit test
- [ ] Every financial operation has integration test coverage
- [ ] Every API endpoint has an API contract test
- [ ] Key workflows have E2E coverage
- [ ] Every authorization rule has a test
- [ ] Business rules from `business-rules.md` are all tested
- [ ] Edge cases tested (zero/negative amounts, concurrency)
- [ ] Idempotency tested
- [ ] Offline/sync scenarios (exactly-once, conflict) tested
- [ ] Ledger integrity and audit-trail completeness verified