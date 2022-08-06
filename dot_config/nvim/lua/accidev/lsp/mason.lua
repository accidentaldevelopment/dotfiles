local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'

local opts = {
  on_attach = require('accidev.lsp.handlers').on_attach,
  capabilities = require('accidev.lsp.handlers').capabilities,
}

mason.setup {
  ui = {
    border = 'rounded',
  },
}

require('fidget').setup {}

mason_lspconfig.setup()

local function rust_tools_setup(opts)
  require('rust-tools').setup {
    server = opts,
  }
end

local lspconfig = require 'lspconfig'
for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
  local setup_fn = nil
  if server == 'rust_analyzer' then
    setup_fn = rust_tools_setup
  else
    setup_fn = lspconfig[server].setup
  end

  local status_ok, lsp_opts = pcall(require, 'accidev.lsp.settings.' .. server)
  local full_opts = {}
  if status_ok then
    full_opts = vim.tbl_deep_extend('force', opts, lsp_opts)
  else
    -- vim.notify('no custom settings for lsp: ' .. server.name, vim.log.levels.DEBUG)
    full_opts = opts
  end
  setup_fn(full_opts)
end
