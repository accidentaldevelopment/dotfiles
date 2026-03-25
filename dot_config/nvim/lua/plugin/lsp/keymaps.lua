local M = {}

--- Attach LSP related key mappings `buffer`
---@param client vim.lsp.Client LSP Client object
---@param buffer number Buffer number
---@diagnostic disable-next-line: unused-local
function M.on_attach(client, buffer)
  require('snacks').toggle.inlay_hints():map('<localleader>h')
  require('which-key').add({
    buffer = buffer,
    { '<leader>l', group = 'LSP' },
    { '<leader>lI', '<CMD>LspInstallInfo<CR>', desc = 'Installer Info' },
    {
      '<leader>lS',
      function()
        Snacks.picker.lsp_workspace_symbols({ hierarchy = true })
      end,
      desc = 'Workspace Symbols',
    },
    { '<leader>ll', vim.lsp.codelens.run, desc = 'CodeLens Action' },
    { '<leader>lq', vim.lsp.diagnostic.set_loclist, desc = 'Quickfix' },

    { '<localleader>n', Snacks.picker.lsp_symbols, desc = 'Document Symbols' },
    { '<localleader>i', '<CMD>LspInfo<cr>', desc = 'LSP Info' },

    { 'gd', Snacks.picker.lsp_definitions, desc = 'Goto Definition' },
    { 'gD', Snacks.picker.lsp_declarations, desc = 'Goto Declaration' },
    { 'gI', Snacks.picker.lsp_implementations, desc = 'Goto Implementation' },
    { 'gt', Snacks.picker.lsp_type_definitions, desc = 'Goto Type Definition' },

    { 'gra', desc = 'Code Actions' },
    { 'grn', desc = 'Rename' },
    { 'grr', Snacks.picker.lsp_references, desc = 'References' },

    {
      '[e',
      function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
      end,
      desc = 'Previous Error',
    },
    {
      ']e',
      function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
      end,
      desc = 'Next Error',
    },

    {
      '[w',
      function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
      end,
      desc = 'Previous Warning',
    },
    {
      ']w',
      function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
      end,
      desc = 'Next Warning',
    },
  })
end

return M
