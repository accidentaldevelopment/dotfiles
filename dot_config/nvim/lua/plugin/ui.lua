return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    cond = false,
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = false },
      -- whitespace = { remove_blankline_trail = true },
    },
  },
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPre', 'BufNewFile' },
    cond = false,
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    opts = {
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = vim.o.lines - 3,
          },
          size = { width = vim.o.columns - 4 },
        },
      },
      lsp = {
        override = {
          -- override the default lsp markdown formatter with Noice
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          -- override the lsp markdown formatter with Noice
          ['vim.lsp.util.stylize_markdown'] = true,
          -- -- override cmp documentation with Noice (needs the other options to work)
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
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
}
