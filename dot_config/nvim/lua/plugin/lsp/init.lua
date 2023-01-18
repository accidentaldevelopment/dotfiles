return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/trouble.nvim',
      'mason.nvim',
      { 'lvimuser/lsp-inlayhints.nvim', config = true },
      {
        'folke/neodev.nvim',
        opts = {
          override = function(root_dir, library)
            if root_dir:find('chezmoi/dot_config/nvim') then
              library.enabled = true
              library.plugins = true
            end
          end,
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'Attach LSP handler',
        callback = function(args)
          if not (args.data and args.data.client_id) then
            vim.notify('unable to execute LSP on_attach', vim.log.levels.WARN)
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufnr)
          end

          require('plugin.lsp.formatting').on_attach(client, bufnr)
          require('plugin.lsp.keymaps').on_attach(client, bufnr)
          require('lsp-inlayhints').on_attach(client, bufnr, false)
        end,
      })
    end,
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

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local ok, lsp_opts = pcall(require, 'plugin.lsp.settings.' .. server_name)
          if ok then
            require('lspconfig')[server_name].setup(vim.tbl_deep_extend('force', opts, lsp_opts))
          else
            require('lspconfig')[server_name].setup(opts)
          end
        end,
      })
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')

      return {
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.formatting.prettierd.with({ args = { '--prose-wrap=always', '$FILENAME' } }),
          nls.builtins.formatting.stylua,
          -- diagnostics.cspell,
          nls.builtins.diagnostics.eslint,
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.zsh,
        },
      }
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },
}
