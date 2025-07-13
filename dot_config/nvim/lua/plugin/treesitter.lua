return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
      'andymass/vim-matchup',
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        init = function()
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      {
        'echasnovski/mini.ai',
        opts = function()
          local ai = require('mini.ai')
          return {
            n_lines = 500,
            custom_textobjects = {
              o = ai.gen_spec.treesitter({ -- code block
                a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                i = { '@block.inner', '@conditional.inner', '@loop.inner' },
              }),
              f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
              c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
              t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
              d = { '%f[%d]%d+' }, -- digits
              e = { -- Word with case
                { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
                '^().*()$',
              },
              u = ai.gen_spec.function_call(), -- u for "Usage"
              U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
            },
          }
        end,
      },
    },
    opts = {
      ensure_installed = {
        'bash',
        'json',
        'kdl',
        'lua',
        'markdown',
        'markdown_inline',
        'regex',
        'vim',
        'vimdoc',
      },
    },
    config = function(_, opts)
      require('nvim-treesitter').install(opts.ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('tree-sitter setup', { clear = true }),
        callback = function(args)
          local ft = args.match
          local lang = vim.treesitter.language.get_lang(ft)
          if lang and vim.treesitter.language.add(lang) then
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            if vim.wo.foldexpr == '0' then
              vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            end
          end
        end,
      })

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
