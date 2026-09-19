# Iteration Plan — Iteration 3 (Integrations)

**Sequence:** Notification → File Storage → External Auth → AI/Natural-Language → Analytics → Subscription/Billing → Backup.

## Sprint 9 — Notification & File Storage
**Epics:** I3-E01 Notification; I3-E02 File Storage. Focus: real delivery channels with retry/dedup; file upload/validation/scan; authorization on stored files.

## Sprint 10 — External Auth & AI Entry
**Epics:** I3-E03 External Auth; I3-E04 AI/Natural-Language. Focus: external IdP login/link; AI proposes, user confirms.

## Sprint 11 — Analytics, Backup, Subscription
**Epics:** I3-E05 Analytics; I3-E06 Backup; I3-E07 Subscription/Billing.

**Release gate:** every external dependency has a defined failure mode — a failed notification never rolls back a committed transaction, a failed AI call never blocks manual entry, a failed backup is detected and alerted rather than silently skipped.