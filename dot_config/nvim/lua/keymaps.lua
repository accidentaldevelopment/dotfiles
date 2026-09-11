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
