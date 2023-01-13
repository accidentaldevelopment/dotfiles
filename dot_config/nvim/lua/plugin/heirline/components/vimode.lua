-- Mode-to-statusline table
-- Statusline indicators that can be calculated are left to the metatable below.
local mode_names = setmetatable({
  no = 'N?',
  nov = 'N?',
  noV = 'N?',
  ['no\22'] = 'N?',
  niI = 'Ni',
  niR = 'Nr',
  niV = 'Nv',
  V = 'V_',
  ['\22'] = '^V',
  ['\22s'] = '^V',
  S = 'S_',
  ['\19'] = '^S',
  Rvc = 'Rv',
  Rvx = 'Rv',
  cv = 'Ex',
  r = '...',
  rm = 'M',
  ['r?'] = '?',
}, {
  -- If the given key isn't found, return the first (or only) letter capitalized.
  __index = function(_, key)
    return (key:gsub('^%l', string.upper))
  end,
})

return {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:*o', command = 'redrawstatus' })
      self.once = true
    end
  end,
  static = {
    mode_names = mode_names,
    hlgroup = function(mode)
      return ({
        n = 'SLViModeNormal',
        i = 'SLViModeInsert',
        v = 'SLViModeVisual',
        V = 'SLViModeVisual',
        ['\22'] = 'SLViModeVisual',
        c = 'SLViModeCommand',
        s = 'SLViModeSelect',
        S = 'SLViModeSelect',
        ['\19'] = 'SLViModeSelect',
        R = 'SLViModeReplace',
        r = 'SLViModeReplace',
        ['!'] = 'SLViModeExec',
        t = 'SLViModeTerminal',
      })[mode]
    end,
  },
  provider = function(self)
    local mode = self.mode_names[self.mode]
    -- multi-char mode indicators squish up against the V logo, so add an extra space.
    if string.len(mode) == 1 then
      return ('%2(' .. self.mode_names[self.mode] .. '%)')
    else
      return (' %2(' .. self.mode_names[self.mode] .. '%)')
    end
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return self.hlgroup(mode)
  end,
  update = { 'ModeChanged' },
}
