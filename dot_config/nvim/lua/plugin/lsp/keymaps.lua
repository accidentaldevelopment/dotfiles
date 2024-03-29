local M = {}

--- Attach LSP related key mappings `buffer`
---@param client lsp.Client LSP Client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  local util = require('util')

  require('which-key').register({
    buffer = buffer,
    ['<leader>l'] = {
      name = 'LSP',
      I = { '<cmd>LspInstallInfo<cr>', 'Installer Info' },
      S = { util.lazy_require('telescope.builtin', 'lsp_dynamic_workspace_symbols'), 'Workspace Symbols' },
      a = {
        {
          vim.lsp.buf.code_action,
          'Code Action',
        },
        { vim.lsp.buf.code_action, 'Code Action', mode = 'v' },
      },
      i = { '<cmd>LspInfo<cr>', 'Info' },
      l = { vim.lsp.codelens.run, 'CodeLens Action' },
      n = { '<cmd>Navbuddy<cr>', 'Show Navbuddy' },
      q = { vim.lsp.diagnostic.set_loclist, 'Quickfix' },
      r = { vim.lsp.buf.rename, 'Rename', cond = client.supports_method(vim.lsp.protocol.Methods.textDocument_rename) },
      s = { util.lazy_require('telescope.builtin', 'lsp_document_symbols'), 'Document Symbols' },
    },
    ['<localleader>'] = {
      n = { '<cmd>Navbuddy<cr>', 'Show Navbuddy' },
      i = { '<cmd>LspInfo<cr>', 'Info' },
    },
    g = {
      name = '+goto',
      d = { '<cmd>Telescope lsp_definitions<cr>', 'Goto Definition' },
      r = { '<cmd>Telescope lsp_references<cr>', 'References' },
      D = { '<cmd>Telescope lsp_declarations<CR>', 'Goto Declaration' },
      I = { '<cmd>Telescope lsp_implementations<CR>', 'Goto Implementation' },
      t = { '<cmd>Telescope lsp_type_definitions<cr>', 'Goto Type Definition' },
    },
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Help', mode = { 'n', 'i' } },
    K = { vim.lsp.buf.hover, 'Show hover' },
    ['[d'] = { util.lazy(vim.diagnostic.goto_prev, { border = 'rounded' }), 'Previous diagnostic' },
    [']d'] = { util.lazy(vim.diagnostic.goto_next, { border = 'rounded' }), 'Next diagnostic' },
    ['[e'] = {
      util.lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR, border = 'rounded' }),
      'Previous Error',
    },
    [']e'] = {
      util.lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR, border = 'rounded' }),
      'Next Error',
    },
    ['[w'] = {
      util.lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.WARNING, border = 'rounded' }),
      'Previous Warning',
    },
    [']w'] = {
      util.lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.WARNING, border = 'rounded' }),
      'Next Warning',
    },
  })
end

return M
