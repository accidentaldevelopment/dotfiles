return {
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
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      print('noice loaded')
      require('noice').setup(opts)
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
}
