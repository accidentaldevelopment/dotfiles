return {

  {
    'famiu/bufdelete.nvim',
    module = 'bufdelete',
    cmd = { 'Bdelete', 'Bwipeout' },
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    module = 'trouble',
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
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'md' },
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
