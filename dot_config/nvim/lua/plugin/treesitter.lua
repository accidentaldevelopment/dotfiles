return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'andymass/vim-matchup',
    },
    opts = {
      ensure_installed = {
        'bash',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'regex',
        'vim',
        'vimdoc',
      },
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { 'yaml' } },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      matchup = {
        enable = true,
        include_match_words = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)

      -- function _G._foldtext()
      --   local text = vim.treesitter.foldtext()
      --   if type(text) == 'table' then
      --     local nlines = vim.v.foldend - vim.v.foldstart
      --     local closer = vim.api.nvim_buf_get_lines(0, vim.v.foldend - 1, vim.v.foldend, true)
      --     table.insert(text, { ' ', 'Normal' })
      --     table.insert(text, { string.format('+%d lines', nlines), { '@comment' } })
      --     table.insert(text, { ' ', 'Normal' })
      --     table.insert(text, { closer[1]:match('^%s*(.-)%s*$') })
      --   end
      --   return text
      -- end
      --
      -- -- Folding options
      -- vim.o.foldmethod = 'expr'
      -- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.o.foldtext = 'v:lua._foldtext()'
      -- -- Don't fold everything at startup
      -- vim.o.foldlevel = 99
      -- vim.o.foldlevelstart = 99
      -- vim.o.foldcolumn = 'auto:3'
      -- vim.opt.fillchars:append({
      --   foldopen = '▼',
      --   foldclose = '▶',
      --   fold = ' ',
      -- })
    end,
  },
}
