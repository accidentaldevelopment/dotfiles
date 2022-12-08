require('catppuccin').setup {
  background = {
    -- These are defaults, leaving them here so I remember
    light = 'latte',
    dark = 'mocha',
  },
  custom_highlights = function(colors)
    return {
      -- override for lsp inlay hints
      LspInlayHint = { bg = colors.surface0, fg = colors.overlay1 },

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
    bufferline = true,
    cmp = true,
    dashboard = true,
    fern = false,
    gitgutter = false,
    gitsigns = true,
    hop = false,
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
    ts_rainbow = true,
    vim_sneak = false,
    which_key = true,
  },
}

vim.cmd.colorscheme 'catppuccin'
