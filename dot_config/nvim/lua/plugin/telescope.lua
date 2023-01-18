return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>bl', '<cmd>Telescope buffers<cr>', desc = 'Search buffers' },

    -- require('telescope.themes').get_dropdown({ previewer = false }))
    { '<leader>f', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>F', '<cmd>Telescope live_grep theme=ivy<cr>', desc = 'Find Text' },

    { '<leader>sb', '<cmd>Telescope git_branches<cr>', desc = 'Checkout branch' },
    { '<leader>sc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Find Help' },
    { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = 'Open Recent File' },
    { '<leader>sR', '<cmd>Telescope registers<cr>', desc = 'Registers' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },

    -- help
    { '<leader>ha', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
    { '<leader>hc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>hf', '<cmd>Telescope filetypes<cr>', desc = 'File Types' },
    { '<leader>hh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
    { '<leader>hk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
    { '<leader>hm', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>ho', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
    { '<leader>hs', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
    { '<leader>ht', '<cmd>Telescope builtin<cr>', desc = 'Telescope' },
  },
  opts = function()
    local actions = require('telescope.actions')

    return {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',

        mappings = {
          i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,

            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          },

          n = {
            ['q'] = actions.close,
          },
        },
      },
    }
  end,
}
