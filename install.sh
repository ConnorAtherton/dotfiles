#!/bin/zsh

# NOTE:
# - on mac, it still includes manually installing the xcode developer tools. Even homebrew requires they be present.

# set -eu

# $0 is buggy as hell but we only ever do this one time. The rest of the scripts looks for
# the utils files in the home directory after this file runs.
source $(dirname $0)/config/.utils.zsh


echo -e "\033[2J"
echo -e "\033[H"

trap stop_spinner INT

# Kick it off, maestro..
print_dotfiles_header

#
# Symlink files back into correct dir
#
start_spinner "Replacing all config files"
find ./config -maxdepth 1 ! -path . -iname ".*" | while read file
do
  local name=$(basename $file)

  remove_from_home $name
  ln -fs $PWD${file:1} $HOME/$name;
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
  ln -fs $PWD${file:1} $HOME/$name;
done
stop_spinner

#
# TODO: include this above in find
#
remove_from_home "functions"
ln -fs $PWD/functions $HOME/functions

#
# TODO: node/npm installation needs to happen before this because some vim libraries require those tools to complete
# post install tasks install vim.plug to manage deps
#
start_spinner "Creating catherton bin directories"
  mkdir -p "~/bin" &>/dev/null

  # TODO: This needs to be installed by cargo
  exa -1 bin | while read file
  do
    ln -fs "$PWD/bin/$name" "~/bin/$name"
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
stop_spinner

if [ "$(uname -s)" = "Linux" ]; then
  start_spinner "Installing files for Linux"

  # Link all config files
  mkdir -p $HOME/.config
  find ./linux/.config/* -maxdepth 0 | while read file
  do
    local name=$(basename $file)
    ln -fs $PWD${file:1} $HOME/.config/$name;
  done
else
  start_spinner "OSX detected: installing relevant files"

  # permissions
  # sudo chown -R $(whoami):admin /usr/local
  # chmod 775 ~/.osx
  # chmod 775 ~/scripts
  # cd ~ && ./.osx
  # install brew
  # sh $PWD/scripts/brew.zsh

  # if ! [ $(which xcode-select) ]; then
  #   xcode-select --install
  # fi
  stop_spinner

  start_spinner "Checking for oh-my-zsh..."
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

exit 0
