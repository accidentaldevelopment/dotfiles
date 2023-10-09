local conditions = require('heirline.conditions')

local M = {}

---@class LspActive
---@field bufnr number The current buffer number
---@field ft string The filetype for the current buffer

--- Lists attached language server processes.
M.LspActive = {
  condition = function(self)
    return require('util').lang_tools.has_any(self.bufnr)
  end,
  update = { 'LspAttach', 'LspDetach', 'BufEnter' },
  {
    { provider = ' [' },
    {
      ---@param self LspActive
      init = function(self)
        self.bufnr = vim.api.nvim_get_current_buf()
        self.ft = vim.bo[self.bufnr].filetype
      end,
      ---@param self LspActive
      provider = function(self)
        return table.concat(require('util').lang_tools.get(self.bufnr), ' ')
      end,
    },
    { provider = ']' },
  },
}

M.Format = {
  condition = conditions.lsp_attached,
  update = { 'User', pattern = 'FormatOnSave' },
  provider = '󰬍',
  hl = function()
    if require('plugin.lsp.formatting').format_on_save() then
      return 'SLOptionEnabled'
    else
      return 'SLOptionDisabled'
    end
  end,
}

--- Diagnostic stats for all attached language servers.
M.Diagnostics = {
  condition = conditions.lsp_attached,
  update = { 'DiagnosticChanged', 'BufEnter' },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    return nil
  end,
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined('DiagnosticSignError'))[1]
      return (sign.text .. self.errors .. ' ')
    end,
    hl = 'DiagnosticError',
  },
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined('DiagnosticSignWarn'))[1]
      return (sign.text .. self.warnings .. ' ')
    end,
    hl = 'DiagnosticWarn',
  },
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined('DiagnosticSignInfo'))[1]
      return (sign.text .. self.info .. ' ')
    end,
    hl = 'DiagnosticInfo',
  },
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined('DiagnosticSignHint'))[1]
      return (sign.text .. self.hints)
    end,
    hl = 'DiagnosticHint',
  },
}

return M
