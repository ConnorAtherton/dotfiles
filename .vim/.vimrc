set nocompatible

" Don't show intro
set shortmess+=I

" Set the Ruby path correctly
let g:ruby_path = system('echo $HOME/.rbenv/shims')

"
" Color schemes
"
" TODO: change color scheme based on time of day
" TODO: Sync up color scheme with terminal
"
" if strftime("%H") > 12
"   colorscheme seoul256-light
"   set background=light
" else
"   colorscheme seoul256
"   set background=dark
" endif

colorscheme seoul256
set background=dark

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
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set backspace=indent,eol,start

" Backup files get in the way
set nobackup
set noswapfile
set nowritebackup

" Show line numbers relative to the current line
set number "ine numbers are good
set relativenumber " Display how far away each line is from the current one

" This needs to exist so the 'j' key is still snappy in normal
" mode due to the fact that 'jk' replaces <esc>
set timeout
set timeoutlen=100
set ttimeoutlen=100

" Uncomment below line to change color for whitespace
" highlight ExtraWhitespace ctermbg=<desired_color>

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Look and feel
set ttyfast
set lazyredraw

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

"
" ================ Indentation ======================
"
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

"
" ================ Wrapping ============================
"
set nowrap             " Don't wrap lines
set textwidth=100      " But wrap text object at 100 chars
set formatoptions=qrn1
set colorcolumn=100    " Show long lines
set linebreak          " Wrap lines at convenient points

"
" ================ Folds ============================
"

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"
" ================ Scrolling ========================
"

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"
" ================ Search ===========================
"

set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set smartcase    "Search better
set ignorecase
set smartcase
set gdefault " replace every occurence on the line by default
set incsearch
set showmatch
set hlsearch

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.rsync*,*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*/dist/*,*/vendor/*,*/bower/*,*/node_modules/*

nmap <silent> ,/ :nohlsearch<CR>

" make tab match brackets
nnoremap <tab> %
vnoremap <tab> %

"
" ================ History ==========================
"

set history=1000
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class

" YOU WILL NOT USE ARROW KEYS!!
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Lets us edit a file that requires root privs
" once it's already open (think /etc/hosts)
nnoremap w!! w !sudo tee % >/dev/null

" Move visual block on scroll
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>vs :vsplit<cr>

" opens .vimrc in split for easy editing
nnoremap <leader>ev :vsplit $VIMRC<cr>
" source .vimrc
nnoremap <leader>sv :source $VIMRC<cr>
" opens a new vsplit
" opens a new vsplit
nnoremap <leader>hs :split<cr>
" Start using ag and place cursor in the quotes
nnoremap <leader>s :Ag ""<Left>
" I want to go to the first character far more often
" than the beginning of the line so let's switch
nnoremap 0 ^
nnoremap ^ 0

"
" ================ Autocommands ============================
"

" convert spaces to tabs for Makefiles
autocmd FileType make setlocal noexpandtab

" Save a file when the focus is lost
autocmd FocusLost * :wa

" Remove the line when switching windows
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

"
" Plugin settings in here
"
source ~/.vimrc.plugins
source ~/.vimrc.mappings