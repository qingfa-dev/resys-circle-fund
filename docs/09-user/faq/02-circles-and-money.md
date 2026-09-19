# FAQ — Circles, Money & Payouts

**Index:** `docs/09-user/faq.md`

**What is a Savings Circle?** One running ROSCA group with its own members, schedule, and rules.

**What is a Round?** One cycle where every member contributes and one receives the payout.

**What is a Share?** A contribution unit; a member may hold several.

**Association Types?** No-Interest Rotation, Fixed Interest, Bidding.

**How do I record a contribution?** Open circle → Record Contribution → member/round/share/amount/date/method → Confirm.

**How are duplicates prevented?** Each operation carries a unique idempotency key; retries don't duplicate.

**How are balances calculated?** Always derived from the ledger.

**How are mistakes corrected?** Via compensating (reversal + correction) entries; the original is preserved.

**What does "pending sync" mean?** A record captured offline awaiting the server; excluded from authoritative totals until synced (FR-I2-049).

**What happens on a sync conflict?** Both versions are shown; nothing is discarded silently.

**What is a Payout Draw?** A member receiving the pooled funds for a round.

**How does Bidding work?** Members bid; the configured rule selects the winner.