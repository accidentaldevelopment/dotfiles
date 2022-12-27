local cp = require('catppuccin.palettes')
-- colors = cp.get_palette()
return {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:*o', command = 'redrawstatus' })
      self.once = true
      return nil
    else
      return nil
    end
  end,
  static = {
    mode_names = {
      n = 'N',
      no = 'N?',
      nov = 'N?',
      noV = 'N?',
      ['no\22'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'Nt',
      v = 'V',
      vs = 'Vs',
      V = 'V_',
      Vs = 'Vs',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = 'I',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'C',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'T',
    },
    hlgroup = function(mode)
      local colors = cp.get_palette()

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
    return ('\238\152\171%2(' .. self.mode_names[self.mode] .. '%)')
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return self.hlgroup(mode)
  end,
  update = { 'ModeChanged' },
}
