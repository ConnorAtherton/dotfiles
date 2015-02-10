function install_homebrew() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_brews() {
  brew tap caskroom/homebrew-cask

  brews=( vim git node tmux reattach-to-user-namespace \
          rename tree wget cmake brew-cask ctags wireshark \
          peco )

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
