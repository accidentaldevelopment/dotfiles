return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'rust', 'toml' })
    end,
  },
  {
    'saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    dependencies = {
      'nvim-cmp',
    },
    opts = {
      popup = {
        border = 'rounded',
      },
      completion = {
        cmp = {
          enabled = true,
        },
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        name = 'crates',
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    'mason-tool-installer.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'rust-analyzer')
    end,
  },
}
