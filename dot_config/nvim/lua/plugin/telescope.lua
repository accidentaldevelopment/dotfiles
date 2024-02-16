return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>b', '<cmd>Telescope buffers<cr>', desc = 'Search buffers' },

    -- require('telescope.themes').get_dropdown({ previewer = false }))
    { '<leader>f', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Find files' },
    { '<leader>/', '<cmd>Telescope live_grep theme=ivy<cr>', desc = 'Search' },
    { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command history' },

    -- search
    { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>sR', '<cmd>Telescope registers<cr>', desc = 'Registers' },
    { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
    { '<leader>sb', '<cmd>Telescope git_branches<cr>', desc = 'Checkout branch' },
    { '<leader>sc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>sc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>sf', '<cmd>Telescope filetypes<cr>', desc = 'File Types' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Find Help' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    { '<leader>sm', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
    { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = 'Open Recent File' },
    { '<leader>ss', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
    { '<leader>st', '<cmd>Telescope builtin<cr>', desc = 'Telescope' },
  },
  opts = function()
    local actions = require('telescope.actions')

    return {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',

        path_display = { 'smart' },

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
