vim.filetype.add({
  filename = {
    ['tsconfig.json'] = 'jsonc',
  },
  pattern = {
    ['*.jsonc'] = 'jsonc',
    ['tsconfig*.json'] = 'jsonc',
    ['${XDG_CONFIG_HOME}/ghostty/%w+'] = 'ghostty',
  },
})
