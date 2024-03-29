local wezterm = require('wezterm')
local action = wezterm.action

local search_mode = wezterm.gui.default_key_tables().search_mode

local keymaps = require('keymaps')

table.insert(search_mode, {
  key = 'c',
  mods = 'CTRL',
  action = action.Multiple({
    action.CopyMode('ClearPattern'),
    action.CopyMode('Close'),
  }),
})

local config = wezterm.config_builder()

config.initial_rows = 61
config.initial_cols = 201
config.window_decorations = 'RESIZE'
config.color_scheme = 'Catppuccin Mocha'
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true

-- config.use_fancy_tab_bar = false
config.tab_max_width = 36
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

config.term = 'wezterm'
config.window_padding = {
  left = 0,
  right = 0,
  top = '0.5cell',
  bottom = 0,
}
config.font_size = 11
-- config.line_height = 1.2
-- config.font = wezterm.font({
--   family = 'Fira Code',
--   harfbuzz_features = {
--     'zero', -- 0
--     'ss02', -- <= >=
--     'ss07', -- =~ !~
--     'cv26', -- :-
--     'ss06', -- \\
--     'zero', -- 0
--     'ss05', -- @
--     'ss03', -- &
--   },
-- })
config.font = wezterm.font({
  family = 'JetBrains Mono',
  harfbuzz_features = {
    'calt',
    'zero', -- 0
    'cv07', -- W w
    'cv12', -- u
    'cv18', -- 2 6 9
  },
})
config.mouse_bindings = {
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
}
config.disable_default_key_bindings = true
config.leader = keymaps.leader
config.keys = keymaps.keys

config.key_tables = {
  search_mode = search_mode,
}

return config
