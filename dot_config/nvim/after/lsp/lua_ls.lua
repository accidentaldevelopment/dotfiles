vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      workspace = {
        -- disable "do you need to configure your workspace as luassert" prompts
        checkThirdParty = false,
      },
    },
  },
})
