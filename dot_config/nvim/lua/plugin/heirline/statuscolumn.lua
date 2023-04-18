local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local M = {}

M.LspDiagIcon = {
  {
    condition = function()
      return not conditions.lsp_attached or #vim.diagnostic.get(0) == 0
    end,
    provider = ' ',
  },
  {
    condition = function()
      return conditions.lsp_attached or #vim.diagnostic.get(0) > 0
    end,
    static = {
      lsp = {
        DiagnosticSignHint = vim.fn.sign_getdefined('DiagnosticSignHint')[1],
        DiagnosticSignInfo = vim.fn.sign_getdefined('DiagnosticSignInfo')[1],
        DiagnosticSignWarn = vim.fn.sign_getdefined('DiagnosticSignWarn')[1],
        DiagnosticSignError = vim.fn.sign_getdefined('DiagnosticSignError')[1],
      },
    },
    init = function(self)
      self.sign = nil
      self.has_sign = false
      local buf = vim.api.nvim_get_current_buf()
      local signs = vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1]
      if signs.signs[1] ~= nil and vim.startswith(signs.signs[1].group, 'vim.diagnostic') then
        self.has_sign = true
        self.sign = signs.signs[1]
      end
    end,
    -- XXX: This throws an error, even though it works in other components.
    -- update = 'DiagnosticChanged'
    provider = function(self)
      if self.has_sign then
        return self.lsp[self.sign.name].text
      end
    end,
    hl = function(self)
      if self.has_sign then
        return self.sign.name
      end
    end,
  },
}

local GitHighlight = {
  init = function(self)
    if conditions.is_git_repo() then
      self.sign = nil
      self.has_sign = false
      local buf = vim.api.nvim_get_current_buf()
      local signs = vim.fn.sign_getplaced(buf, { group = 'gitsigns_vimfn_signs_', lnum = vim.v.lnum })[1]
      if signs.signs[1] ~= nil and signs.signs and signs.signs[1] then
        self.has_sign = true
        self.sign = signs.signs[1]
        self.hlgroup = self.sign.name
      end
    end
  end,
  hl = function(self)
    if self.has_sign then
      return self.hlgroup
    end
  end,
}

M.GitIndicator = utils.insert(GitHighlight, {
  condition = conditions.is_git_repo,
  provider = ' ▏',
})

M.LineNo = utils.insert(GitHighlight, {
  provider = '%3{v:relnum?v:relnum:v:lnum}',
})

return M
