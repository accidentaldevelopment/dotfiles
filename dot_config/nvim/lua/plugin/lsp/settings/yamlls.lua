return {
  settings = {
    yaml = {
      schemaStore = {
        -- Must disable built-in schemaStore support if you want to use
        -- schemastore.
        enable = false,
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
