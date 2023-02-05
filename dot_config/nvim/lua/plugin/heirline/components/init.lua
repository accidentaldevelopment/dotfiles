local navic = require('nvim-navic')
local file = require('plugin.heirline.components.file')
local lsp = require('plugin.heirline.components.lsp')

local M = {}

M.ViMode = require('plugin.heirline.components.vimode')
M.Git = require('plugin.heirline.components.git')

M.FileIcon = file.FileIcon
M.FileName = file.FileName
M.FileType = file.FileType
M.FileFlags = file.FileFlags
M.HelpFileName = file.HelpFileName
M.LspActive = lsp.LspActive
M.Diagnostics = lsp.Diagnostics
M.Format = lsp.Format

--- LSP-derived breadcrumbs
M.Navic = {
  condition = function()
    return navic.is_available()
  end,
  provider = function()
    return navic.get_location({ highlight = true })
  end,
  update = { 'CursorMoved' },
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

M.LazyStats = {
  init = function(self)
    local stats = require('lazy').stats()
    self.count = stats.count
    self.loaded = stats.loaded
  end,
  provider = function(self)
    return self.loaded .. '/' .. self.count
  end,
}

M.LazyUpdates = {
  condition = require('lazy.status').has_updates,
  provider = function()
    return require('lazy.status').updates()
  end,
}

M.Space = { provider = ' ' }

M.Align = { provider = '%=' }

return M
