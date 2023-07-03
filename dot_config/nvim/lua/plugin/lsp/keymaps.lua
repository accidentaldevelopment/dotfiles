local M = {}

--- Show a documentation popup.
--- Defaults to `vim.lsp.buf.hover` if there are higher priority popups available.
local function show_docs()
  local crates = package.loaded.crates
  if crates ~= nil and crates.popup_available() then
    crates.show_popup()
  else
    vim.lsp.buf.hover()
  end
end

--- Attach LSP related key mappings `buffer`
---@param client any LSP Client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  local trouble = require('trouble')
  local util = require('util')

  local caps = client.server_capabilities

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
      d = { util.lazy(trouble.toggle, 'document_diagnostics'), 'Document Diagnostics' },
      i = { '<cmd>LspInfo<cr>', 'Info' },
      l = { vim.lsp.codelens.run, 'CodeLens Action' },
      q = { vim.lsp.diagnostic.set_loclist, 'Quickfix' },
      r = { vim.lsp.buf.rename, 'Rename', cond = caps.renameProvider },
      s = { util.lazy_require('telescope.builtin', 'lsp_document_symbols'), 'Document Symbols' },
      w = { util.lazy(trouble.toggle, 'workspace_diagnostics'), 'Workspace Diagnostics' },
    },
    g = {
      name = '+goto',
      d = { '<cmd>Telescope lsp_definitions<cr>', 'Goto Definition' },
      r = { '<cmd>Telescope lsp_references<cr>', 'References' },
      R = { util.lazy(trouble.toggle, 'lsp_references'), 'Trouble References' },
      D = { '<cmd>Telescope lsp_declarations<CR>', 'Goto Declaration' },
      I = { '<cmd>Telescope lsp_implementations<CR>', 'Goto Implementation' },
      t = { '<cmd>Telescope lsp_type_definitions<cr>', 'Goto Type Definition' },
    },
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Help', mode = { 'n', 'i' } },
    K = { show_docs, 'Show docst' },
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
