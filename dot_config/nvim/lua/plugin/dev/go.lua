return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'go')
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'gopls')
    end,
  },
}
