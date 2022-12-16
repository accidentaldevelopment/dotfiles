return {
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'lvimuser/lsp-inlayhints.nvim',
    'jose-elias-alvarez/null-ls.nvim',
  },
  config = function()
    require 'lsp.configs'
    require 'lsp.null-ls'
  end,
}
