local conditions = require('heirline.conditions')
local colors = require('plugin.heirline.colors')

local C = require('plugin.heirline.colors')

local M = {}

local L = ''
local R = ''

M.Diagnostics = {
  static = {
    signs = vim.diagnostic.config().signs.text,
  },
  condition = conditions.lsp_attached,
  update = { 'DiagnosticChanged', 'BufEnter' },
  init = function(self)
    local counts = vim.diagnostic.count(0)

    self.errors = counts[vim.diagnostic.severity.ERROR] or 0
    self.warnings = counts[vim.diagnostic.severity.WARN] or 0
    self.hints = counts[vim.diagnostic.severity.HINT] or 0
    self.info = counts[vim.diagnostic.severity.INFO] or 0
    return nil
  end,
  hl = { bg = C.lsp.bg },

  {
    provider = L,
    hl = { fg = C.lsp_name.bg, bg = '' },
  },
  {
    provider = '  ',
    update = { 'LspAttach', 'LspDetach', 'LspNotify' },
    hl = { fg = C.lsp_name.fg, bg = C.lsp_name.bg, bold = true },
    {
      provider = function()
        return vim
          .iter(vim.lsp.get_clients({ bufnr = 0 }))
          ---@param c vim.lsp.Client
          :map(function(c)
            return c.name
          end)
          :join(' ')
      end,
    },
    { provider = ' ' },
  },
  {
    provider = L,
    hl = { fg = C.lsp.bg, bg = C.lsp_name.bg },
  },
  {
    provider = function(self)
      return string.format('%s %d', self.signs[vim.diagnostic.severity.ERROR], self.errors)
    end,
    hl = { fg = C.diag.err.fg },
  },
  { provider = ' ' },
  {
    provider = function(self)
      return string.format('%s %d', self.signs[vim.diagnostic.severity.WARN], self.warnings)
    end,
    hl = { fg = C.diag.warn.fg },
  },
  { provider = ' ' },
  {
    provider = function(self)
      return string.format('%s %d', self.signs[vim.diagnostic.severity.INFO], self.info)
    end,
    hl = { fg = C.diag.info.fg },
  },
  { provider = ' ' },
  {
    provider = function(self)
      return string.format('%s %d', self.signs[vim.diagnostic.severity.HINT], self.hints)
    end,
    hl = { fg = C.diag.hint.fg },
  },
  {
    provider = R,
    hl = { fg = C.lsp.bg, bg = '' },
  },
}

---@class Format
---@field formatters_names string
---@field enabled boolean

local FormattingEnabled = {
  hl = 'SLFormattingEnabled',
  {
    provider = ' 󰔡  ',
    hl = { fg = colors.formating_toggle_on },
  },
  {
    ---@param self Format
    provider = function(self)
      return self.formatters_names
    end,
  },
}

local FormattingDisabled = {
  hl = 'SLFormattingDisabled',
  {
    provider = ' 󰔢  ',
    hl = { fg = colors.formating_toggle_off },
  },
  {
    ---@param self Format
    provider = function(self)
      return self.formatters_names
    end,
  },
}

-- TODO: This whole thing is pretty pug fugly. There must be a better way!
M.Format = {
  condition = function()
    return package.loaded.conform ~= nil
  end,
  {
    ---@param self Format
    init = function(self)
      self.formatters_names = table.concat(require('formatting').get_formatters_for_buffer(), '  ')
      self.enabled = require('formatting').format_on_save()
    end,

    {
      fallthrough = false,
      {
        ---@param self Format
        condition = function(self)
          return self.enabled
        end,
        FormattingEnabled,
      },

      FormattingDisabled,
    },
  },
}

return M
