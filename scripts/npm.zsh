function install_npm_packages() {
  packages=( vtop is-up fcount tasc instant-markdown-d /
             fokus )

  for item in "${packages[@]}"
  do
    npm install -g $item &>/dev/null
  done
}

install_npm_packages

