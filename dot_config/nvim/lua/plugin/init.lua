return {
  'folke/which-key.nvim',

  'alker0/chezmoi.vim',

  'gpanders/editorconfig.nvim',
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bc',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Close Buffer',
      },
    },
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    config = function()
      require('mini.pairs').setup()
    end,
  },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    config = function()
      require('mini.comment').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function()
      require('indent_blankline').setup({
        show_trailing_blankline_indent = false,
        show_current_context = false,
        -- show_current_context_start = true,
      })
    end,
  },
  {
    'echasnovski/mini.indentscope',
    event = 'BufReadPre',
    config = function()
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = {
      ui = {
        border = 'rounded',
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = true,
  },

  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = true,
  },

  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    keys = { { '<leader>a', '<cmd>AerialToggle!<cr>', desc = 'Aerial' } },
    config = true,
  },
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPre',
    config = true,
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'md' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  'folke/neodev.nvim',
}
