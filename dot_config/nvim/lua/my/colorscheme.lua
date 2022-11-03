require('catppuccin').setup {
  highlight_overrides = {
    mocha = function(colors)
      return {
        LspInlayHint = { bg = colors.surface0, fg = colors.overlay1 },
      }
    end,
  },
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
    neogit = false,
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
