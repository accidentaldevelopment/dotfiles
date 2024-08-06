local function setup_colors()
  local C = require('plugin.heirline.colors')

  local d_err = require('heirline.utils').get_highlight('DiagnosticError')
  local d_warn = require('heirline.utils').get_highlight('DiagnosticWarn')
  local d_info = require('heirline.utils').get_highlight('DiagnosticInfo')
  local d_hint = require('heirline.utils').get_highlight('DiagnosticHint')
  local palette = require('catppuccin.palettes').get_palette()

  return {
    [C.lsp.fg] = palette.text,
    [C.lsp.bg] = palette.surface1,

    [C.lsp_name.fg] = palette.surface0,
    [C.lsp_name.bg] = palette.lavender,

    [C.diag.err.fg] = d_err.fg,
    [C.diag.err.bg] = d_err.bg,
    [C.diag.warn.fg] = d_warn.fg,
    [C.diag.warn.bg] = d_warn.bg,
    [C.diag.info.fg] = d_info.fg,
    [C.diag.info.bg] = d_info.bg,
    [C.diag.hint.fg] = d_hint.fg,
    [C.diag.hint.bg] = d_hint.bg,
  }
end

return {
  'rebelot/heirline.nvim',
  dependencies = {
    'mini.icons',
  },
  lazy = false,
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
      c.RecordingMacro,
      c.Space,
      c.Grapple,

      c.Align,

      c.Diagnostics,
      c.Space,
      c.Format,

      c.Align,

      c.Space,
      c.LazyInfo,
      c.Space,
      c.Git,
      c.Space,
      -- c.Ruler,
      c.Indent,
      c.Space,
      c.ScrollBar,
    }

    local DefaultWinbar = {
      c.Space,
      c.ShortFileName,
      c.Space,
      c.FileFlags,
      c.Space,
      c.Navic,
    }

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
      -- tabline = require('plugin.heirline.bufferline'),
      -- statuscolumn = statuscolumn,
      opts = {
        colors = setup_colors,
        disable_winbar_cb = function(args)
          local buf = args.buf
          local buftype = vim.tbl_contains({ 'prompt', 'nofile', 'help', 'quickfix' }, vim.bo[buf].buftype)
          local filetype = vim.tbl_contains({ 'gitcommit', 'fugitive', 'minifiles' }, vim.bo[buf].filetype)
          return buftype or filetype
        end,
      },
    })

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('Heirline', { clear = true }),
      callback = function()
        return utils.on_colorscheme(setup_colors)
      end,
    })
  end,
}
