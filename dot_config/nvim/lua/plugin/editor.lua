--- @module "lazy"
--- @type LazyPluginSpec[]
return {
  {
    'echasnovski/mini.files',
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
      win = {
        border = 'rounded',
      },
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
    'echasnovski/mini.cursorword',
    event = 'BufReadPost',
    config = true,
  },
  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      local hipatterns = require('mini.hipatterns')
      ---@param words string[] Words
      local function w(words)
        return vim
          .iter(ipairs(words))
          :map(function(_, v)
            return '%f[%w]()' .. vim.pesc(v) .. '()%f[%W]'
          end)
          :totable()
      end

      local function comment(group)
        return function(bufnr, _, data)
          local captures = vim
            .iter(vim.treesitter.get_captures_at_pos(bufnr, data.line - 1, data.from_col - 1))
            :map(function(v)
              return v.capture
            end)
          if captures:find('comment') then
            return group
          end
        end
      end

      return {
        highlighters = {
          fixme = { pattern = w({ 'FIXME' }), group = comment('MiniHipatternsFixme') },
          hack = { pattern = w({ 'HACK' }), group = comment('MiniHipatternsHack') },
          todo = { pattern = w({ 'TODO' }), group = comment('MiniHipatternsTodo') },
          note = { pattern = w({ 'NOTE' }), group = comment('MiniHipatternsNote') },
          safety = { pattern = w({ 'SAFETY' }), group = comment('MiniHipatternsHack') },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
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
