#!/bin/zsh
# set -eu

# TODO:
# - on mac, it still includes manually installing the xcode developer tools. Even homebrew requires they be present.
# https://github.com/kassio/dotfiles/blob/main/bin/installers/0_macos

# $0 is buggy as hell but we only ever do this one time. The rest of the scripts looks for
# the utils files in the home directory after this file runs.
source $(dirname $0)/config/.utils.zsh

#
# NOTE:
# - To enable debugging, set the DOTFILES_DEBUG env var. The value doesn't matter, just so long as it's set.
#

mkdir -p "${HOME}/.state/dotfiles.d/"
TIMESTAMP_FILE="${HOME}/.state/dotfiles.d/.last-install"

function _exit() {
  # stop_spinner 0

  echo "$(date -j '+%d %b %Y %H:%M')" > "${TIMESTAMP_FILE}"
  exit "$1"
}

function _title() {
  print_blue "▸ $1\n"
}

function _notify_last_install() {
  if [ -f "${TIMESTAMP_FILE}" ]; then
    _title "Last install was done on $(cat ${TIMESTAMP_FILE})."
  fi
}

function _print_dotfiles_header() {
	printf ' '
	for i in 1 2 3 4 5 6 7 8; do
		printf '\033[9%sm▅▅' "$i"
	done
	printf '\033[0m\n'
  printf ' D O T F I L E S\n'
	printf '\033[0m\n'
}

echo -e "\033[2J"
echo -e "\033[H"
reset

# trap stop_spinner INT

function symlink {
  debug "Symlinking $1 -> $1"
  ln -nsf $1 $2
}

function _upgrade() {
  trap '_exit -1' HUP INT QUIT TERM

  # Kick it off, maestro..
  _print_dotfiles_header

  RECORD_START=$(date +'%s')

  _notify_last_install

  #
  # Symlink files back into correct dir
  #
  start_spinner "Replacing all config files"
  find ./config -maxdepth 1 ! -path . -iname ".*" | while read file
  do
    local name=$(basename $file)

    remove_from_home $name
    symlink "$PWD${file:1}" "$HOME/$name"
    chown "$user:$user" $HOME/$name
  done
  stop_spinner

  start_spinner "Replacing all vim files"
  find ./.vim -maxdepth 1 ! -path . -iname ".*" | while read file
  do
    if echo basename "$file" | grep -E '^.git*' >/dev/null; then
      continue
    fi

    local name=$(basename $file)

    remove_from_home $name
    symlink "$PWD${file:1}" "$HOME/$name"
  done
  stop_spinner

  #
  # TODO: include this above in find
  #
  start_spinner "Replacing all functions"
    remove_from_home "functions"
    symlink "$PWD/functions" "$HOME/functions"
  stop_spinner

  #
  # TODO: node/npm installation needs to happen before this because some vim libraries require those tools to complete
  # post install tasks install vim.plug to manage deps
  #
  start_spinner "Creating catherton bin directories"
    mkdir -p "$HOME/bin" &>/dev/null

    # TODO: This needs to be installed by cargo
    exa -1 bin | while read file
    do
      symlink "$PWD/bin/$name" "$HOME/bin/$name"
    done
  stop_spinner

  #
  # install pretty shell theme
  #
  start_spinner "Configuring p10k"
    if ! [ -e ~/powerlevel10k ]; then
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    fi
  stop_spinner

  #
  # install vim.plug to manage deps
  #
  # start_spinner "Configuring vim"
  #   if ! [ -e ~/.vim/autoload/plug.vim ]; then
  #     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  #       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  #   fi

  #   # TODO: Check a timestamp for this instead of running every time
  #   vim +PlugClean +qall
  #   vim +PlugInstall +qall
  # stop_spinner

  if [ "$(uname -s)" = "Linux" ]; then
    start_spinner "Installing files for Linux"

    # Link all config files
    mkdir -p $HOME/.config
    find ./linux/.config/* -maxdepth 0 | while read file
    do
      local name=$(basename $file)
      symlink "$PWD${file:1}" "$HOME/.config/$name"
    done
  else
    start_spinner "OSX detected: installing relevant files"

    # permissions
    # sudo chown -R $(whoami):admin /usr/local
    # chmod 775 ~/.osx
    # chmod 775 ~/scripts
    # cd ~ && ./.osx
    # install brew

    # TODO: If brew already installed, check each formula and ask to run `update::brew` manually to upgrade everything
    # sh $PWD/scripts/brew.zsh

    # if ! [ $(which xcode-select) ]; then
    #   xcode-select --install
    # fi
    stop_spinner

    start_spinner "Checking for oh-my-zsh"
    if ! [ -e ~/.oh-my-zsh ]; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &>/dev/null
    fi
  fi
  stop_spinner

  #
  # config for linux and mac
  #
  # local ruby_versions=$(rbenv install -l | grep "^\s*\d.\d.\d$" | sort -r | head -n 3 | sed s/' '/''/g | sort)
  # start_spinner "Installing latest Ruby versions: $(newline_join $ruby_versions)"
  # echo $ruby_versions | while read -r version; do
  #   rbenv install $version &>/dev/null
  #   rbenv global $version
  # done
  # stop_spinner

  # TODO: This is buggy because it re-installs nvm every time
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash >/dev/null
  # start_spinner "Installing nvm and setting node version"
  # . $PWD/scripts/nvm.zsh
  # stop_spinner
  #
  # start_spinner "Installing npm modules"
  # . $PWD/scripts/npm.zsh
  # stop_spinner

  # start_spinner "Setting shell correctly"
  #   chsh -s $(which zsh)
  #   # . ~/.zshrc
  # stop_spinner
  #

  start_spinner "Sourcing shell modules"
    . ~/.zshrc
  stop_spinner

  echo ""

  ./colorballs.sh

  RECORD_END=$(date +'%s')
  echo ""
  echo " Complete in $(($RECORD_END - $RECORD_START)) seconds"
  echo ""
}

# TODO: Accept -u argument to force install
_upgrade

_exit 0
