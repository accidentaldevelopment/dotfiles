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
          ---@param c lsp.Client
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
    local counts = vim.diagnostic.count(0)

    self.errors = counts[vim.diagnostic.severity.ERROR] or 0
    self.warnings = counts[vim.diagnostic.severity.WARN] or 0
    self.hints = counts[vim.diagnostic.severity.HINT] or 0
    self.info = counts[vim.diagnostic.severity.INFO] or 0
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
