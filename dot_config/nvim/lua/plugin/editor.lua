return {
  'folke/which-key.nvim',

  -- d by everything, so just always include it.
  'nvim-lua/plenary.nvim',

  'alker0/chezmoi.vim',

  'gpanders/editorconfig.nvim',
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
  },
  {
    'windwp/nvim-autopairs',
    event = 'BufReadPre',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end,
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
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup()
    end,
  },

  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup()
    end,
  },

  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    config = function()
      require('aerial').setup()
    end,
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
    config = function()
      require('scrollbar').setup()
    end,
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
