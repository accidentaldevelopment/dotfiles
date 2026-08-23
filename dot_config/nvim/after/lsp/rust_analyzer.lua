return {
  ---@type lsp.rust_analyzer
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
        closureReturnTypeHints = { enable = 'always' },
        expressionAdjustmentHints = {
          enable = 'always',
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
