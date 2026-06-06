
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- -------------------------------------------------------
-- CRITICAL: Kitty keyboard protocol
-- -------------------------------------------------------
config.enable_kitty_keyboard = true
config.allow_win32_input_mode = false

-- Keep WezTerm alive when all windows are hidden (needed for hide/show toggle)
config.quit_when_all_windows_are_closed = false

-- -------------------------------------------------------
-- Default shell (Ubuntu WSL)
-- -------------------------------------------------------
config.default_prog = { 'wsl.exe', '-d', 'Ubuntu', '--cd', '~' }

-- -------------------------------------------------------
-- Launch menu (right-click new tab or keybind)
-- -------------------------------------------------------
config.launch_menu = {
  { label = 'Ubuntu (WSL)',  args = { 'wsl.exe', '-d', 'Ubuntu', '--cd', '~' } },
  { label = 'PowerShell',    args = { 'powershell.exe' } },
  { label = 'CMD',           args = { 'cmd.exe' } },
}

-- -------------------------------------------------------
-- Appearance
-- -------------------------------------------------------
config.color_scheme = 'OneHalfDark'
config.font = wezterm.font('Monaspace Neon Frozen')
config.font_size = 12.0
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.tab_max_width = 32

-- -------------------------------------------------------
-- Keybindings
-- -------------------------------------------------------
config.keys = {
  -- New tab with shell picker
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncherArgs { flags =
'LAUNCH_MENU_ITEMS' } },
  -- New tab (default shell)
  { key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain'
},
  -- Close tab
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm =
false } },
  -- Switch tabs
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(1) },
  -- Line navigation (Mac Cmd+Arrow equivalents, since AHK excludes WezTerm)
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.SendString('\x01') },  -- Ctrl+A: start of line
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.SendString('\x05') },  -- Ctrl+E: end of line
  { key = 'Backspace',  mods = 'ALT', action = wezterm.action.SendString('\x15') },  -- Ctrl+U: delete to start of line
  { key = 'Delete',     mods = 'ALT', action = wezterm.action.SendString('\x0b') },  -- Ctrl+K: delete to end of line
  -- Pass Ctrl+L through to shell (clear screen); move debug overlay to Ctrl+Shift+L
  { key = 'l', mods = 'CTRL',       action = wezterm.action.SendKey { key = 'l', mods = 'CTRL' } },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ShowDebugOverlay },
}

return config