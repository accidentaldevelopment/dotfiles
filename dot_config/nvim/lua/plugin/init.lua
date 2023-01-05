return {
  'folke/which-key.nvim',

  'alker0/chezmoi.vim',

  'gpanders/editorconfig.nvim',
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
    keys = {
      { '<leader>bc', '<cmd>Bdelete<cr>', desc = 'Close Buffer' },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'BufReadPre',
    config = true,
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function()
      require('indent_blankline').setup({
        show_current_context = true,
        show_current_context_start = true,
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
