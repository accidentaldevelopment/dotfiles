--- @module 'lazy'
--- @type LazyPluginSpec[]
return {
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    version = 'v0.*',
    dependencies = {
      'folke/snacks.nvim',
    },
    opts = function()
      --- @type blink.cmp.Config
      return {
        keymap = {
          preset = 'enter',
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-y>'] = { 'select_and_accept' },
        },
        completion = {
          menu = {
            border = 'rounded',
          },
          list = {
            selection = 'manual',
          },
          trigger = {
            show_on_insert_on_trigger_character = false,
          },
          documentation = {
            auto_show = true,
            window = {
              border = 'rounded',
            },
          },
          ghost_text = {
            enabled = true,
          },
        },
        appearance = {
          kind_icons = vim.iter(ipairs(vim.lsp.protocol.CompletionItemKind)):fold({}, function(acc, _, k)
            local i = Snacks.util.icon(k, 'lsp')
            acc[k] = i
            return acc
          end),
        },
      }
    end,
  },
}
