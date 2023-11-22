return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'javascript')
      table.insert(opts.ensure_installed, 'typescript')
    end,
  },
  {
    'mason-tool-installer.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'eslint_d')
      table.insert(opts.ensure_installed, 'prettierd')
    end,
  },
}
