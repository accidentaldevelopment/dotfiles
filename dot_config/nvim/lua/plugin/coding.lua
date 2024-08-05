return {
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
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
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
    },
    config = true,
  },
}
