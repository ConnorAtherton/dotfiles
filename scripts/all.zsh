function switch_to_zsh() {
  chsh -s /bin/zsh
  echo "switched to zsh"
}

function install_xcode() {
  xcode-select --install
  echo "installed xcode"
}

# so useful!
function restart_finder() {
  killall Finder
}

function show_hidden_files() {
  defaults write com.apple.finder AppleShowAllFiles TRUE
  restart_finder
}

function hide_hidden_files() {
  defaults write com.apple.finder AppleShowAllFiles FALSE
  restart_finder
}

# find shorthand
# find ./ -name '*.js'
function f() {
  find . -name "$1"
}

# Create a new directory and enter it
function md() {
  mkdir -p "$1" && cd "$1"
}

function install_homebrew() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_brews() {
  brew tap caskroom/homebrew-cask

  brews=( vim git node tmux reattach-to-user-namespace \
          rename tree wget cmake brew-cask ctags wireshark )

  for item in "${brews[@]}"
  do
    if [[ $item == "vim" ]]; then
      brew install $item --override-system-vim
    elif [[ $item == "wireshark" ]]; then
      brew install wireshark --with-qt
    else
      brew install $item
    fi
  done
}

function install_casks() {
  casks=( dropbox vlc google-chrome suspicious-package \
          transmission skitch )

  for item in "${casks[@]}"
  do
    brew cask install $item
  done
}

install_homebrew
install_brews && install_casks

function install_npm_packages() {
  packages=( vtop is-up fcount tasc )

  for item in "${packages[@]}"
  do
    npm install -g $item
  done
}

install_npm_packages

# kill process
function peco-kill-process() {
    ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
}

alias pkp='peco-kill-process'

