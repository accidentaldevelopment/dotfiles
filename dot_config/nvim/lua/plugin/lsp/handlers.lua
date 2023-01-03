local M = {}

M.setup = function()
  vim.fn.sign_define({
    { name = 'DiagnosticSignError', text = '', texthl = 'DiagnosticSignError', numhl = '' },
    { name = 'DiagnosticSignWarn', text = '', texthl = 'DiagnosticSignWarn', numhl = '' },
    { name = 'DiagnosticSignHint', text = '', texthl = 'DiagnosticSignHint', numhl = '' },
    { name = 'DiagnosticSignInfo', text = '', texthl = 'DiagnosticSignInfo', numhl = '' },
  })

  vim.diagnostic.config({
    float = {
      border = 'rounded',
    },
    update_in_insert = true,
    severity_sort = true,
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

---@param client any
---@param bufnr integer
local function lsp_document_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local gid = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
    vim.api.nvim_create_autocmd('CursorHold', {
      group = gid,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
      desc = 'Document highlight',
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = gid,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
      desc = 'Clear references',
    })
  end
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  require('plugin.lsp.formatting').setup(client, bufnr)
  require('plugin.lsp.keymaps').setup(client, bufnr)
  lsp_document_highlight(client, bufnr)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
