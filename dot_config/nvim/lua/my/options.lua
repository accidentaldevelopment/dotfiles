vim.o.backup = false -- creates a backup file
-- vim.o.clipboard = "unnamedplus", -- allows neovim to access the system clipboard
vim.o.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.hlsearch = true -- highlight all matches on previous search pattern
vim.o.ignorecase = true -- ignore case in search patterns
-- vim.o.mouse = "a"                             -- allow the mouse to be used in neovim
vim.o.pumheight = 10 -- pop up menu height
vim.o.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 2 -- always show tabs
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = true -- creates a swapfile
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- faster completion (4000ms default)
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.cursorline = true -- highlight the current line
vim.o.number = true -- set numbered lines
vim.o.relativenumber = true -- set relative numbered lines
vim.o.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
vim.o.wrap = false -- display lines as one long line
vim.o.scrolloff = 8 -- is one of my fav
vim.o.sidescrolloff = 8
vim.o.laststatus = 3

vim.opt.shortmess:append 'c'

vim.opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
-- vim.cmd 'set whichwrap+=<,>,[,],h,l'
-- vim.opt.whichwrap:prepend('<,>,[,],h,l')
-- vim.opt.whichwrap:prepend { '<', '>', '[', ']', }
vim.opt.whichwrap:prepend {
  ['<'] = true,
  ['>'] = true,
  ['['] = true,
  [']'] = true,
}
vim.opt.iskeyword:remove '-'
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- TODO: this doesn't seem to work
