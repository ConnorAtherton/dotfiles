function install_nvm() {
  if ! [ $(which nvm) ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | NVM_DIR=/usr/local/nvm sh
  fi
}

install_nvm
