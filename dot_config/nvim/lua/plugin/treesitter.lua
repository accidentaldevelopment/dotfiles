return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = true,
      },
      'HiPhish/nvim-ts-rainbow2',
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
        'rust',
        'vim',
        'vimdoc',
      },
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { '' }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { '' }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true, disable = { 'yaml' } },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      rainbow = {
        enable = true,
      },
      matchup = {
        enable = true,
        include_match_words = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)

      -- -- Folding options
      -- vim.o.foldmethod = 'expr'
      -- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      -- -- Don't fold everything at startup
      -- vim.o.foldlevelstart = 99
      -- vim.o.foldcolumn = 'auto:3'
      -- vim.opt.fillchars:append({
      --   foldopen = '▼',
      --   -- foldsep = '|',
      --   foldclose = '▶',
      -- })
    end,
  },
}
