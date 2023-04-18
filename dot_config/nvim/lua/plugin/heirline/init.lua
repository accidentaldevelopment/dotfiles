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
      c.Space,
      c.FileFlags,
      c.Space,
      c.Spell,
      c.Space,

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
      -- c.Ruler,
      c.Indent,
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

    local sc = require('plugin.heirline.statuscolumn')
    local statuscolumn = {
      -- sc.LspDiagIcon,
      sc.SignColumn,
      c.Align,
      sc.LineNo,
      -- sc.GitIndicator,
      c.Space,
    }

    require('heirline').setup({
      statusline = StatusLines,
      winbar = DefaultWinbar,
      tabline = require('plugin.heirline.bufferline'),
      statuscolumn = statuscolumn,
      opts = {
        disable_winbar_cb = function(args)
          local buf = args.buf
          local buftype = vim.tbl_contains({ 'prompt', 'nofile', 'help', 'quickfix' }, vim.bo[buf].buftype)
          local filetype = vim.tbl_contains({ 'gitcommit', 'fugitive', 'Trouble', 'packer' }, vim.bo[buf].filetype)
          return buftype or filetype
        end,
      },
    })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('Heirline', { clear = true }),
      callback = function()
        return utils.on_colorscheme({})
      end,
    })
  end,
}
