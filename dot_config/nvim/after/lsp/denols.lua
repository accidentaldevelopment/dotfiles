vim.lsp.config('denols', {
  cmd = { 'deno', 'lsp' },
  root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc'),
})
