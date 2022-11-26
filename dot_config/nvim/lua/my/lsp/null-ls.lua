local null_ls = require 'null-ls'

local handlers = require 'my.lsp.handlers'

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  on_attach = handlers.on_attach,
  sources = {
    formatting.fish_indent,
    formatting.prettierd.with { args = { '--prose-wrap=always', '$FILENAME' } },
    formatting.stylua,
    -- diagnostics.cspell,
    diagnostics.eslint,
    diagnostics.fish,
    diagnostics.markdownlint,
    diagnostics.zsh,
  },
}
