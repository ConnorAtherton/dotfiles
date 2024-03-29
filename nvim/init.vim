call plug#begin()
  " Search and file navigation
  " Plug 'rking/ag.vim', { 'on': 'Ag' }
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'kien/ctrlp.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Auto bracket completion
  Plug 'jiangmiao/auto-pairs'

  " #tpope
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'

  " Look and feel
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'airblade/vim-gitgutter'
  Plug 'tomtom/tlib_vim'

  " Useful tools and syntax stuff
  Plug 'ap/vim-css-color', { 'for': ['css', 'sass'] }
  Plug 'scrooloose/syntastic'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'w0rp/ale'
  Plug 'rhysd/conflict-marker.vim'

  " Autocompletion
  " Plug 'Valloric/YouCompleteMe'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/deoplete.nvim', { 'do': 'pip3 install --user pynvim' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

  " Language support
  Plug 'neomake/neomake'
  Plug 'pangloss/vim-javascript'
  Plug 'racer-rust/vim-racer'

  " Syntax highlighting
  Plug 'ConnorAtherton/uiscript-vim', { 'for': 'uiscript' }
  Plug 'sheerun/vim-polyglot'

  " For CTags
  " Plug 'majutsushi/tagbar'

  " Writing, note taking, diagramming
  Plug 'suan/vim-instant-markdown'
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
  Plug 'mtth/scratch.vim', { 'on': 'Scratch' }
  Plug 'vim-scripts/DrawIt'

  " Color schemes
  " Plug '~/dotfiles/.vim/custom_themes/seoul256.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug '~/dotfiles/.vim/custom_themes/catherton'

  " Code editing
  Plug "github/copilot.vim"
call plug#end()
