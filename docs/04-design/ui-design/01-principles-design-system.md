# UI Design — Principles & Design System

## Principles
1. Clarity over complexity. 2. Financial confidence (confirm + reversible). 3. Progressive disclosure. 4. Accessibility (WCAG 2.1 AA). 5. Responsive. 6. Consistent.

## Color Tokens

| Token | Value (illustrative) | Usage |
| --- | --- | --- |
| `--c-primary` | #1f6feb | brand, links, active |
| `--c-success` | #198754 | paid/completed, credits |
| `--c-warning` | #d97706 | pending, overdue |
| `--c-danger` | #dc2626 | errors, debits, destructive |
| `--c-neutral-*` | gray scale | backgrounds, borders, text |

Financial amounts also carry ± icon (not color-only) for accessibility.

## Typography

| Scale | Weight | Usage |
| --- | --- | --- |
| Display/H1 | 600 | page titles |
| H2–H6 | 600 | section headings |
| Body | 400 | text (line-height 1.5+) |
| Mono | 400/500 | amounts, IDs, references |

## Spacing & Shape
- Base spacing unit 4px (4/8/12/16/24/32/48).
- Border-radius: 4px (cards/inputs), 8px (modals).
- Financial amount: monospace, tabular figures, `1,234,567.89 VND`.

## Layout
- Desktop: sidebar (240px) + content (fluid, max 1280px).
- Tablet: collapsible sidebar.
- Mobile: bottom nav + full-screen content.