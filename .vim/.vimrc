set nocompatible

" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vim/.vimrc.before"))
  source ~/.vim/.vimrc.before
endif

" Don't show intro
set shortmess+=I

" Set the Ruby path correctly
let g:ruby_path = system('echo $HOME/.rbenv/shims')

"
" Color schemes
"
" TODO: change color scheme based on time of day
"
colorscheme solarized

" set background=dark
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
" set ttyfast
" set lazyredraw

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
nmap <Leader>m :NERDTreeTabsToggle<CR>

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

" Wrapping
set nowrap       "Don't wrap lines
set textwidth=79 " most linters I use are set at 80
set formatoptions=qrn1
set colorcolumn=85 " show long lines
set linebreak    "Wrap lines at convenient points

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
set smartcase    "Search better
set ignorecase
set smartcase
set gdefault " replace every occurence on the line by default
set incsearch
set showmatch
set hlsearch
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.rsync*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store

nmap <silent> ,/ :nohlsearch<CR>

" make tab match brackets
nnoremap <tab> %
vnoremap <tab> %

" ================ History ==========================
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

" Lets us edit a file that requires root privs
" once it's already open (think /etc/hosts)
cnoremap w!! w !sudo tee % >/dev/null

" Move visual block on scroll
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" opens .vimrc in split for easy editing
nnoremap <leader>ev :vsplit $VIMRC<cr>
" source .vimrc
nnoremap <leader>sv :source $VIMRC<cr>
" opens a new vsplit
nnoremap <leader>vs :vsplit<cr>
" opens a new vsplit
nnoremap <leader>hs :split<cr>
" Start using ag and place cursor in the quotes
nnoremap <leader>s :Ag ""<Left>
nnoremap <leader>sf :AgFile ""<Left>
" I want to go to the first character far more often
" than the beginning of the line so let's switch
nnoremap 0 ^
nnoremap ^ 0

" convert spaces to tabs for Makefiles
autocmd FileType make setlocal noexpandtab
" Save a file when the focus is lost
au FocusLost * :wa

" Remove the line when switching windows
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" Plugin mappings in here
if filereadable(expand("~/.vim/.vimrc.after"))
  source ~/.vim/.vimrc.after
endif