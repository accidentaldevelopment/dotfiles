-- --Remap space as leader key
-- keymap('', '<Space>', '<Nop>', opts)
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)

-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

vim.keymap.set('n', '<C-i>', '<C-i>')

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move text up and down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('v', 'p', '"_dP')

vim.keymap.set('n', '<leader>ot', function()
  require('lazy.util').float_term()
end, { desc = 'Terminal' })
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
