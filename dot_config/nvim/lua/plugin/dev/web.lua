return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'javascript', 'typescript' })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'eslint_d', 'prettierd' })
    end,
  },
}
