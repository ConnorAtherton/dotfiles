set nocompatible

"
" Plugin settings in here
"
" NOTE: Load everything here so the runtime path can be modified before referring
" to colorschemes.
"
source ~/.vimrc.plugins

" Don't show intro
set shortmess+=I

" Set the Ruby path correctly
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Default color scheme
" colo catherton
" let g:nord_italic = 1
" let g:nord_underline = 1
" let g:nord_italic_comments = 1
" let g:nord_uniform_diff_background = 1
" let g:nord_cursor_line_number_background = 1
colorscheme nord

" ALL OVERRIDES CURRENTLY IN PROGRESS
" TODO: Put this into my eventual color scheme
hi VertSplit ctermbg=NONE guibg=NONE
" Makes things look cleaner without any of these splits
set fillchars=""
" Force remove this so the numbers end up with the same color
hi clear LineNr
hi clear SignColumn

"
" ================ Tabs, Windows, and Buffers ==================
"
" Remap esc to <j-j>
ino jk <esc>
cno jk <c-c>
vno v <esc>
nnoremap jk <esc>
" Keep yank consistent with Delete to eol
nnoremap Y y$

" Remap cycling through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-m> :bprevious<CR>

" Change buffer closing behaviour to something better
map <leader>bd :Bclose<cr>

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" More Intuituve split positions
set splitbelow
set splitright

"
" ================ General Config ====================
"
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set backspace=indent,eol,start

" Backup files get in the way, everything is in version control anyway.
set nobackup
set noswapfile
set nowritebackup

" Enable modeline for have vim settings inline (useful for things like dotfiles)
set modeline
set modelines=5

set number " Line numbers are good
" set relativenumber " Display how far away each line is from the current one

" This needs to exist so the 'j' key is still snappy in normal
" mode due to the fact that 'jk' replaces <esc>
set timeout
set timeoutlen=100
set ttimeoutlen=100

" Look and feel
set ttyfast
set lazyredraw

" More frequent updates for, e.g. signs.
set updatetime=750

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Don't add empty newlines at the end of files
set binary
set noeol

" Turn on syntax highlighting
syntax on
set cursorline
set cursorcolumn " TODO: Visit

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
set textwidth=120      " But wrap text object at 100 chars
set nuw=3              " Bump line numbers alongs to have some space on the left
set formatoptions=qrn1
set colorcolumn=120    " Show long lines
set linebreak          " Wrap lines at convenient points

"
" ================ Error Handling ============================
"
match ErrorMsg '\%>120v.\+'
match ErrorMsg '\s\+$'

"
" ================ Folds ============================
"

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"
" ================ Scrolling ========================
"

set scrolloff=10         "Start scrolling when we're 10 lines away from margins
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

" Fast saving
nmap <leader>w :w!<cr>

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

" Splits
nnoremap <leader>vs :vsplit<cr>
nnoremap <leader>hs :split<cr>

" opens .vimrc in split for easy editing. (e)dit or (s)ource config
nnoremap <leader>ec :vsplit $VIMRC<cr>
" source .vimrc
nnoremap <leader>sc :source $VIMRC<cr>

" Start using ag and place cursor in the quotes
nnoremap <leader>s :Ag ""<Left>

" I want to go to the first character far more often
" than the beginning of the line so let's switch
nnoremap 0 ^
nnoremap ^ 0

"
" ================ Autocommands ============================
"

" Delete trailing whitespace before saving any file
" TODO: Move to custom functions
func! DeleteTrailingWhitespace()
" Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
      return
  endif

  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd FileType yaml,perl let b:noStripWhitespace=1

" Don't close window when deleting a buffer, show something else
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

autocmd BufWritePre * call DeleteTrailingWhitespace()

" convert spaces to tabs for Makefiles
autocmd FileType make set noexpandtab shiftwidth=8 tabstop=8 softtabstop=0
autocmd FileType go set noexpandtab shiftwidth=4 tabstop=4 softtabstop=0
autocmd FileType python set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile,FileType java set smartindent expandtab shiftwidth=4 tabstop=4 softtabstop=0

" Save a file when the focus is lost
autocmd FocusLost * :wa

" Remove the line when switching windows
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

augroup EnsureFreshVimrc
  autocmd!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" Preset layouts for splits
nnoremap <leader>3 :vsplit<CR>:bn<CR>:vsplit<CR>:bn<CR>
nnoremap <leader>4 :vnew<CR>:bn<CR>:vnew<CR>:bn<CR><C-W><C-L><C-W><C-L>:split<CR>:bn<CR>

" Replace curly quotes with straight quotes in the entire file.
function! Nocurly() abort
  silent! %s/'/'/g
  silent! %s/'/'/g
  silent! %s/"/"/g
  silent! %s/"/"/g
endfunction
command! Nocurly call Nocurly()

source ~/.vimrc.mappings