local kind_icons = setmetatable({
  -- cargo stuff
  -- Version = 'v',
  -- Feature = 'f',
}, {
  __index = function(t, k)
    t[k] = string.format('%s ', require('mini.icons').get('lsp', vim.lsp.protocol.CompletionItemKind[k]))
    return t[k]
  end,
})

---@module "cmp"
---@class CmpConfigs
---@field global cmp.ConfigSchema
---@field search cmp.ConfigSchema
---@field ex cmp.ConfigSchema

--- @module "lazy.nvim"
--- @type LazyPluginSpec[]
return {
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    version = 'v0.*',
    --- @module "blink.cmp"
    --- @type blink.cmp.Config
    --- @diagnostic disable: missing-fields
    opts = {
      keymap = {
        accept = { '<cr>', '<tab>' },
        select_prev = { '<Up>', '<C-k>' },
        select_next = { '<Down>', '<C-j>' },
      },
      windows = {
        autocomplete = {
          border = 'rounded',
        },
        documentation = {
          border = 'rounded',
        },
      },
      highlight = {
        use_nvim_cmp_as_default = true,
      },
    },
    --- @diagnostic enable: missing-fields
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        global = {
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
            }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          formatting = {
            ---@param entry cmp.Entry
            ---@param vim_item vim.CompletedItem
            ---@return vim.CompletedItem
            format = function(entry, vim_item)
              vim_item.kind = kind_icons[entry:get_kind()]
              return vim_item
            end,
          },
          -- sources = {
          --   { name = 'nvim_lsp' },
          --   { name = 'nvim_lsp_signature_help' },
          --   { name = 'buffer' },
          --   { name = 'path' },
          -- },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          experimental = { ghost_text = true },
          view = {
            entries = {
              follow_cursor = true,
            },
          },
        },
        search = {
          sources = {
            { name = 'buffer' },
          },
        },
        ex = {
          sources = {
            { name = 'path' },
            { name = 'cmdline' },
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')

      -- cmp.setup(opts.global)

      cmp.setup.cmdline(':', vim.tbl_deep_extend('force', opts.global, opts.ex))

      cmp.setup.cmdline({ '/', '?' }, vim.tbl_deep_extend('force', opts.global, opts.search))
    end,
  },
}
