local util = require('util')

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

-- Navigate buffers
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>')

-- Insert --
-- Press jk fast to enter
vim.keymap.set('i', 'jk', '<ESC>')

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

-- toggle options
vim.keymap.set('n', '<leader>ts', function()
  util.toggle('spell')
end, { desc = 'Spelling' })
vim.keymap.set('n', '<leader>tn', function()
  util.toggle('relativenumber', true)
end, { desc = 'Line Numbers' })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set('n', '<leader>tc', function()
  util.toggle('conceallevel', false, { 0, conceallevel })
end, { desc = 'Conceal' })

-- localleader toggles
vim.keymap.set('n', '<localleader>s', function()
  util.toggle('spell')
end, { desc = 'Spelling' })
vim.keymap.set('n', '<localleader>r', function()
  util.toggle('relativenumber', true)
end, { desc = 'Line Numbers' })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set('n', '<localleader>c', function()
  util.toggle('conceallevel', false, { 0, conceallevel })
end, { desc = 'Conceal' })

vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>c', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Visual Block --
-- Move text up and down
--keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
--keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
