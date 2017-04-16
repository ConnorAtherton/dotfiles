source ~/.utils.zsh

function install_nvm() {
  local version=$(echo "$NODE_VERSION")

  if ! exists nvm ; then
    curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh \
      | NVM_DIR=/usr/local/nvm sh >/dev/null 2>&1
  fi

  # if ! nvm ls | grep $version > /dev/null 2>&1; then nvm install lts/boron; fi
  # if which nvm > /dev/null; then nvm use $version --delete-prefix --silent > /dev/null 2>&1; fi
}

install_nvm
