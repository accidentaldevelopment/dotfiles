local M = {}

--- Attach LSP related key mappings `buffer`
---@param client vim.lsp.Client LSP Client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  local util = require('util')

  local function a(i) end

  require('which-key').register({
    buffer = buffer,
    ['<leader>l'] = {
      name = 'LSP',
      I = { '<cmd>LspInstallInfo<cr>', 'Installer Info' },
      S = { util.lazy_require('telescope.builtin', 'lsp_dynamic_workspace_symbols'), 'Workspace Symbols' },
      i = { '<cmd>LspInfo<cr>', 'Info' },
      l = { vim.lsp.codelens.run, 'CodeLens Action' },
      n = { '<cmd>Navbuddy<cr>', 'Show Navbuddy' },
      q = { vim.lsp.diagnostic.set_loclist, 'Quickfix' },
      s = { util.lazy_require('telescope.builtin', 'lsp_document_symbols'), 'Document Symbols' },
    },
    ['<leader>c'] = {
      name = 'Code Actions',
      a = { vim.lsp.buf.code_action, 'Code Action', mode = { 'n', 'v' } },
      A = {
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                'source',
              },
              diagnostics = {},
            },
          })
        end,
        'Source Action',
      },
      r = { vim.lsp.buf.rename, 'Rename', cond = client.supports_method(vim.lsp.protocol.Methods.textDocument_rename) },
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
    ['<C-s>'] = {
      vim.lsp.buf.signature_help,
      'Signature Help',
      cond = client.supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp),
      mode = { 'n', 'i' },
    },
    ['[d'] = { util.lazy(vim.diagnostic.goto_prev), 'Previous diagnostic' },
    [']d'] = { util.lazy(vim.diagnostic.goto_next), 'Next diagnostic' },
    ['[e'] = {
      util.lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }),
      'Previous Error',
    },
    [']e'] = {
      util.lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }),
      'Next Error',
    },
    ['[w'] = {
      util.lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.WARNING }),
      'Previous Warning',
    },
    [']w'] = {
      util.lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.WARNING }),
      'Next Warning',
    },
  })
end

return M
