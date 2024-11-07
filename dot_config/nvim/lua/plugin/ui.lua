--- @module "lazy"
--- @type LazyPluginSpec[]
return {
  {
    'echasnovski/mini.icons',
    opts = {},
    init = function()
      return require('mini.icons').mock_nvim_web_devicons()
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    opts = {
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
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
    'dstein64/nvim-scrollview',
    event = 'BufReadPre',
    ---@type {builtin: any, gitsigns:any}
    opts = {
      builtin = {
        always_show = true,
        signs_max_per_row = 1,
        signs_on_startup = {
          'cursor',
          'diagnostics',
          'marks',
          'search',
        },
      },
      gitsigns = {

        add_symbol = '+',
        change_symbol = '=',
        delete_symbol = '-',
      },
    },
    config = function(_, opts)
      require('scrollview.contrib.gitsigns').setup(opts.gitsigns)
      require('scrollview').setup(opts.builtin)
    end,
  },
}
