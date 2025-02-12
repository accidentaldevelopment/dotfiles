return {
  {
    'nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'rust', 'toml' })
    end,
  },
  {
    'saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    opts = {
      popup = {
        border = 'rounded',
      },
      lsp = {
        enabled = true,
        name = 'crates',
        actions = true,
        completion = true,
        on_attach = function(_, bufnr)
          -- Override default K to show popup if available
          vim.keymap.set('n', 'K', function()
            local c = require('crates')
            if c.popup_available() then
              c.show_popup()
            else
              vim.lsp.buf.hover()
            end
          end, { buffer = bufnr, desc = 'Creates popup or hover' })
        end,
      },
    },
  },
  {
    'mason-tool-installer.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'rust-analyzer', 'taplo' })
    end,
  },
}
