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
config.color_scheme = 'Catppuccin Mocha'
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true

config.tab_max_width = 36
config.tab_bar_at_bottom = true

config.term = 'wezterm'
config.window_padding = {
  left = 0,
  right = 0,
  top = '0.5cell',
  bottom = 0,
}

config.font_size = 11

-- config.font = wezterm.font({
--   family = 'Iosevka Term',
--   harfbuzz_features = {
--     'calt=0',
--     'CLIK=1',
--   },
-- })

do
  local features = { 'ss01', 'ss03', 'ss06', 'ss07' }

  config.font = wezterm.font({
    family = 'Victor Mono',
    harfbuzz_features = features,
  })

  config.font_rules = {
    {
      italic = true,
      font = wezterm.font({
        family = 'Victor Mono',
        style = 'Oblique',
        harfbuzz_features = features,
      }),
    },
  }
end

config.default_prog = { '/opt/homebrew/bin/nu', '-l' }

config.set_environment_variables = {
  XDG_CONFIG_HOME = wezterm.home_dir .. '/.config',
  XDG_STATE_HOME = wezterm.home_dir .. '/.local/state',
  XDG_DATA_HOME = wezterm.home_dir .. '/.local/share',
}

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

wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim').apply_to_config(config, {
  modifiers = {
    move = 'LEADER',
  },
})

return config
