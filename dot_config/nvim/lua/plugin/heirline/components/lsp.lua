local conditions = require('heirline.conditions')

local M = {}

---@class LspActive
---@field ft string The filetype for the current buffer

--- Lists attached language server processes.
M.LspActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach', 'BufEnter' },
  {
    { provider = ' [' },
    {
      ---@param self LspActive
      init = function(self)
        self.ft = vim.o.filetype
      end,
      ---@param self LspActive
      provider = function(self)
        return vim
          .iter(vim.lsp.get_clients({ bufnr = 0 }))
          ---@param c vim.lsp.Client
          :map(function(c)
            local name = c.name
            if name == 'null-ls' then
              return vim.iter.map(function(_, s)
                return s.name
              end, pairs(require('null-ls').get_source({ filetype = self.ft })))
            end
            return name
          end)
          :flatten()
          :join(' ')
      end,
    },
    { provider = ']' },
  },
}

---@class Format
---@field formatters? conform.FormatterInfo[]
---@field lsp_fallback? boolean
M.Format = {
  ---@param self Format
  condition = function(self)
    local conform = require('conform')
    local formatters = conform.list_formatters()
    if formatters[1] ~= nil then
      self.formatters = formatters
      return true
    elseif conform.will_fallback_lsp() then
      self.lsp_fallback = true
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

--- Diagnostic stats for all attached language servers.
M.Diagnostics = {
  condition = conditions.lsp_attached,
  update = { 'DiagnosticChanged', 'BufEnter' },
  static = {
    signs = vim.diagnostic.config().signs.text,
  },
  init = function(self)
    local counts = vim.diagnostic.count(0)

    self.errors = counts[vim.diagnostic.severity.ERROR] or 0
    self.warnings = counts[vim.diagnostic.severity.WARN] or 0
    self.hints = counts[vim.diagnostic.severity.HINT] or 0
    self.info = counts[vim.diagnostic.severity.INFO] or 0
    return nil
  end,
  {
    provider = function(self)
      local sign = self.signs[vim.diagnostic.severity.ERROR]
      return string.format('%s %d ', sign, self.errors)
    end,
    hl = 'DiagnosticError',
  },
  {
    provider = function(self)
      local sign = self.signs[vim.diagnostic.severity.WARN]
      return string.format('%s %d ', sign, self.warnings)
    end,
    hl = 'DiagnosticWarn',
  },
  {
    provider = function(self)
      local sign = self.signs[vim.diagnostic.severity.INFO]
      return string.format('%s %d ', sign, self.info)
    end,
    hl = 'DiagnosticInfo',
  },
  {
    provider = function(self)
      local sign = self.signs[vim.diagnostic.severity.HINT]
      return string.format('%s %d', sign, self.hints)
    end,
    hl = 'DiagnosticHint',
  },
}

return M
