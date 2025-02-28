vim.lsp.config('jsonls', {
  --- @module "neoconf"
  --- @type neoconf.
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})
