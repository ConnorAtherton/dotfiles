vim.opt.backup = false

-- Line numbers are good
vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.ttyfast = true
vim.opt.lazyredraw = true
vim.opt.updatetime = 750

-- This needs to exist so the 'j' key is still snappy in normal
-- mode due to the fact that 'jk' replaces <esc>
vim.opt.timeout = true
vim.opt.timeoutlen=100
vim.opt.ttimeoutlen=100

vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window

--
-- ================ Wrapping ============================
--
vim.opt.wrap = false             -- Don't wrap lines
vim.opt.textwidth = 120      -- But wrap text object at 100 chars
vim.opt.nuw=3              -- Bump line numbers alongs to have some space on the left
vim.opt.formatoptions=qrn1
vim.opt.colorcolumn= "120"    -- Show long lines
vim.opt.linebreak = true          -- Wrap lines at convenient points


-- Turn on syntax highlighting
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"

--
-- ================ Scrolling ========================
--
vim.opt.scrolloff = 10         -- Start scrolling when we're 10 lines away from margins
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1

vim.opt.shortmess:append "I"

--
-- Look and Feel
--
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymo

--
-- Globals
--
vim.g.completeopt="menu,menuone,noselect,noinsert"
