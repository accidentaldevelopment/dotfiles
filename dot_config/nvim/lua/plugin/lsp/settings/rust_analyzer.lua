return {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = true },
        lifetimeElisionHints = { enable = 'always', useParameterNames = true },
        reborrowHints = { enable = true },
      },
    },
  },
}
