# Glossary — CircleFund

This glossary uses CircleFund's English domain terminology as the primary term, mapping each back to the original Vietnamese word that the product's users and stakeholders use in practice. Terminology mirrors the authoritative SRS (`docs/01-requirements/srs.md`, Appendix D).

## Domain Terms

| English Term | Vietnamese Term | Explanation |
| --- | --- | --- |
| ROSCA (Rotating Savings and Credit Association) | Hụi (also *họ*, *phường*, *biêu* in some regions) | The general name for an informal, trust-based rotating savings/credit arrangement: a fixed group contributes a fixed amount on a fixed schedule, and the pooled amount is given to one member each round until everyone has received a payout once. |
| Savings Circle | Dây hụi | One running instance of a ROSCA — a specific group with its own members, schedule, and rules. "Dây" literally means "string/strand," evoking a chain of linked people. |
| Circle Organizer | Chủ hụi | The person who administers a Savings Circle: recruiting members, collecting contributions, running the payout draw, and keeping the books. |
| Circle Member | Hụi viên | A participant who contributes each round and is entitled to receive the pooled payout in their turn. |
| Round | Kỳ (also *kỳ hụi*) | One cycle of a Savings Circle (e.g., one month) during which every member contributes and one member receives the payout. |
| Share | Phần | A single contribution unit within a circle; a member may hold more than one, effectively participating multiple times. |
| Contribution | Đóng (also *đóng hụi*) | The act of a member paying their required amount for a given Round. |
| Payout Draw | Hốt (also *hốt hụi*) | A member receiving the pooled funds for a given Round. Literally "to scoop/collect the pot." |
| Bidding | Đấu thầu | A ROSCA variant where members compete each round by bidding for early access to the payout; the discount is shared among the other members as informal interest. |
| No-Interest Rotation | Không lãi | A variant with a fixed payout order (or lottery) and no bidding or interest; every member eventually receives what they contributed. |
| Fixed Interest | Lãi cố định | A variant applying a pre-set interest rate to each round's payout instead of competitive bidding. |
| Association Type | Loại hụi | The configured variant of a Savings Circle — No-Interest Rotation, Fixed Interest, or Bidding. |
| Reconciliation | Cân bằng (also *đối soát*) | Comparing expected vs. actual amounts collected/paid for a Round and resolving discrepancies. |
| Outstanding Debt | Công nợ | The amount a member still owes (unpaid contributions or an unreturned early payout) at a point in time. |
| Financial Ledger | Sổ hụi | The append-only authoritative record of financial transactions. |

## General Terms

| Term | Definition |
| --- | --- |
| Balance | The current financial position of a member or circle, derived from ledger entries. |
| Payout | The distribution of pooled funds to a member (distinct from the Payout Draw event that decides *who* receives it). |
| Winner | The member selected to receive the pooled funds in a given round. |
| Rotation | A sequential payout order used in No-Interest Rotation circles. |
| Lottery | A random selection method to determine the payout recipient. |
| Audit Trail | A traceable record of who did what, when, and why. |
| Reconciliation | The process of verifying that expected and actual amounts match. |
| Local Operation Queue | The client-side FIFO store of operations captured offline, pending synchronization. |
| Idempotency | Property ensuring an operation can be safely retried without duplicating its effect. |
| Correlation ID | An identifier tracing a logical operation across systems and records. |

## Actors (per SRS Section 2)

| ID | Actor |
| --- | --- |
| ACT-01 | Visitor |
| ACT-02 | Registered User |
| ACT-03 | Circle Organizer |
| ACT-04 | Circle Member |
| ACT-05 | Treasurer |
| ACT-06 | Secretary |
| ACT-07 | Group Owner |
| ACT-08 | Group Moderator |
| ACT-09 | Viewer |
| ACT-10 | System Administrator |
| ACT-11 | Notification Service |
| ACT-12 | File Storage Service |
| ACT-13 | Scheduler |
| ACT-14 | Authentication Provider |
| ACT-15 | Analytics/Reporting Engine |
| ACT-16 | AI Service |
| ACT-17 | Backup Storage |
| ACT-18 | Subscription Provider |

## Standards Abbreviations

| Abbreviation | Meaning |
| --- | --- |
| FR | Functional Requirement |
| NFR | Non-Functional Requirement |
| UC | Use Case |
| US | User Story |
| ACT | Actor |
| ROSCA | Rotating Savings and Credit Association |
| SRS | Software Requirements Specification |
| IEEE 29148 | IEEE standard for requirements engineering (replaces IEEE 830) |
| PWA | Progressive Web Application |
| ADR | Architecture Decision Record |
| EF Core | Entity Framework Core |
| CQRS | Command Query Responsibility Segregation |
| IdP | Identity Provider |
| P&L | Profit & Loss |
| RPO / RTO | Recovery Point/Time Objective |