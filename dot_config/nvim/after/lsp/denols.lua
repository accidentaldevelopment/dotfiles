--- @type vim.lsp.Config
return {
  root_dir = function(bufnr, cb)
    local root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' })
    if root then
      cb(root)
    end
  end,
}
