return {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = true },
        expressionAdjustmentHints = {
          enable = true,
          hideOutsideUnsafe = true,
        },
        lifetimeElisionHints = {
          enable = 'always',
          useParameterNames = true,
        },
      },
    },
  },
}
