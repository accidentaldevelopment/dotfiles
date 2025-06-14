return {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      semanticHighlighting = {
        punctuation = {
          separate = {
            macro = {
              bang = true,
            },
          },
        },
        strings = {
          enable = false,
        },
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
