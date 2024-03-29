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
      src = {
        cmp = {
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
    config = function(_, opts)
      require('crates').setup(opts)

      require('cmp').setup.filetype('toml', {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'crates' },
          { name = 'path' },
        },
      })
    end,
  },
  {
    'mason-tool-installer.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'rust-analyzer')
    end,
  },
}
