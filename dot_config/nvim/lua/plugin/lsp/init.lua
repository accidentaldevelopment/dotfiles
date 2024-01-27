--- `true` if this version of nvim can show inlay hints.
local has_inlay_hints = vim.lsp['inlay_hint'] ~= nil

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Run when a language server is attached',
  callback = function(args)
    if not (args.data and args.data.client_id) then
      vim.notify('unable to execute LSP on_attach', vim.log.levels.WARN)
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      vim.notify('unable to get client', vim.log.levels.WARN)
      return
    end

    local bufnr = args.buf
    local methods = vim.lsp.protocol.Methods

    if client.supports_method(methods.textDocument_documentSymbol) then
      require('nvim-navic').attach(client, bufnr)
      require('nvim-navbuddy').attach(client, bufnr)
    end

    require('plugin.lsp.keymaps').on_attach(client, bufnr)
    if has_inlay_hints then
      if client and client.supports_method(methods.textDocument_inlayHint) then
        -- For some reason, inlay hints don't show up for me until InsertEnter. This defer resolves that.
        vim.defer_fn(function()
          vim.lsp.inlay_hint.enable(0, true)
        end, 500)
      end
    else
      require('lsp-inlayhints').on_attach(client, bufnr, false)
    end
  end,
})

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'SmiteshP/nvim-navic',
      {
        'SmiteshP/nvim-navbuddy',
        opts = function()
          local a = require('nvim-navbuddy.actions')
          return {
            mappings = {
              ['/'] = a.telescope({
                layout_config = {
                  height = 0.60,
                  width = 0.60,
                  prompt_position = 'top',
                  preview_width = 0.50,
                },
                layout_strategy = 'horizontal',
              }),
            },
          }
        end,
      },
      'b0o/schemastore.nvim',
      'mason.nvim',
      -- neoconf must be loaded _before_ an lsp
      {
        'folke/neoconf.nvim',
        opts = {
          import = {
            coc = false,
            nlsp = false,
          },
        },
      },
      {
        'lvimuser/lsp-inlayhints.nvim',
        cond = function()
          if has_inlay_hints and vim.version().prerelease == false then
            vim.notify('nvim now supports inlay hints. Remove lsp-inlayhints and related checks.', vim.log.levels.WARN)
          end
          return not has_inlay_hints
        end,
        config = true,
      },
      { 'folke/neodev.nvim', config = true },
    },
    config = function()
      vim.fn.sign_define({
        { name = 'DiagnosticSignError', text = '', texthl = 'DiagnosticSignError', numhl = '' },
        { name = 'DiagnosticSignWarn', text = '', texthl = 'DiagnosticSignWarn', numhl = '' },
        { name = 'DiagnosticSignHint', text = '', texthl = 'DiagnosticSignHint', numhl = '' },
        { name = 'DiagnosticSignInfo', text = '', texthl = 'DiagnosticSignInfo', numhl = '' },
      })

      vim.diagnostic.config({
        float = {
          border = 'rounded',
        },
        update_in_insert = true,
        severity_sort = true,
      })

      local opts = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      }

      require('lspconfig.ui.windows').default_options.border = 'rounded'

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local setup = require('lspconfig')[server_name].setup
          local ok, lsp_opts = pcall(require, 'plugin.lsp.settings.' .. server_name)
          if ok then
            setup(vim.tbl_deep_extend('force', opts, lsp_opts))
          else
            setup(opts)
          end
        end,
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      optional = true,
      opts = {
        ensure_installed = {},
      },
    },
    cmd = 'Mason',
    keys = { { '<leader>M', '<cmd>Mason<cr>', desc = 'Show Mason' } },
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        -- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        border = 'rounded',
        sources = {
          nls.builtins.diagnostics.eslint_d,
          nls.builtins.diagnostics.fish,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    keys = {
      { '<localleader>f', '<cmd>Format<cr>', desc = 'Format buffer' },
      { '<localleader>F', '<cmd>FormatOnSave!<cr>', desc = 'Toggle format on save' },
    },
    opts = {
      format_on_save = function()
        require('formatting').format()
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
      },
    },
  },
}
