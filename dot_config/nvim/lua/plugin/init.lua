return {
  'folke/which-key.nvim',
  {
    'alker0/chezmoi.vim',
    priority = 9900,
    lazy = false,
    cond = false,
    ---  @param plugin LazyPlugin
    init = function(plugin)
      for _, a in ipairs(vim.fn.argv()) do
        if a:find('chezmoi-edit', 1, true) ~= nil then
          vim.notify('enabling chezmoi', vim.log.levels.INFO)
          plugin.cond = true
          return nil
        end
      end
    end,
  },

  'gpanders/editorconfig.nvim',
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>c',
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
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    opts = {
      show_trailing_blankline_indent = false,
      show_current_context = false,
      -- show_current_context_start = true,
    },
  },
  {
    'echasnovski/mini.indentscope',
    event = 'BufReadPre',
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
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
    keys = {
      { 's', desc = 'Leap forward' },
      { 'S', desc = 'Leap backward' },
    },
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPre',
    opts = {
      handlers = { gitsigns = true },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown', 'md' },
    build = function()
      vim.fn['mkdp#util#install']()
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
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    opts = { delay = 200 },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
    -- keys = {
    --   {
    --     ']]',
    --     function()
    --       require('illuminate').goto_next_reference(false)
    --     end,
    --     desc = 'Next Reference',
    --   },
    --   {
    --     '[[',
    --     function()
    --       require('illuminate').goto_prev_reference(false)
    --     end,
    --     desc = 'Prev Reference',
    --   },
    -- },
  },
}
