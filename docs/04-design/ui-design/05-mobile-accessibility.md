# UI Design — Mobile & Accessibility

## Mobile Patterns
- Touch targets ≥ 44×44px.
- Swipe gestures for list actions (archive/delete) with undo.
- Bottom-sheet modals for selection (member, round, method).
- Pull-to-refresh on lists.
- Dedicated number pad for amount inputs.
- Camera receipt capture (progressive, I3 file storage).

## Accessibility (WCAG 2.1 AA)

| Area | Requirement |
| --- | --- |
| Images | alt text |
| Interactive | ARIA labels/roles |
| Keyboard | full navigation, visible focus |
| Contrast | ≥ 4.5:1 body, ≥ 3:1 large |
| Screen reader | tested on key flows |
| Motion | respect `prefers-reduced-motion` |
| Text | resizable, no fixed px heights |

## Internationalization (NFR-016/017)
Vietnamese primary; date/number/currency formatting; timezone-configured; status labels via localization resources (not hard-coded.