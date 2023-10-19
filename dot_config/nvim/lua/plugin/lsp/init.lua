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

    if client.name == 'null-ls' then
      local ft = vim.bo[bufnr].filetype
      for _, nls in ipairs(require('null-ls').get_source({ filetype = ft })) do
        require('util').lang_tools.register(nls.name, bufnr)
      end
    else
      require('util').lang_tools.register(client.name, bufnr)
    end

    if client.supports_method(methods.textDocument_documentSymbol) then
      require('nvim-navic').attach(client, bufnr)
      require('nvim-navbuddy').attach(client, bufnr)
    end

    require('plugin.lsp.formatting').on_attach(client, bufnr)
    require('plugin.lsp.keymaps').on_attach(client, bufnr)
    if has_inlay_hints then
      if client and client.supports_method(methods.textDocument_inlayHint) then
        -- For some reason, inlay hints don't show up for me until InsertEnter. This defer resolves that.
        vim.defer_fn(function()
          vim.lsp.inlay_hint(0, true)
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
      'folke/trouble.nvim',
      'SmiteshP/nvim-navic',
      'SmiteshP/nvim-navbuddy',
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
          nls.builtins.formatting.fish_indent,
          nls.builtins.formatting.prettierd.with({ args = { '--prose-wrap=always', '$FILENAME' } }),
          nls.builtins.formatting.stylua,

          nls.builtins.diagnostics.eslint,
          nls.builtins.diagnostics.fish,
        },
      }
    end,
  },
}
