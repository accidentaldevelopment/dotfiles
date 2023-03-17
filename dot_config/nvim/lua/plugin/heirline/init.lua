return {
  'rebelot/heirline.nvim',
  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function()
    local utils = require('heirline.utils')
    local conditions = require('heirline.conditions')
    local c = require('plugin.heirline.components')

    local DefaultStatusLine = {
      c.ViMode,
      c.Space,
      c.FileName,
      c.FileFlags,
      c.Align,
      c.LspActive,
      c.Space,
      c.Diagnostics,
      c.Space,
      c.Format,
      c.Align,
      c.LazyInfo,
      c.Space,
      c.Git,
      c.Space,
      c.Ruler,
      c.Space,
      c.ScrollBar,
    }

    local DefaultWinbar = { c.Navic }

    local SpecialStatusLine = utils.insert({
      condition = function()
        return conditions.buffer_matches({
          buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
          filetype = { '^git.*' },
        })
      end,
    }, c.FileType, c.Space, c.HelpFileName, c.Align)

    local StatusLines = utils.insert({
      hl = function()
        if conditions.is_active() then
          return 'StatusLine'
        else
          return 'StatusLineNC'
        end
      end,
      fallthrough = false,
    }, SpecialStatusLine, DefaultStatusLine)

    require('heirline').setup({
      statusline = StatusLines,
      winbar = DefaultWinbar,
      tabline = require('plugin.heirline.bufferline'),
    })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('Heirline', { clear = true }),
      callback = function()
        return utils.on_colorscheme({})
      end,
    })
  end,
}
