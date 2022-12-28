local lsp_inlayhints = require('lsp-inlayhints')

local opts = {
  on_attach = require('plugin.lsp.handlers').on_attach,
  capabilities = require('plugin.lsp.handlers').capabilities,
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
    lsp_inlayhints.on_attach(client, bufnr, false)
  end,
})

require('mason-lspconfig').setup()

require('neodev').setup({
  override = function(root_dir, library)
    if string.find(root_dir, 'chezmoi/dot_config/nvim') then
      library.enabled = true
      library.plugins = true
    end
  end,
})

require('mason-lspconfig').setup_handlers({
  function(server_name)
    local ok, lsp_opts = pcall(require, 'plugin.lsp.settings.' .. server_name)
    if ok then
      require('lspconfig')[server_name].setup(vim.tbl_deep_extend('force', opts, lsp_opts))
    else
      require('lspconfig')[server_name].setup(opts)
    end
  end,
})

require('plugin.lsp.handlers').setup()
