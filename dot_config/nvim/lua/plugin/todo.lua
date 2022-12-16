return {
  'folke/todo-comments.nvim',
  config = function()
    require('todo-comments').setup()
    -- FIX: Key bindings don't work for me currently
    --
    -- vim.keymap.set('n', ']t', function()
    --   require('todo-comments').jump_next()
    -- end, { desc = 'Next todo comment' })
    --
    -- vim.keymap.set('n', '[t', function()
    --   require('todo-comments').jump_prev()
    -- end, { desc = 'Previous todo comment' })
  end,
}
