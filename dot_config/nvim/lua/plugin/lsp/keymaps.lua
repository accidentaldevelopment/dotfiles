local M = {}

--- Attach LSP related key mappings `buffer`
---@param client vim.lsp.Client LSP Client object
---@param buffer number Buffer number
function M.on_attach(client, buffer)
  require('which-key').add({
    buffer = buffer,
    { '<leader>l', group = 'LSP' },
    { '<leader>lI', '<CMD>LspInstallInfo<CR>', desc = 'Installer Info' },
    { '<leader>lS', '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workspace Symbols' },
    { '<leader>li', '<CMD>LspInfo<CR>', desc = 'Info' },
    { '<leader>ll', vim.lsp.codelens.run, desc = 'CodeLens Action' },
    { '<leader>ln', '<CMD>Navbuddy<CR>', desc = 'Show Navbuddy' },
    { '<leader>lq', vim.lsp.diagnostic.set_loclist, desc = 'Quickfix' },
    { '<leader>ls', '<CMD>Telescope lsp_document_symbols<CR>', desc = 'Document Symbols' },

    { '<localleader>n', '<CMD>Navbuddy<cr>', desc = 'Show Navbuddy' },
    { '<localleader>i', '<CMD>LspInfo<cr>', desc = 'Info' },

    { 'gd', '<CMD>Telescope lsp_definitions<CR>', desc = 'Goto Definition' },
    { 'gD', '<CMD>Telescope lsp_declarations<CR>', desc = 'Goto Declaration' },
    { 'gI', '<CMD>Telescope lsp_implementations<CR>', desc = 'Goto Implementation' },
    { 'gt', '<CMD>Telescope lsp_type_definitions<CR>', desc = 'Goto Type Definition' },

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
