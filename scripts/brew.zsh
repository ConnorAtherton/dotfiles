function install_homebrew() {
  if ! which brew >/dev/null ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function install_brews() {
  brew tap caskroom/homebrew-cask
  brew tap caskroom/versions
  brew tap homebrew/boneyard

  brews=( vim git node tmux reattach-to-user-namespace python \
          rename tree wget cmake brew-cask ctags wireshark \
          peco coreutils docker the_silver_searcher gnupg  \
          freetype boost-python glib pixman go zsh-syntax-highlighting \
          docker-compose fzf rbenv )

  for item in "${brews[@]}"
  do
    local args=""

    if [[ $item == "vim" ]]; then
      args="--override-system-vim"
    elif [[ $item == "wireshark" ]]; then
      args="--with-qt"
    elif [[ $item == "boost-python" ]]; then
      args="--build-from-source"
    fi

    brew install $item "$args"
  done
}

function install_casks() {
  casks=( dropbox vlc google-chrome suspicious-package \
          transmission skitch adium alfred caffeine \
          flux iterm2 spectacle vagrant virtualbox \
          google-chrome-canary google-cloud-sdk spotify \
          caskroom/versions/firefoxdeveloperedition \
          caskroom/versions/google-chrome-canary \
          slack )

  for item in "${casks[@]}"
  do
    brew cask install $item
  done
}

# Make sure it is on the system
install_homebrew

# ensure latest homebrew
brew update

# upgrade formulae we already have installed
brew upgrade

install_brews && install_casks
