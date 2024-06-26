local kind_icons = {
  Text = '󰉿',
  Method = 'm',
  Function = '󰡱',
  Constructor = '',
  Field = '',
  Variable = '󰆧',
  Class = '󰌗',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰇽',
  Struct = '',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '󰊄',

  -- cargo stuff
  Version = 'v',
  Feature = 'f',
}

---@class CmpConfigs
---@field global cmp.ConfigSchema
---@field search cmp.ConfigSchema
---@field ex cmp.ConfigSchema

return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require('cmp')
      return {
        global = {
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
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
            fields = { 'kind', 'abbr', 'menu' },
            ---@param entry cmp.Entry
            ---@param vim_item vim.CompletedItem
            ---@return vim.CompletedItem
            format = function(entry, vim_item)
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
              else
                vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
              end
              return vim_item
            end,
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
          },
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

      cmp.setup(opts.global)

      cmp.setup.cmdline(':', opts.ex)

      cmp.setup.cmdline({ '/', '?' }, opts.search)
    end,
  },
}
