local bufferline = require 'bufferline'

bufferline.setup {
  options = {
    diagnostics = 'nvim_lsp',
    offsets = { { filetype = 'NvimTree', text = 'File Explorer' } },
  },
}
