set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vim/.vimrc.before"))
  source ~/.vim/.vimrc.before
endif

" Color schemes
colorscheme solarized
if has('gui_running')
  set background=light
else
  set background=dark
endif

" Remap esc to <j-j>
ino jk <esc>
cno jk <c-c>
vno v <esc>
nnoremap jk <esc>

" Remap cycling through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-m> :bprevious<CR>
" Keep yank consistent with Delete to eol
nnoremap Y y$

" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set nobackup                    "Backup files tend to get in the way
set noswapfile                  "Same as above

" This needs to exist so the 'j' key is still snappy in normal
" mode due to the fact that 'jk' replaces <esc>
set timeout
set timeoutlen=100
set ttimeoutlen=100

" Enable whitespace strip on save
let g:strip_whitespace_on_save = 1
" Uncomment below line to change color for whitespace
" highlight ExtraWhitespace ctermbg=<desired_color>

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
"
" Don’t add empty newlines at the end of files
set binary
set noeol

" More Intuituve split positions
set splitbelow
set splitright

" Turn on syntax highlighting
syntax on
set cursorline

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
let mapleader=","
nmap <Leader>n :NERDTreeToggle<CR>

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points
set smartcase    "Search better

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
nmap <silent> ,/ :nohlsearch<CR>

" ================ History ==========================
set history=1000
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class

" YOU WILL NOT USE ARROW KEYS!!
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <esc> <nop>

" Lets us edit a file that requires root privs
" once it's already open (think /etc/hosts)
cmap w!! w !sudo tee % >/dev/null

" Move visual block on scroll
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" opens .vimrc in split for easy editing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source .vimuu
nnoremap <leader>sv :source $MYVIMRC<cr>
"surround work in quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" Plugin mappings in here
if filereadable(expand("~/.vim/.vimrc.after"))
  source ~/.vim/.vimrc.after
endif