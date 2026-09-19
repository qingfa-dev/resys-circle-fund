# API Design — Ledger, Audit, Reports, Export

## Ledger

| Method | Endpoint |
| --- | --- |
| GET | `/circles/{circleId}/ledger` |
| GET | `/members/{memberId}/ledger` |
| GET | `/circles/{circleId}/members/{memberId}/statement` |

## Audit

| Method | Endpoint |
| --- | --- |
| GET | `/circles/{circleId}/audit` |

## Reports

| Method | Endpoint |
| --- | --- |
| GET | `/circles/{circleId}/reports/summary` |
| GET | `/circles/{circleId}/reports/member-statement` |

## Export

| Method | Endpoint |
| --- | --- |
| GET | `/circles/{circleId}/reports/export.csv` |
| GET | `/circles/{circleId}/reports/export.xlsx` |