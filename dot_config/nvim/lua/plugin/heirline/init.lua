return {
  'rebelot/heirline.nvim',
  dependencies = 'SmiteshP/nvim-navic',
  event = 'BufReadPre',
  config = function()
    local colors = require('catppuccin.palettes').get_palette()
    local utils = require 'heirline.utils'
    local conditions = require 'heirline.conditions'

    local Ruler = { provider = '%7(%l/%3L%):%2c %P' }

    local ScrollBar = {
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
        local curr_line = vim.fn.line '.'
        local lines = vim.fn.line '$'
        local line_ratio = (curr_line / lines)
        local index = math.ceil((line_ratio * #self.sbar))
        return string.rep(self.sbar[index], 2)
      end,
      hl = 'SLScrollBar',
    }

    local LazyStats = {
      init = function(self)
        local stats = require('lazy').stats()
        self.count = stats.count
        self.loaded = stats.loaded
      end,
      provider = function(self)
        return self.loaded .. '/' .. self.count
      end,
    }

    local LazyUpdates = {
      condition = require('lazy.status').has_updates,
      provider = function()
        return require('lazy.status').updates()
      end,
    }

    local space = { provider = ' ' }
    local align = { provider = '%=' }
    local vi_mode = require 'plugin.heirline.vimode'
    local navic = require 'plugin.heirline.navic'
    local file = require 'plugin.heirline.file'
    local lsp = require 'plugin.heirline.lsp'
    local git = require 'plugin.heirline.git'

    local DefaultStatusLine = {
      vi_mode,
      space,
      file.FileName,
      file.FileFlags,
      space,
      space,
      lsp.LspActive,
      space,
      lsp.Diagnostics,
      align,
      LazyStats,
      LazyUpdates,
      space,
      git,
      space,
      Ruler,
      space,
      ScrollBar,
    }
    local DefaultWinbar = { navic }

    local special_status_line
    local function _26_()
      return conditions.buffer_matches { buftype = { 'nofile', 'prompt', 'help', 'quickfix' }, filetype = { '^git.*' } }
    end
    special_status_line = utils.insert({ condition = _26_ }, file.FileType, space, file.HelpFileName, align)
    local status_lines
    local function _27_()
      if conditions.is_active() then
        return 'StatusLine'
      else
        return 'StatusLineNC'
      end
    end
    status_lines = utils.insert({ hl = _27_, fallthrough = false }, special_status_line, DefaultStatusLine)
    do
      local h = require 'heirline'
      h.setup(status_lines, DefaultWinbar, require 'plugin.heirline.bufferline')
    end
    local group = vim.api.nvim_create_augroup('Heirline', { clear = true })
    local function _29_()
      return utils.on_colorscheme()
    end
    vim.api.nvim_create_autocmd('ColorScheme', { callback = _29_, group = group })
  end,
}
