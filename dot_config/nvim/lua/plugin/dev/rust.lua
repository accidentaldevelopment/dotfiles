local ra_config = {
  check = {
    command = 'clippy',
  },
  inlayHints = {
    bindingModeHints = { enable = true },
    closureReturnTypeHints = { enable = true },
    expressionAdjustmentHints = {
      enable = true,
      hideOutsideUnsafe = true,
    },
    lifetimeElisionHints = {
      enable = 'always',
      useParameterNames = true,
    },
  },
}

return {
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts.handlers.rust_analyzer = {}
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    ft = 'rust',
    opts = {
      tools = {
        float_win_config = {
          border = 'rounded',
        },
      },
      server = {
        default_settings = {
          ['rust-analyzer'] = ra_config,
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
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
