return {
  {
    'nvim-tree/nvim-web-devicons',
    dependencies = 'DaikyXendo/nvim-material-icon',
    opts = {},
  },
  {
    'echasnovski/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          local mf = require('mini.files')
          if vim.bo.filetype == 'minifiles' then
            mf.close()
          else
            local file = vim.api.nvim_buf_get_name(0)
            local file_exists = vim.fn.filereadable(file) ~= 0
            mf.open(file_exists and file or nil)
            mf.reveal_cwd()
          end
        end,
        desc = 'Explorer',
      },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      mappings = {
        go_in_plus = '<CR>',
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    --- @type wk.Opts
    opts = {
      preset = 'helix',
      win = {
        border = 'rounded',
      },
      spec = {
        mode = { 'n', 'v' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>L', '<cmd>Lazy<cr>', desc = 'Show Lazy' },
        { '<leader>g', group = 'git' },
        { '<leader>o', group = 'open' },
        { '<leader>s', group = 'search' },
        { '<leader>t', group = 'toggle' },
        { 'g', group = 'goto' },
        { 's', group = 'surround' },
        { ']', group = 'next' },
        { '[', group = 'prev' },
      },
    },
  },
  {
    'echasnovski/mini.cursorword',
    event = 'BufReadPost',
    config = true,
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<localleader>w',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<localleader>W',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Force Delete Buffer',
      },
    },
  },
  -- trouble
  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      local hipatterns = require('mini.hipatterns')
      ---@param words string[] Words
      local function w(words)
        return vim
          .iter(ipairs(words))
          :map(function(_, v)
            return '%f[%w]()' .. vim.pesc(v) .. '()%f[%W]'
          end)
          :totable()
      end

      local function comment(group)
        return function(bufnr, _, data)
          local captures = vim
            .iter(vim.treesitter.get_captures_at_pos(bufnr, data.line - 1, data.from_col - 1))
            :map(function(v)
              return v.capture
            end)
          if captures:find('comment') then
            return group
          end
        end
      end

      return {
        highlighters = {
          fixme = { pattern = w({ 'FIXME' }), group = comment('MiniHipatternsFixme') },
          hack = { pattern = w({ 'HACK' }), group = comment('MiniHipatternsHack') },
          todo = { pattern = w({ 'TODO' }), group = comment('MiniHipatternsTodo') },
          note = { pattern = w({ 'NOTE' }), group = comment('MiniHipatternsNote') },
          safety = { pattern = w({ 'SAFETY' }), group = comment('MiniHipatternsHack') },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  { 'mrjones2014/smart-splits.nvim', lazy = false },
  {
    'cbochs/grapple.nvim',
    keys = {
      { ';', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },
      { '<localleader>g', '<cmd>Grapple toggle<cr>', desc = 'Toggle tag' },
    },
    cmd = 'Grapple',
    opts = {
      scope = 'git_branch',
      win_opts = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      require('telescope').load_extension('grapple')
      require('grapple').setup(opts)
    end,
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = 'markdown',
    cmd = {
      'RenderMarkdown',
    },
    opts = {
      anti_conceal = {
        enabled = false,
      },
    },
  },
}
