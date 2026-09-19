# NFR-007 — Performance

**Category:** Performance
**Applies:** I1–I5 (✓✓ I2, I5)

**Proposed baseline:**

| Operation | Target |
| --- | --- |
| Normal page/API read | ≤ 2 s |
| Normal mutation | ≤ 2 s |
| Dashboard | ≤ 3 s |
| Standard report | ≤ 5 s |
| Large export | Background job |
| Import | Background job for large files |
| AI interpretation | Application-specific timeout |

Performance requirements should be validated under a documented test load rather than against one developer machine.