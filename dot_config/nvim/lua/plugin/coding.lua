return {
  {
    'L3MON4D3/LuaSnip',
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    -- stylua: ignore
    keys = {
      {
        '<tab>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
        end,
        expr = true, silent = true, mode = 'i',
      },
      { '<tab>', function() require('luasnip').jump(1) end, mode = 's', },
      { '<s-tab>', function() require('luasnip').jump(-1) end, mode = { 'i', 's' }, },
    },
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    config = function()
      require('mini.pairs').setup({})
    end,
  },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    config = function()
      require('mini.comment').setup({})
    end,
  },
  {
    'echasnovski/mini.surround',
    keys = { 'gz' },
    opts = {
      mappings = {
        add = 'gza', -- Add surrounding in Normal and Visual modes
        delete = 'gzd', -- Delete surrounding
        find = 'gzf', -- Find surrounding (to the right)
        find_left = 'gzF', -- Find surrounding (to the left)
        highlight = 'gzh', -- Highlight surrounding
        replace = 'gzr', -- Replace surrounding
        update_n_lines = 'gzn', -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require('mini.surround').setup(opts)
    end,
  },

  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    keys = { { '<leader>a', '<cmd>AerialToggle!<cr>', desc = 'Aerial' } },
    config = true,
  },

  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = true,
  },
}
