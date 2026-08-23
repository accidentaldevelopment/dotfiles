local function activate_treesitter(lang, bufnr)
  if lang and vim.treesitter.language.add(lang) then
    vim.treesitter.start(bufnr, lang)
    vim.bo.indentexpr = require('nvim-treesitter').indentexpr
    if vim.wo.foldexpr == '0' then
      vim.wo.foldexpr = vim.treesitter.foldexpr
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('tree-sitter setup', { clear = true }),
  callback = function(args)
    local ft = args.match
    local lang = vim.treesitter.language.get_lang(ft)
    local ts = require('nvim-treesitter')
    if vim.tbl_contains(ts.get_available(), lang) then
      ts.install(lang):await(function()
        activate_treesitter(lang, args.buf)
      end)
    end
    -- activate_treesitter(lang, args.buf)
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.parsers').ghostty = {
      ---@diagnostic disable-next-line: missing-fields
      install_info = {
        url = 'https://github.com/bezhermoso/tree-sitter-ghostty',
        queries = 'queries/ghostty', -- also install queries from given directory
      },
    }
  end,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
      'andymass/vim-matchup',
      { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
      {
        'nvim-mini/mini.ai',
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
    init = function()
      require('vim.treesitter.query').add_predicate('is-mise?', function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ':t')
        return string.match(filename, '.*mise.*%.toml$') ~= nil
      end, { force = true, all = false })
    end,
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
      require('nvim-treesitter.parsers').ghostty = {
        install_info = {
          url = 'https://github.com/bezhermoso/tree-sitter-ghostty',
          queries = 'queries/ghostty', -- also install queries from given directory
        },
      }
    end,
  },
}
