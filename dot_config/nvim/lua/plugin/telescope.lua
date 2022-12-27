return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup({})
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
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
      pickers = {
        lsp_code_actions = {
          theme = 'cursor',
        },
      },
    })
  end,
}
