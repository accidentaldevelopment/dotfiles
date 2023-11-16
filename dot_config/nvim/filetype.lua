vim.filetype.add({
  filename = {
    ['tsconfig.json'] = 'jsonc',
    ['Cargo.toml'] = 'toml.cargo',
  },
  pattern = {
    ['*.jsonc'] = 'jsonc',
    ['tsconfig*.json'] = 'jsonc',
  },
})
