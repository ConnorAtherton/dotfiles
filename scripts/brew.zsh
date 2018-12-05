function install_homebrew() {
  # Using default one installed here, because the ruby distribution is managed by homebrew itself
  if ! which brew >/dev/null ; then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function homebrew_maintenance() {
  # ensure latest homebrew
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade --all

  # Remove outdated versions from the cellar.
  brew cleanup
}

# This also remove all packages
function uninstall_homebrew() {
  echo "Removing casks first"
  for pkg in $(brew cask list); do brew cask rm --force "$pkg"; done

  # Using default one installed here, because the ruby distribution is managed by homebrew itself
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}

function install_brews() {
  brews=( vim git tmux reattach-to-user-namespace python \
    rename tree wget coreutils make grep fd \
    peco docker the_silver_searcher gnupg \
    freetype boost-python glib go zsh zsh-syntax-highlighting \
    docker-compose fzf rbenv universal-ctags/universal-ctags/universal-ctags )

  for item in "${brews[@]}"
  do
    local args=""

    if [[ $item == "vim" ]]; then
      args="--override-system-vim"
    elif [[ $item == "boost-python" ]]; then
      args="--build-from-source"
    elif [[ $item == "universal-ctags/universal-ctags/universal-ctags" ]]; then
      # Head only formula
      args="--HEAD"
    elif [[ $item == "make" ]] || [[ $item == "grep" ]]; then
      # By default, gnu tools are installed with a `g`-prefix. We don't want that.
      args="--with-default-names"
    fi

    if [[ -z $args ]]; then
      brew install $item
    else
      brew install $item "$args"
    fi
  done
}

function install_casks() {
  brew tap caskroom/homebrew-cask
  brew tap caskroom/versions
  brew tap homebrew/boneyard

  casks=( dropbox vlc suspicious-package \
    transmission skitch adium caffeine \
    flux iterm2 spectacle \
    spotify docker \
    caskroom/versions/firefox-developer-edition )

  for item in "${casks[@]}"
  do
    brew cask install --force $item
  done
}

# Will skip if already installed
install_homebrew

# Install all brew packages and casks
install_brews && install_casks

# Keep everything up-to-date
homebrew_maintenance