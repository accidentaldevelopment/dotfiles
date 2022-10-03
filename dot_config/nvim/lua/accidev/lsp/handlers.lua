local M = {}

local disabled_formatters = {
  tsserver = true,
  sumneko_lua = true,
  jsonls = true,
  html = true,
}

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
    -- signs = {
    --   active = signs,
    -- },
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
  if client.server_capabilities.documentFormattingProvider then
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
  local util = require 'accidev.util'

  require('which-key').register({
    g = {
      D = { vim.lsp.buf.declaration, 'Declarations' },
      d = { util.lazy_fn(trouble.toggle, 'lsp_definitions'), 'Definitions' },
      i = { vim.lsp.buf.implementation, 'Implementation' },
      r = { util.lazy_fn(trouble.toggle, 'lsp_references'), 'References' },
      l = { util.lazy_fn(vim.diagnostic.open_float, bufnr, { scope = 'line' }), 'Diagnostics?' },
    },
    K = { vim.lsp.buf.hover, 'Hover' },
    ['[d'] = { util.lazy_fn(vim.diagnostic.goto_prev, { border = 'rounded' }), 'Previous diagnostic' },
    [']d'] = { util.lazy_fn(vim.diagnostic.goto_next, { border = 'rounded' }), 'Next diagnostic' },
  }, { buffer = bufnr })
end

M.on_attach = function(client, bufnr)
  -- TODO: Find a better way to do this.
  if client.supports_method 'textDocument/formatting' then
    print('setting up formatting with ' .. client.name)
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- TODO: something weird is happening here...
        vim.lsp.buf.format {
          -- filter = function(client)
          --   return disabled_formatters[client.name] ~= true
          -- end,
        }
      end,
    })
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
