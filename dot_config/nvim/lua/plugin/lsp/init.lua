return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'williamboman/mason-lspconfig.nvim',
    'lvimuser/lsp-inlayhints.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'folke/trouble.nvim',
  },
  config = function()
    require('plugin.lsp.configs')
    require('plugin.lsp.null-ls')
  end,
}