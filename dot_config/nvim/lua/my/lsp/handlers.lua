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
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
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
  local trouble = package.loaded.trouble --or require 'trouble'
  local wk = package.loaded['which-key']
  local tscope = package.loaded.telescope.builtin or require 'telescope.builtin'
  local util = require 'my.util'

  wk.register({
    ['<leader>l'] = {
      name = 'LSP',
      I = { '<cmd>LspInstallInfo<cr>', 'Installer Info' },
      S = { tscope.lsp_dynamic_workspace_symbols, 'Workspace Symbols' },
      a = { vim.lsp.buf.code_action, 'Code Action' },
      d = { util.lazy_fn(trouble.toggle, 'document_diagnostics'), 'Document Diagnostics' },
      i = { '<cmd>LspInfo<cr>', 'Info' },
      l = { vim.lsp.codelens.run, 'CodeLens Action' },
      q = { vim.lsp.diagnostic.set_loclist, 'Quickfix' },
      r = { vim.lsp.buf.rename, 'Rename' },
      s = { tscope.lsp_document_symbols, 'Document Symbols' },
      w = { util.lazy_fn(trouble.toggle, 'workspace_diagnostics'), 'Workspace Diagnostics' },
    },
    g = {
      D = { vim.lsp.buf.declaration, 'Declarations' },
      d = { util.lazy_fn(trouble.toggle, 'lsp_definitions'), 'Definitions' },
      i = { vim.lsp.buf.implementation, 'Implementation' },
      l = { util.lazy_fn(vim.diagnostic.open_float, bufnr, { scope = 'line' }), 'Diagnostics' },
      r = { util.lazy_fn(trouble.toggle, 'lsp_references'), 'References' },
    },
    K = { vim.lsp.buf.hover, 'Hover' },
    ['[d'] = { util.lazy_fn(vim.diagnostic.goto_prev, { border = 'rounded' }), 'Previous diagnostic' },
    [']d'] = { util.lazy_fn(vim.diagnostic.goto_next, { border = 'rounded' }), 'Next diagnostic' },
  }, { buffer = bufnr })
end

M.on_attach = function(client, bufnr)
  -- TODO: Find a better way to do this.
  if client.supports_method 'textDocument/formatting' then
    local format = function()
      vim.lsp.buf.format {
        filter = function(client)
          return disabled_formatters[client.name] == nil
        end,
      }
    end
    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, bufnr)
    end
    require('which-key').register({
      ['<leader>lf'] = { format, 'Format' },
    }, { buffer = bufnr })
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = format,
    })
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
