local components = require('feline.default_components').statusline.icons

table.insert(components.active[1], 6, {
  provider = 'lsp_client_names',
  left_sep = ' ',
})

require('feline').setup {}
require('feline').winbar.setup {}
