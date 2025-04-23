return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'javascript', 'typescript' })
    end,
  },
  {
    'mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'eslint_d', 'prettierd' })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = false,
    opts = {},
  },
}
