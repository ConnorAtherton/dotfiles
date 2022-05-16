local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Comma is king (muscle memory seems to think so)
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- No arrow keys
keymap("", "<up>", "<Nop>", opts)
keymap("", "<down>", "<Nop>", opts)
keymap("", "<left>", "<Nop>", opts)
keymap("", "<right>", "<Nop>", opts)

-- Fast saving
keymap("n", "<leader>w", ":w!<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-n>", ":bnext<CR>", opts)
keymap("n", "<C-m>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":Bclose<CR>", opts)

-- Fast escape
keymap("i", "jk", "<ESC>", opts)

-- Splits
keymap("n", "<leader>vs", ":vsplit<CR>", opts)
keymap("n", "<leader>hs", ":split<CR>", opts)

-- Lets us edit a file that requires root privs
-- once it's already open (think /etc/hosts)
keymap("n", "w!!", "w !sudo tee % >/dev/null", opts)

-- File explorer
keymap("n", "<leader>n", ":NERDTreeToggle<CR>", opts)

-- Default file searchers
keymap("n", "<leader>f", ":GFiles<CR>", opts)
keymap("n", "<leader>b", ":Buffers<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Show tags through tagbar
keymap("n", "<leader>.", ":Vista<CR>", opts)
