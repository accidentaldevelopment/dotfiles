local M = {}

M.setup = function()
  vim.fn.sign_define {
    { name = 'DiagnosticSignError', text = '', texthl = 'DiagnosticSignError', numhl = '' },
    { name = 'DiagnosticSignWarn', text = '', texthl = 'DiagnosticSignWarn', numhl = '' },
    { name = 'DiagnosticSignHint', text = '', texthl = 'DiagnosticSignHint', numhl = '' },
    { name = 'DiagnosticSignInfo', text = '', texthl = 'DiagnosticSignInfo', numhl = '' },
  }

  vim.diagnostic.config {
    float = {
      border = 'rounded',
    },
    update_in_insert = true,
    severity_sort = true,
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lsp_highlight_document(client)
  if client.server_capabilities.documentHighlightProvider then
    local gid = vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd('CursorHold', {
      group = gid,
      pattern = '<buffer>',
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = gid,
      pattern = '<buffer>',
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  require('plugin.lsp.formatting').setup(client, bufnr)
  require('plugin.lsp.keymaps').setup(client, bufnr)
  lsp_highlight_document(client)
end

return M
