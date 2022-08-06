return {
  standalone = false,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        closingBraceHints = { minLines = 1 },
        closureReturnTypeHints = { enable = true },
        lifetimeElisionHints = { enable = 'always', useParameterNames = true },
        reborrowHints = { enable = true },
      },
    },
  },
}
