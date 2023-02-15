return {
  {
    'gpanders/editorconfig.nvim',
    event = 'BufReadPre',
    --- @param plugin LazyPlugin
    init = function(plugin)
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LspProgressUpdate',
        desc = 'remind me to remove this plugin when 0.9 is released',
        callback = function()
          if package.loaded.notify then
            if vim.version().minor > 8 then
              vim.notify('remove plugin: ' .. plugin.name, vim.log.levels.WARN)
            end
            return true
          end
        end,
      })
    end,
    cond = function()
      return vim.version().minor < 9
    end,
  },
  {
    'alker0/chezmoi.vim',
    priority = 9900,
    lazy = false,
    cond = false,
    ---  @param plugin LazyPlugin
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
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cmd = 'Neotree',
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Explorer' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    opts = {
      use_popups_for_input = false,
      window = {
        mappings = {
          ['<space>'] = 'none',
        },
      },
      default_component_configs = {
        name = {
          trailing_slash = true,
        },
      },
    },
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', mode = { 'n', 'v' }, desc = 'Leap forward' },
      { 'S', mode = { 'n', 'v' }, desc = 'Leap backward' },
      { 'x', mode = { 'v' }, desc = 'Leap forward (exclude match)' },
      { 'X', mode = { 'v' }, desc = 'Leap backward (exclude match)' },
    },
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = {
        spelling = {
          enabled = true,
        },
      },
      window = {
        border = 'rounded', -- none, single, double, shadow
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register({
        mode = { 'n', 'v' },
        g = { name = 'goto' },
        gz = { name = 'surround' },
        [']'] = { name = 'next' },
        ['['] = { name = 'prev' },
        ['<leader><tab>'] = { name = 'tabs' },
        ['<leader>L'] = { require('lazy').home, 'Show Lazy' },
        ['<leader>b'] = { name = 'buffer' },
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
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    opts = { delay = 200 },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>c',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Close Buffer',
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
    },
  },
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'BufReadPost',
    config = true,
    -- stylua: ignore
    keys = {
      { ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment', },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment', },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>xtt", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
      { "<leader>xT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    },
  },
}
