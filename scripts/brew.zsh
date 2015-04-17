function install_homebrew() {
  # TODO: do a whcih check here
  if ! [ $(which brew) ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function install_brews() {
  brew tap caskroom/homebrew-cask
  brew tap homebrew/boneyard

  brews=( vim git node tmux reattach-to-user-namespace python \
          rename tree wget cmake brew-cask ctags wireshark \
          peco coreutils docker the_silver_searcher gnupg  \
          freetype boost-python glib pixman go )

  for item in "${brews[@]}"
  do
    if [[ $item == "vim" ]]; then
      brew install $item --override-system-vim
    elif [[ $item == "wireshark" ]]; then
      brew install wireshark --with-qt
    elif [[ $item == "boost-python" ]]; then
      brew install boost-python --build-from-source
    else
      brew install $item
    fi
  done
}

function install_casks() {
  casks=( dropbox vlc google-chrome suspicious-package \
          transmission skitch adium alfred bartender caffeine \
          f-lux iterm2 spectacle vagrant virtualbox )

  for item in "${casks[@]}"
  do
    brew cask install $item
  done
}

# ensure latest homebrew
brew update

# upgrade formulae we already have installed
brew upgrade

install_homebrew
install_brews && install_casks

