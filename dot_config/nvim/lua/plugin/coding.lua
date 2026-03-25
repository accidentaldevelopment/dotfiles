--- @type LazyPluginSpec[]
return {
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    opts = {
      disable_filetype = { 'snacks_picker_input' },
    },
  },
  {
    'nvim-mini/mini.surround',
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
    submodules = false,
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
