return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'go')
    end,
  },
  {
    'mason-tool-installer.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'gopls')
    end,
  },
}
