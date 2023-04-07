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
      return {
        -- override for lsp inlay hints
        LspInlayHint = { bg = colors.surface0, fg = colors.overlay1 },

        TabLine = { fg = require('catppuccin.utils.colors').darken(colors.sky, 0.8), bg = colors.mantle },
        TabLineSel = { fg = colors.sky, bg = colors.base, bold = true },

        Comment = { fg = colors.overlay1 },

        SLOptionEnabled = { fg = colors.green },
        SLOptionDisabled = { fg = colors.subtext1 },

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
      aerial = true,
      barbar = false,
      cmp = true,
      dashboard = false,
      fern = false,
      gitgutter = false,
      gitsigns = true,
      hop = false,
      illuminate = true,
      indent_blankline = { enabled = true, colored_indent_levels = false },
      lightspeed = false,
      lsp_saga = false,
      lsp_trouble = false,
      markdown = true,
      mason = true,
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
        custom_bg = 'NONE',
      },
      neogit = false,
      noice = true,
      notify = true,
      nvimtree = { enabled = true, show_root = true, transparent_panel = false },
      telekasten = true,
      telescope = true,
      treesitter = true,
      ts_rainbow2 = true,
      vim_sneak = false,
      which_key = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}
