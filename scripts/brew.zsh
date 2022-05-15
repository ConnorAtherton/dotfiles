function install_homebrew() {
  # Using default one installed here, because the ruby distribution is managed by homebrew itself
  if ! which brew >/dev/null ; then
    echo "Installing homebrew"

    # TODO: This must be run manually!!!!!
    # Adding the CI env variable forces homebrew to not wait for the user and automatically proceed
    CI=true /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
    peco docker the_silver_searcher gnupg nvm \
    freetype boost-python glib go zsh zsh-syntax-highlighting \
    docker-compose fzf rbenv \

    # Port scanning
    nmap \

    # I use this for playing with clojure. Latest is fine.
    java \

    #
    universal-ctags/universal-ctags/universal-ctags \

    # `ls` improvement. I alias this.
    exa \

    # For querying and filtering json data
    jq \

    # For integrating with DO, where things are deployed
    doctl \

    # An improved diff output
    git-delta)

  for item in "${brews[@]}"
  do
    local args=""

    if [[ $item == "universal-ctags/universal-ctags/universal-ctags" ]]; then
      # Head only formula
      args="--HEAD"
    # elif [[ $item == "make" ]] || [[ $item == "grep" ]]; then
    #   # By default, gnu tools are installed with a `g`-prefix. We don't want that.
    #   args="--with-default-names"
    fi

    if [[ -z $args ]]; then
      brew install $item >/dev/null
    else
      brew install $item "$args" >/dev/null
    fi
  done
}

function install_casks() {
  brew tap homebrew/cask-versions

  casks=( dropbox vlc suspicious-package \
    adium caffeine \

    # For image flashing. Use this when working why the Pis
    balenaetcher \

    # Hotkey window management
    spectacle \

    flux spotify docker alacritty \

    # Dev browsers
    firefox-developer-edition chromium )

  for item in "${casks[@]}"
  do
    # Using --force here will upgrade, but it makes running ./install.sh way too much pain
    brew install $item
  done
}

# Will skip if already installed
install_homebrew

# Install all brew packages and casks
# install_brews && install_casks
install_casks

# Keep everything up-to-date
homebrew_maintenance