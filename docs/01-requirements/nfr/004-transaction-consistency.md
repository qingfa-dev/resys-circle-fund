# NFR-004 — Transaction Consistency

**Category:** Transaction Consistency
**Applies:** Critical I1/I2; Important I3–I5

**Statement:** Critical financial mutations shall be atomic.

**Example:**

```text
Record Payment
    ├── Contribution
    ├── Balance effect
    ├── Ledger
    └── Audit
```

Either the required transaction succeeds as a unit or the operation fails without leaving an incomplete financial state.