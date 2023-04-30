local w = require('wezterm')
local action = w.action

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function is_vim(pane)
  local process_name = basename(pane:get_foreground_process_name())
  return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = w.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

return {
  -- simulate tmux prefix with leader
  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },

  keys = {
    -- create split panes
    { key = '\\', mods = 'LEADER', action = w.action.SplitPane({ direction = 'Right' }) },
    { key = '-', mods = 'LEADER', action = w.action.SplitPane({ direction = 'Down' }) },
    -- move between split panes
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    -- resize panes
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),
    -- new window
    { key = 'c', mods = 'LEADER', action = w.action.SpawnTab('CurrentPaneDomain') },
    { key = 'p', mods = 'LEADER', action = w.action.ActivateTabRelative(-1) },
    { key = 'n', mods = 'LEADER', action = w.action.ActivateTabRelative(1) },

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
  },
}
