vim.lsp.config('denols', {
  root_dir = function(_, bufnr)
    return vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' })
  end,
})
