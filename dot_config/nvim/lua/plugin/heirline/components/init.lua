local file = require('plugin.heirline.components.file')
local lsp = require('plugin.heirline.components.lsp')

local M = {}

M.ViMode = require('plugin.heirline.components.vimode')
M.Git = require('plugin.heirline.components.git')

M.FileIcon = file.FileIcon
M.FileName = file.FileName
M.FileType = file.FileType
M.FileFlags = file.FileFlags
M.Grapple = file.Grapple
M.Spell = file.Spell
M.Indent = file.Indent
M.HelpFileName = file.HelpFileName
M.Diagnostics = lsp.Diagnostics
M.Format = lsp.Format
M.Thing = lsp.Thing

--- LSP-derived breadcrumbs
M.Navic = {
  condition = function()
    return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
  end,
  provider = function()
    return require('nvim-navic').get_location({ highlight = true })
  end,
  update = 'CursorMoved',
}

M.Ruler = { provider = '%7(%l/%3L%):%2c %3p%%' }

M.ScrollBar = {
  static = {
    sbar = {
      '▁',
      '▂',
      '▃',
      '▄',
      '▅',
      '▆',
      '▇',
      '█',
    },
  },
  provider = function(self)
    local curr_line = vim.fn.line('.')
    local lines = vim.fn.line('$')
    local line_ratio = (curr_line / lines)
    local index = math.ceil((line_ratio * #self.sbar))
    return string.rep(self.sbar[index], 2)
  end,
  hl = 'SLScrollBar',
}

M.RecordingMacro = {
  update = { 'RecordingEnter', 'RecordingLeave' },
  fallthrough = false,
  init = function(self)
    self.reg = vim.fn.reg_recording()
  end,
  {
    condition = function(self)
      return self.reg ~= ''
    end,
    provider = function(self)
      return string.format(' %s', self.reg)
    end,
  },
  {
    provider = '   ',
  },
}

LazyStats = {
  init = function(self)
    local stats = require('lazy').stats()
    self.count = stats.count
    self.loaded = stats.loaded
  end,
  provider = function(self)
    return ' ' .. self.loaded .. '/' .. self.count
  end,
}

LazyUpdates = {
  condition = require('lazy.status').has_updates,
  provider = function()
    return '(' .. require('lazy.status').updates():sub(5) .. ')'
  end,
}

M.Space = { provider = ' ' }

M.LazyInfo = {
  flexible = 1,
  { LazyStats, LazyUpdates },
  { provider = '' },
}

M.Align = { provider = '%=' }

return M
