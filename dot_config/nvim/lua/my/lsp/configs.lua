local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
local lsp_inlayhints = require 'lsp-inlayhints'

local opts = {
  on_attach = require('my.lsp.handlers').on_attach,
  capabilities = require('my.lsp.handlers').capabilities,
}

lsp_inlayhints.setup()
local lspattatch_inlayhints = vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = lspattatch_inlayhints,
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    lsp_inlayhints.on_attach(client, bufnr)
  end,
})

mason.setup {
  ui = {
    border = 'rounded',
  },
}

mason_lspconfig.setup()

local lspconfig = require 'lspconfig'
for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
  local status_ok, lsp_opts = pcall(require, 'my.lsp.settings.' .. server)
  local full_opts = {}
  if status_ok then
    full_opts = vim.tbl_deep_extend('force', opts, lsp_opts)
  else
    -- vim.notify('no custom settings for lsp: ' .. server.name, vim.log.levels.DEBUG)
    full_opts = opts
  end
  lspconfig[server].setup(full_opts)
end

require('my.lsp.handlers').setup()
