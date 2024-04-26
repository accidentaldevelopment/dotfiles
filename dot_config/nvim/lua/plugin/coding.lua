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
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    cond = false,
    opts = {
      -- mappings = {
      --   -- disable if a matching character is in an adjacent position (eg. fixes
      --   -- markdown triple ticks) neigh_pattern: a pattern for *two* neighboring
      --   -- characters (before and after). Use dot `.` to allow any character.
      --   -- Here, we disable the functionality instead of inserting a matching quote
      --   -- if there is an adjacent non-space character
      --   ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%S][^%S]', register = { cr = false } },
      --   ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%S][^%S]', register = { cr = false } },
      --   ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%S][^%S]', register = { cr = false } },
      -- },
    },
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'echasnovski/mini.surround',
    keys = {
      { 'sa', desc = 'Add surrounding', mode = { 'n', 'v' } },
      { 'sd', desc = 'Delete surrounding' },
      { 'sf', desc = 'Find right surrounding' },
      { 'sF', desc = 'Find left surrounding' },
      { 'sh', desc = 'Highlight surrounding' },
      { 'sr', desc = 'Replace surrounding' },
      { 'sn', desc = 'Update `MiniSurround.config.n_lines`' },
    },
    opts = {},
  },
  {
    'hiphish/rainbow-delimiters.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
}
