source ~/.utils.zsh

function install_nvm() {
  exists nvm
  echo "$?"

  exists nvm && echo "nvm does exist"

  if ! exists nvm ; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | NVM_DIR=/usr/local/nvm sh
  fi
}

install_nvm
