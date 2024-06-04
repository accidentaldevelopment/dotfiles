local M = {}

--- Attach LSP related key mappings `buffer`
---@param client vim.lsp.Client LSP Client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  require('which-key').register({
    buffer = buffer,
    ['<leader>l'] = {
      name = 'LSP',
      I = { '<CMD>LspInstallInfo<CR>', 'Installer Info' },
      S = { '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>', 'Workspace Symbols' },
      i = { '<CMD>LspInfo<CR>', 'Info' },
      l = { vim.lsp.codelens.run, 'CodeLens Action' },
      n = { '<CMD>Navbuddy<CR>', 'Show Navbuddy' },
      q = { vim.lsp.diagnostic.set_loclist, 'Quickfix' },
      s = { '<CMD>Telescope lsp_document_symbols<CR>', 'Document Symbols' },
    },
    ['<localleader>'] = {
      n = { '<CMD>Navbuddy<cr>', 'Show Navbuddy' },
      i = { '<CMD>LspInfo<cr>', 'Info' },
    },
    g = {
      name = '+goto',
      d = { '<CMD>Telescope lsp_definitions<CR>', 'Goto Definition' },
      D = { '<CMD>Telescope lsp_declarations<CR>', 'Goto Declaration' },
      I = { '<CMD>Telescope lsp_implementations<CR>', 'Goto Implementation' },
      t = { '<CMD>Telescope lsp_type_definitions<CR>', 'Goto Type Definition' },
    },
    gr = {
      r = { '<CMD>Telescope lsp_references<CR>', 'LSP References' },
    },
    ['[e'] = {
      function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
      end,
      'Previous Error',
    },
    [']e'] = {
      function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
      end,
      'Next Error',
    },
    ['[w'] = {
      function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
      end,
      'Previous Warning',
    },
    [']w'] = {
      function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
      end,
      'Next Warning',
    },
  })
end

return M
