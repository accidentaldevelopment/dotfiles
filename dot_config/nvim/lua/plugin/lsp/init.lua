vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
  float = {
    border = 'rounded',
  },
  jump = {
    float = true,
  },
  update_in_insert = true,
  severity_sort = true,
  virtual_text = true,
})

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

    if client:supports_method(methods.textDocument_documentSymbol) then
      require('nvim-navic').attach(client, bufnr)
      require('nvim-navbuddy').attach(client, bufnr)
    end

    require('plugin.lsp.keymaps').on_attach(client, bufnr)
    if client:supports_method(methods.textDocument_inlayHint) then
      -- For some reason, inlay hints don't show up for me until InsertEnter. This defer resolves that.
      vim.defer_fn(function()
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end, 500)
    end
  end,
})

require('plugin.lsp.rename_handler')

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'SmiteshP/nvim-navic',
      {
        'SmiteshP/nvim-navbuddy',
        opts = {},
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
        'williamboman/mason-lspconfig.nvim',
      },
    },
    config = function()
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      -- Language servers that aren't installed via mason.
      for _, ls in ipairs({ 'denols', 'nushell' }) do
        vim.lsp.config(ls, {})
        require('lspconfig')[ls].setup(vim.lsp.config[ls])
      end

      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          vim.lsp.config(server_name, {})
          require('lspconfig')[server_name].setup(vim.lsp.config[server_name])
        end,
      })
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { '<localleader>f', '<cmd>Format!<cr>', desc = 'Format buffer (force)' },
      { '<localleader>F', '<cmd>FormatOnSave!<cr>', desc = 'Toggle format on save' },
    },
    opts = {
      format_on_save = function()
        require('formatting').format()
      end,
      default_format_opts = {
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        fish = { 'fish_indent' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        json = { 'prettierd' },
        jsonc = { 'prettierd' },
        scss = { 'prettierd' },
        markdown = { 'prettierd', 'injected' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason.nvim' },
    ---@param p LazyPlugin
    ft = function(p)
      return vim.tbl_keys(p.opts.linters_by_ft)
    end,
    opts = {
      linters_by_ft = {
        fish = { 'fish' },
      },
    },
    config = function(_, opts)
      require('lint').linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('Linting', { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].ft

          if opts.linters_by_ft[ft] then
            require('lint').try_lint()
          end
        end,
      })
    end,
  },
}
