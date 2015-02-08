function switch_to_zsh() {
  chsh -s /bin/zsh
  echo "switched to zsh"
}

function install_xcode() {
  xcode-select --install
  echo "installed xcode"
}
