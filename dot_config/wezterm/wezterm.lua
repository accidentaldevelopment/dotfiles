local wezterm = require('wezterm')
local action = wezterm.action

local search_mode = wezterm.gui.default_key_tables().search_mode

table.insert(search_mode, {
  key = 'c',
  mods = 'CTRL',
  action = action.Multiple({
    action.CopyMode('ClearPattern'),
    action.CopyMode('Close'),
  }),
})

return {
  initial_rows = 61,
  initial_cols = 201,
  window_decorations = 'RESIZE',
  color_scheme = 'Catppuccin Mocha',
  enable_tab_bar = false,
  term = 'wezterm',
  window_padding = {
    left = 0,
    right = 0,
    top = '0.5cell',
    bottom = 0,
  },
  font_size = 11,
  font = wezterm.font({
    family = 'Fira Code',
    harfbuzz_features = {
      'ss02',
      'ss07',
      'cv26',
      'ss06',
      'zero',
      'ss05',
      'ss03',
    },
  }),
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      action = action.DisableDefaultAssignment,
    },
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = action.OpenLinkAtMouseCursor,
    },
    {
      event = { Drag = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = action.StartWindowDrag,
    },
    {
      event = { Drag = { streak = 1, button = 'Left' } },
      mods = 'SHIFT|CMD',
      action = action.StartWindowDrag,
    },
  },
  disable_default_key_bindings = true,
  keys = {
    { key = '/', mods = 'CTRL', action = action.SendString('\x1f') },
    { key = '-', mods = 'SUPER', action = action.DecreaseFontSize },
    { key = '0', mods = 'SUPER', action = action.ResetFontSize },
    { key = '=', mods = 'SUPER', action = action.IncreaseFontSize },
    { key = 'Enter', mods = 'SUPER', action = action.ToggleFullScreen },
    { key = 'c', mods = 'SUPER', action = action.CopyTo('Clipboard') },
    { key = 'f', mods = 'CMD', action = action.Search({ CaseInSensitiveString = '' }) },
    { key = 'h', mods = 'CMD', action = action.HideApplication },
    {
      key = 'k',
      mods = 'SUPER',
      action = action.Multiple({
        action.SendKey({ key = 'L', mods = 'CTRL' }),
        action.ClearScrollback('ScrollbackOnly'),
      }),
    },
    { key = 'l', mods = 'CMD|SHIFT', action = action.ShowDebugOverlay },
    { key = 'm', mods = 'CMD', action = action.Hide },
    { key = 'n', mods = 'SUPER', action = action.SpawnWindow },
    { key = 'q', mods = 'CMD', action = action.QuitApplication },
    { key = 'v', mods = 'SUPER', action = action.PasteFrom('PrimarySelection') },
    { key = 'w', mods = 'CMD', action = action.CloseCurrentTab({ confirm = false }) },
    { key = 'x', mods = 'CTRL|SHIFT', action = action.ActivateCopyMode },
  },
  key_tables = {
    search_mode = search_mode,
  },
}
