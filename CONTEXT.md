# Current Work Context

This file is for picking up mid-session. Update it when switching tasks or ending a session.

---

## Last Updated
2026-04-13

## What Was Just Done

**WezTerm scratchpad setup** — configured WezTerm to behave as a quake-style dropdown terminal.

Changes made:
- `C:\Users\Michael\.config\wezterm\wezterm.lua`
  - `gui-startup` now detects the secondary monitor and maximizes there on launch
  - Added `quit_when_all_windows_are_closed = false` so WezTerm stays alive when hidden via AHK
- `C:\Users\Michael\Documents\AutoHotkey\HyperKey.ahk`
  - Hyper+Space toggle: hides when active, shows + moves to monitor 2 + maximizes when inactive

## Current State

Working, but not yet tested after the changes. The user needs to:
1. Reload WezTerm config (`Ctrl+Shift+R`) or restart WezTerm
2. Reload AHK script (right-click tray icon → Reload)

## Open Questions / Known Issues

- Monitor 2 detection in `wezterm.lua` uses geometry comparison against `screens.origin` — untested if monitor layout changes
- AHK uses `MonitorGet(2, ...)` which assumes Windows calls the secondary monitor "Monitor 2" — may need adjusting based on actual monitor ordering
- The 60% centered floating window option was deferred (see TODO.md)

## Next Up

See `TODO.md`.
