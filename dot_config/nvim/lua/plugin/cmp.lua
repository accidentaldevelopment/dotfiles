--- @module 'lazy'
--- @type LazyPluginSpec[]
return {
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    version = 'v0.*',
    dependencies = {
      'folke/snacks.nvim',
      'folke/lazydev.nvim',
    },
    opts = function()
      --- @module "blink.cmp"
      --- @type blink.cmp.Config
      return {
        keymap = {
          preset = 'enter',
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-y>'] = { 'select_and_accept' },
        },
        cmdline = {
          completion = {
            menu = {
              auto_show = true,
            },
          },
          keymap = {
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
            ['<C-y>'] = { 'select_and_accept' },
          },
        },
        completion = {
          menu = {
            border = 'rounded',
          },
          list = {
            selection = { preselect = false },
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
        sources = {
          per_filetype = {
            lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
          },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
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
