#!/bin/zsh


RECORD_START=$(date +'%s')

#
# TODO:
# -> Add --debug flag which prints out everything each stage does, like symlinking and whatnot

# NOTE:
# - on mac, it still includes manually installing the xcode developer tools. Even homebrew requires they be present.

# set -eu

# $0 is buggy as hell but we only ever do this one time. The rest of the scripts looks for
# the utils files in the home directory after this file runs.
source $(dirname $0)/config/.utils.zsh

echo -e "\033[2J"
echo -e "\033[H"

trap stop_spinner INT

function symlink {
  debug "Symlinking $1 -> $1"
  ln -nsf $1 $2
}

# Kick it off, maestro..
print_dotfiles_header

DOTFILES_DEBUG_MODE=1

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
# install vim.plug to manage deps
#
start_spinner "Configuring vim"
  if ! [ -e ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  vim +PlugClean +qall
  vim +PlugInstall +qall
stop_spinner

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

RECORD_END=$(date +'%s')
echo ""
echo "Complete in $(($RECORD_END - $RECORD_START)) seconds"
echo ""

exit 0
