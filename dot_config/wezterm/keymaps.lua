local w = require('wezterm')
local action = w.action

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

return {
  -- simulate tmux prefix with leader
  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },

  keys = {
    -- create split panes
    { key = '\\', mods = 'LEADER', action = w.action.SplitPane({ direction = 'Right' }) },
    { key = '-', mods = 'LEADER', action = w.action.SplitPane({ direction = 'Down' }) },
    -- new window
    { key = 'c', mods = 'LEADER', action = w.action.SpawnTab('CurrentPaneDomain') },
    { key = 'p', mods = 'LEADER', action = w.action.ActivateTabRelative(-1) },
    { key = 'n', mods = 'LEADER', action = w.action.ActivateTabRelative(1) },

    { key = '1', mods = 'SUPER', action = w.action.ActivateTab(0) },
    { key = '2', mods = 'SUPER', action = w.action.ActivateTab(1) },
    { key = '3', mods = 'SUPER', action = w.action.ActivateTab(2) },
    { key = '4', mods = 'SUPER', action = w.action.ActivateTab(3) },
    { key = '5', mods = 'SUPER', action = w.action.ActivateTab(4) },
    { key = '6', mods = 'SUPER', action = w.action.ActivateTab(5) },
    { key = '7', mods = 'SUPER', action = w.action.ActivateTab(6) },
    { key = '8', mods = 'SUPER', action = w.action.ActivateTab(7) },
    { key = '9', mods = 'SUPER', action = w.action.ActivateTab(8) },
    { key = '0', mods = 'SUPER', action = w.action.ActivateTab(9) },

    { key = '-', mods = 'SUPER', action = w.action.DecreaseFontSize },
    { key = '0', mods = 'SUPER', action = w.action.ResetFontSize },
    { key = '=', mods = 'SUPER', action = w.action.IncreaseFontSize },
    { key = 'c', mods = 'SUPER', action = w.action.CopyTo('Clipboard') },
    { key = 'v', mods = 'SUPER', action = w.action.PasteFrom('PrimarySelection') },
    { key = '[', mods = 'LEADER', action = w.action.ActivateCopyMode },
    { key = '/', mods = 'CTRL', action = action.SendString('\x1f') },
    { key = 'Enter', mods = 'SUPER', action = action.ToggleFullScreen },
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
    { key = 'w', mods = 'CMD', action = action.CloseCurrentTab({ confirm = false }) },
    { key = 'x', mods = 'CTRL|SHIFT', action = action.ActivateCopyMode },

    { key = 'p', mods = 'CMD|SHIFT', action = action.ActivateCommandPalette },
    { key = 'p', mods = 'CTRL|SHIFT', action = action.ActivateCommandPalette },
  },
}
