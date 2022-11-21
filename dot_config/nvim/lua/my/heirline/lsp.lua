local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local M = {}

local LspActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = function()
    local names = {}
    for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
      table.insert(names, server.name)
    end
    return table.concat(names, ' ')
  end,
}

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
      local sign = (vim.fn.sign_getdefined 'DiagnosticSignError')[1]
      return (sign.text .. self.errors .. ' ')
    end,
    hl = 'DiagnosticError',
  },
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined 'DiagnosticSignWarn')[1]
      return (sign.text .. self.warnings .. ' ')
    end,
    hl = 'DiagnosticWarn',
  },
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined 'DiagnosticSignInfo')[1]
      return (sign.text .. self.info .. ' ')
    end,
    hl = 'DiagnosticInfo',
  },
  {
    provider = function(self)
      local sign = (vim.fn.sign_getdefined 'DiagnosticSignHint')[1]
      return (sign.text .. self.hints)
    end,
    hl = 'DiagnosticHint',
  },
}

M.LspActive = utils.surround({ ' [', ']' }, nil, LspActive)

return M
