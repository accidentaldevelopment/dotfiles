local which_key = require 'which-key'

which_key.setup {
  plugins = {
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
  },
  window = {
    border = 'rounded', -- none, single, double, shadow
  },
}

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
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Navigate buffers
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')

-- Move text up and down
vim.keymap.set('n', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('n', '<A-k>', '<Esc>:m .-2<CR>==gi')

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

local leader_mappings = {
  ['a'] = { '<cmd>AerialToggle!<cr>', 'Aerial' },
  ['b'] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    'Buffers',
  },
  ['e'] = { '<cmd>Neotree toggle<cr>', 'Explorer' },
  ['w'] = { '<cmd>w!<CR>', 'Save' },
  ['q'] = { '<cmd>q!<CR>', 'Quit' },
  ['c'] = { '<cmd>Bdelete!<CR>', 'Close Buffer' },
  ['h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
  ['f'] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    'Find files',
  },
  ['F'] = { '<cmd>Telescope live_grep theme=ivy<cr>', 'Find Text' },
  ['P'] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", 'Projects' },

  p = {
    name = 'Packer',
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    s = { '<cmd>PackerSync<cr>', 'Sync' },
    S = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
  },

  s = {
    name = 'Search',
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
    h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    R = { '<cmd>Telescope registers<cr>', 'Registers' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
  },

  t = {
    name = 'Terminal',
    n = { '<cmd>lua _NODE_TOGGLE()<cr>', 'Node' },
    u = { '<cmd>lua _NCDU_TOGGLE()<cr>', 'NCDU' },
    t = { '<cmd>lua _HTOP_TOGGLE()<cr>', 'Htop' },
    p = { '<cmd>lua _PYTHON_TOGGLE()<cr>', 'Python' },
    f = { '<cmd>ToggleTerm direction=float<cr>', 'Float' },
    h = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', 'Horizontal' },
    v = { '<cmd>ToggleTerm size=80 direction=vertical<cr>', 'Vertical' },
  },
}

which_key.register(leader_mappings, { prefix = '<leader>'})
which_key.register({g = {name = '+goto'}})
