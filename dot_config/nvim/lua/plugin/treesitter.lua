return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'p00f/nvim-ts-rainbow',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'help',
        'json',
        'lua',
        'rust',
        'vim',
      }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
        extended_mode = true,
      },
    })

    require('treesitter-context').setup({
      patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
          'class',
          'function',
          'method',
          -- 'for', -- These won't appear in the context
          -- 'while',
          -- 'if',
          -- 'switch',
          -- 'case',
        },
        rust = {
          'match',
        },
      },
    })

    -- Folding options
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    -- Don't fold everything at startup
    vim.o.foldlevelstart = 99
    vim.o.foldcolumn = 'auto:3'
    vim.opt.fillchars:append({
      foldopen = '▼',
      -- foldsep = '|',
      foldclose = '▶',
    })
  end,
}
