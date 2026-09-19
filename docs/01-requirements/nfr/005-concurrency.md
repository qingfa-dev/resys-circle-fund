# NFR-005 — Concurrency

**Category:** Concurrency
**Applies:** Critical I1/I2; Important I3–I5

**Statement:** The system shall protect against concurrent updates.

**Examples:** two users record the same payment; two users record a winner; two requests create the same transaction; two administrators modify the same resource.

**Acceptance baseline:** no duplicate transaction, no lost update, no negative/inconsistent balance caused by race conditions.