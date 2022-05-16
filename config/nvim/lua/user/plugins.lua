local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
  -- Search and file navigation
  -- Plug 'rking/ag.vim', { 'on': 'Ag' }
  Plug('preservim/nerdtree', { on = 'NERDTreeToggle' })
  Plug('Xuyuanp/nerdtree-git-plugin')
  Plug('kien/ctrlp.vim')
  Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
  Plug('junegunn/fzf.vim')
  -- Auto bracket completion
  Plug('jiangmiao/auto-pairs')

  -- #tpope
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'

  -- Look and feel
  -- Plug 'vim-airline/vim-airline'
  -- Plug 'vim-airline/vim-airline-themes'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'airblade/vim-gitgutter'
  Plug 'tomtom/tlib_vim'

  -- Useful tools and syntax stuff
  Plug('ap/vim-css-color', { ['for'] = 'sass, css'  })
  Plug 'scrooloose/syntastic'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'w0rp/ale'
  Plug 'rhysd/conflict-marker.vim'

  -- Autocompletion
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  -- Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install --user pynvim' }
  -- Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

  -- Language support
  Plug 'neomake/neomake'
  Plug 'pangloss/vim-javascript'
  Plug 'racer-rust/vim-racer'

  -- Syntax highlighting
  Plug('ConnorAtherton/uiscript-vim', { ['for'] = 'uiscript' })
  Plug 'sheerun/vim-polyglot'

  -- For CTags
  -- Plug 'majutsushi/tagbar'

  -- Writing, note taking, diagramming
  Plug 'suan/vim-instant-markdown'
  Plug('junegunn/goyo.vim', { on = 'Goyo' })
  Plug('junegunn/limelight.vim', { on = 'Goyo' })
  Plug('mtth/scratch.vim', { on = 'Scratch' })
  Plug 'vim-scripts/DrawIt'

  -- Color schemes
  -- Plug '~/dotfiles/.vim/custom_themes/seoul256.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug '~/dotfiles/.vim/custom_themes/catherton'

  -- (here down) Newer neovim plugins
  Plug "neovim/nvim-lspconfig"

  -- file picker (think fzf in vim)
  Plug "nvim-telescope/telescope.nvim"
  Plug "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  Plug "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  Plug("nvim-treesitter/nvim-treesitter", {['do'] = vim.fn['TSUpdate']})
  Plug "kyazdani42/nvim-tree.lua"
  Plug "williamboman/nvim-lsp-installer"
  Plug 'liuchengxu/vista.vim' -- LSP tags integration
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  -- Trying a new spippet thing
  -- Plug 'SirVer/ultisnips'
  -- Plug 'honza/vim-snippets'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
vim.call('plug#end')

-- TODO: Wrap all these plugin configs in guard code in case the plugin is not installed
-- local loaded, plugin = pcall(require, "plugin_name")
-- if not loaded then
--   return
-- end

require('nvim-tree').setup {
  view = {
    side = "left",
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "javascript", "graphql", "go" },
  highlight = {
    enable = true,
  },
}

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { "NvimTree", "nerdtree", "Outline" },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Language Server Support
-- The installer must come before any lspconfig setup (we don't want the installer doing the installing for us since we
-- like to manage that with how we configure everything else on our dev machine)
require("nvim-lsp-installer").setup({
    automatic_installation = false,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local cmp = require'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
      })
  })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
  })

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').gopls.setup{
  capabilities = capabilities
}

require('lspconfig').sorbet.setup{
}
