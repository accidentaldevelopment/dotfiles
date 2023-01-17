return {
  'folke/todo-comments.nvim',
  event = 'BufReadPost',
  keys = {
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous todo comment',
    },
    -- { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo Trouble' },
    -- { '<leader>xtt', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo Trouble' },
    -- { '<leader>xT', '<cmd>TodoTelescope<cr>', desc = 'Todo Telescope' },
  },
  config = true,
}
