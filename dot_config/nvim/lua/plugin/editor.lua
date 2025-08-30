--- @module "lazy"
--- @type LazyPluginSpec[]
return {
  {
    'nvim-mini/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          local mf = require('mini.files')
          if vim.bo.filetype == 'minifiles' then
            mf.close()
          else
            local file = vim.api.nvim_buf_get_name(0)
            local file_exists = vim.fn.filereadable(file) ~= 0
            mf.open(file_exists and file or nil)
            mf.reveal_cwd()
          end
        end,
        desc = 'Explorer',
      },
    },
    dependencies = {
      'mini.icons',
    },
    opts = {
      mappings = {
        go_in_plus = '<CR>',
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    --- @module "which-key"
    --- @type wk.Opts
    opts = {
      preset = 'helix',
      show_help = false,
      spec = {
        mode = { 'n', 'v' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>L', '<cmd>Lazy<cr>', desc = 'Show Lazy' },
        { '<leader>g', group = 'git' },
        { '<leader>o', group = 'open' },
        { '<leader>t', group = 'toggle' },
        { 'g', group = 'goto' },
        { 's', group = 'surround' },
        { ']', group = 'next' },
        { '[', group = 'prev' },
      },
    },
  },
  {
    'nvim-mini/mini.cursorword',
    event = 'BufReadPost',
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '[t',
        function()
          require('todo-comments').jump_prev()
        end,
        desc = 'Previous todo comment',
      },
      {
        ']t',
        function()
          require('todo-comments').jump_next()
        end,
        desc = 'Next todo comment',
      },
    },
    -- dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  { 'mrjones2014/smart-splits.nvim', lazy = false },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    -- stylua: ignore
    keys = {
      { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
      { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },

      { '<localleader>w', function() require('snacks').bufdelete.delete(0) end, desc = 'Delete Buffer' },

      -- pickers
      { '<leader>b', function() Snacks.picker.buffers() end, desc = 'Search buffers' },
      { '<tab>', function() Snacks.picker.buffers() end, desc = 'Search buffers' },
      { '<leader>f', function() Snacks.picker.files() end, desc = 'Find files' },
      { '<leader>/', function() Snacks.picker.grep({layout = 'ivy'}) end, desc = 'Search' },
    },
    --- @module "snacks"
    --- @type snacks.Config
    opts = {
      bigfile = { enabled = true },
      indent = {
        chunk = {
          enabled = true,
          char = {
            corner_top = '╭',
            corner_bottom = '╰',
          },
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        formatters = {
          file = {
            filename_first = true,
          },
        },
        layouts = {
          ivy = {
            layout = {
              border = 'rounded',
            },
          },
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      styles = { input = { relative = 'cursor' } },
      words = { enabled = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          Snacks.toggle.option('spell', { name = 'Spell Check' }):map('<localleader>s')
        end,
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = 'markdown',
    cmd = {
      'RenderMarkdown',
    },
    opts = {
      overrides = {
        buftype = {
          -- Chances are nofile is just for reading, so don't ever anti-conceal
          nofile = {
            win_options = {
              concealcursor = {
                default = 'nvic',
                rendered = 'nvic',
              },
            },
            anti_conceal = {
              enabled = false,
            },
            sign = { enabled = false },
          },
        },
      },
    },
  },
}
