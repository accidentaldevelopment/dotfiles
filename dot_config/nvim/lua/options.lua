vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.backup = false -- creates a backup file
vim.o.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.cursorline = true -- highlight the current line
vim.o.expandtab = true -- convert tabs to spaces
vim.o.exrc = true
vim.o.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.hlsearch = true -- highlight all matches on previous search pattern
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.number = true -- set numbered lines
vim.o.pumheight = 10 -- pop up menu height
vim.o.relativenumber = true -- set relative numbered lines
vim.o.scrolloff = 8 -- is one of my fav
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 0 -- never show tabline
vim.o.sidescrolloff = 8
vim.o.signcolumn = 'yes:3' -- always show the sign column, otherwise it would shift the text each time
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = true -- creates a swapfile
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- faster completion (4000ms default)
vim.o.winborder = 'rounded'
vim.o.wrap = true
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.shortmess:append('c')

vim.opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
-- vim.cmd 'set whichwrap+=<,>,[,],h,l'
-- vim.opt.whichwrap:prepend('<,>,[,],h,l')
-- vim.opt.whichwrap:prepend { '<', '>', '[', ']', }
vim.opt.whichwrap:prepend({
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true,
})
vim.opt.iskeyword:remove('-')
vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) -- TODO: this doesn't seem to work
