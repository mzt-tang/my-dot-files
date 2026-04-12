# Current Work Context

This file is for picking up mid-session. Update it when switching tasks or ending a session.

---

## Last Updated
2026-04-13

## What Was Just Done

**WezTerm + Zellij config session** — quake-style dropdown terminal, tab tweaks, keybind fixes.

### Changes made

**`C:\Users\Michael\.config\wezterm\wezterm.lua`**
- `gui-startup` detects secondary monitor and maximizes there on launch
- Added `quit_when_all_windows_are_closed = false` so WezTerm stays alive when hidden via AHK
- Tab "terminal" renamed to "dev"
- `tab_max_width = 32` (default was 16)

**`C:\Users\Michael\Documents\AutoHotkey\HyperKey.ahk`**
- Hyper+Space toggle: hides when active; shows + moves to monitor 2 + maximizes when inactive

**`~/.config/zellij/config.kdl`**
- Pane mode rebound from `Ctrl+P` to `Ctrl+W` (freed up `Ctrl+P` for WezTerm's command palette)

## Current State

**Not yet tested** — all changes made but PC not restarted. Need to verify:
1. WezTerm opens fullscreen on monitor 2 at startup
2. Hyper+Space hides/shows correctly (no longer closes WezTerm process)
3. Hyper+Space restore shows fullscreen on monitor 2
4. Zellij starts at correct size (should be fixed since window is now maximized before zellij spawns)
5. `Ctrl+W` enters zellij pane mode
6. `Ctrl+P` opens WezTerm command palette

## Open Questions / Known Issues

- Monitor 2 detection in `wezterm.lua` uses geometry comparison against `screens.origin` — untested if monitor layout changes
- AHK uses `MonitorGet(2, ...)` which assumes Windows labels the secondary monitor as "Monitor 2" — may need adjusting
- 60% centered floating window option was deferred (see TODO.md)

## Next Up

See `TODO.md`.
