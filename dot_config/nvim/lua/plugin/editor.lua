return {
  {
    'alker0/chezmoi.vim',
    priority = 9900,
    lazy = false,
    cond = false,
    --- @param plugin LazyPlugin
    init = function(plugin)
      for _, a in ipairs(vim.fn.argv()) do
        if a:find('chezmoi-edit', 1, true) ~= nil then
          vim.notify('enabling chezmoi', vim.log.levels.INFO)
          plugin.cond = true
          return nil
        end
      end
    end,
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
    opts = {
      window = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register({
        mode = { 'n', 'v' },
        g = { name = 'goto' },
        s = { name = 'surround' },
        [']'] = { name = 'next' },
        ['['] = { name = 'prev' },
        ['<leader><tab>'] = { name = 'tabs' },
        ['<leader>L'] = { require('lazy').home, 'Show Lazy' },
        ['<leader>g'] = { name = 'git' },
        ['<leader>gh'] = { name = 'hunks' },
        ['<leader>o'] = { name = 'open' },
        ['<leader>s'] = { name = 'search' },
        ['<leader>t'] = { name = 'toggle' },
        ['<leader>x'] = { name = 'diagnostics/quickfix' },
      })
    end,
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
      { '<c-s>', '<cmd>Grapple toggle<cr>', desc = 'Toggle tag' },
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
}
