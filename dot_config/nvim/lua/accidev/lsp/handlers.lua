local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    local gid = vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      group = gid,
      pattern = '<buffer>',
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      group = gid,
      pattern = '<buffer>',
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function lsp_keymaps(bufnr)
  local trouble = require 'trouble'
  local opts = { buffer = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  -- TODO: Use trouble when this is fixed: https://github.com/folke/trouble.nvim/issues/153
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gr', function()
    trouble.toggle 'lsp_references'
  end, opts)
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_prev { border = 'rounded' }
  end, opts)
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_next { border = 'rounded' }
  end, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', 'gl', function()
    vim.diagnostic.open_float(bufnr, { scope = 'line' })
  end, opts)
end

M.on_attach = function(client, bufnr)
  -- TODO: Find a better way to do this.
  if client.name == 'tsserver' or client.name == 'sumneko_lua' then
    client.resolved_capabilities.document_formatting = false
  end
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = '<buffer>',
    callback = function()
      vim.lsp.buf.formatting_sync(nil, 200)
    end,
  })
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
