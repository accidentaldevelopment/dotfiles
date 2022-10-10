require('noice').setup {
  views = {
    cmdline_popup = {
      position = {
        row = vim.o.lines - 4,
      },
      size = { width = vim.o.columns - 4 },
    },
  },
}
