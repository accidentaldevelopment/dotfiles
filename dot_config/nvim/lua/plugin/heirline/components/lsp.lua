local conditions = require('heirline.conditions')

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
---@field formatters? conform.FormatterInfo[]
---@field lsp_fallback? boolean
M.Format = {
  ---@param self Format
  condition = function(self)
    -- next two lines are some annoyance to get LazyDev to know conform types.
    if package.loaded.conform then
      local conform = require('conform')

      -- TODO: figure out why `lsp_fallback` doesn't work
      local formatters, lsp_fallback = conform.list_formatters()
      self.formatters = formatters
      self.lsp_fallback = lsp_fallback
      return true
    end
    return false
  end,
  update = { 'User', pattern = 'FormatOnSave' },

  { provider = '𝑓(' },
  {
    ---@param self Format
    provider = function(self)
      if self.lsp_fallback then
        return 'lsp'
      else
        return vim
          .iter(ipairs(self.formatters))
          :map(function(_, f)
            return f.name
          end)
          :join(' ')
      end
    end,
  },
  { provider = ')' },

  hl = function()
    if require('formatting').format_on_save() then
      return 'SLFormattingEnabled'
    else
      return 'SLFormattingDisabled'
    end
  end,
}

return M
