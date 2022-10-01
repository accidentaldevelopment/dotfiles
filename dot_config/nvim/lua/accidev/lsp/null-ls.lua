local null_ls = require 'null-ls'

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    formatting.fish_indent,
    formatting.prettier,
    formatting.stylua,
    -- diagnostics.cspell,
    diagnostics.eslint,
    diagnostics.fish,
    diagnostics.zsh,
  },
}
