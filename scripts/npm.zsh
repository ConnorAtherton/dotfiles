function install_npm_packages() {
  packages=( vtop is-up fcount tasc )

  for item in "${packages[@]}"
  do
    npm install -g $item
  done
}

install_npm_packages

