return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 9999,
  opts = {
    background = {
      -- These are defaults, leaving them here so I remember
      light = 'latte',
      dark = 'mocha',
    },
    custom_highlights = function(colors)
      local U = require('catppuccin.utils.colors')

      return {
        TabLine = { fg = U.darken(colors.sky, 0.8), bg = colors.base },
        TabLineSel = { fg = colors.sky, bg = colors.base, bold = true },

        MiniCursorwordCurrent = { bg = U.darken(colors.surface1, 0.7, colors.base) },

        SLOptionEnabled = { fg = colors.green },
        SLOptionDisabled = { fg = colors.subtext1 },

        SLFormattingEnabled = { link = 'Normal' },
        SLFormattingDisabled = { fg = colors.overlay2 },

        -- highlights for statusline.
        SLViModeNormal = { fg = colors.red },
        SLViModeInsert = { fg = colors.green },
        SLViModeVisual = { fg = colors.teal },
        SLViModeCommand = { fg = colors.yellow },
        SLViModeSelect = { fg = colors.pink },
        SLViModeReplace = { fg = colors.yellow },
        SLViModeExec = { fg = colors.red },
        SLViModeTerminal = { fg = colors.red },
        SLFileFlagsModified = { fg = colors.green },
        SLFileFlagsReadOnly = { fg = colors.peach },
        SLHelpFileName = { fg = colors.peach },
        SLGitBranch = { fg = colors.peach },
        SLScrollBar = { fg = colors.blue },
      }
    end,
    integrations = {
      barbar = false,
      blink_cmp = true,
      cmp = true,
      dashboard = false,
      fern = false,
      gitgutter = false,
      gitsigns = true,
      hop = false,
      illuminate = false,
      indent_blankline = { enabled = false },
      lightspeed = false,
      lsp_saga = false,
      lsp_trouble = false,
      markdown = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
      },
      navic = {
        enabled = true,
      },
      neogit = false,
      noice = true,
      notify = true,
      rainbow_delimiters = true,
      snacks = true,
      telescope = false,
      treesitter = true,
      ts_rainbow = false,
      ts_rainbow2 = false,
      vim_sneak = false,
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}
