#!/bin/zsh

# set -e

# for c in {0..255} ; do
#     echo -e "\e[38;05;${c}m ${c} Bash Prompt Color Chart"
# done
# exit 0

#######################
#
# Move to helpers file.
#
#######################

#
# Find Operating system
#
os() {
  local os=

  case uname in
    Linux*) os=linux ;;
    Darwin*) os=darwin ;;
  esac

  echo "$os"
}

# $1 - ANSII color code
# $2 - Message to print
print_color() {
  echo -e "\e[38;05;${1}m ${2}"
}

print_yellow() {
  print_color 33 "$1"
}

print_green() {
  print_color 32 "$1"
}

print_blue() {
  print_color 48 "$1"
}

print_gray() {
  print_color 65 "$1"
}


print_color 201 "  __  _ _____              ___ _ _"
print_color 13  " /  \/ |____ \       _    / __|_) |"
print_color 123 "(_/\__/ _   \ \ ___ | |_ | |__ _| | ____  ___"
print_color 155 "       | |   | / _ \|  _)|  __) | |/ _  )/___)"
print_color 180 "       | |__/ / |_| | |__| |  | | ( (/ /|___ |"
print_color 201 "       |_____/ \___/ \___)_|  |_|_|\____|___/"
echo ""

#
# Remove a file from the
# home dir
#
remove_from_home () {
  FILEPATH=$HOME/$1

  if [[ -a $FILEPATH ]]; then
    if [[ -d $FILEPATH ]]; then
      rm -rf $FILEPATH
    else
      rm -r $FILEPATH
    fi
  fi
}

#
# Symlink files back into correct dir
#
print_blue "==> Replacing all config files..."
find ./config ! -path . -maxdepth 1 -iname ".*" | while read file
do
  if [ $(echo basename "${file:2}" | grep -E '.git*') ]; then
    continue
  fi

  remove_from_home ${file}
  print_gray "==> Symlinking to $HOME/$(basename $file)"
  ln -fs $PWD${file:1} $HOME/$(basename $file);
done
print_green "==> Done."

#
# TODO: include this above in find
#
remove_from_home "functions"
ln -fs $PWD/functions $HOME/functions

#
# install vim.plug to manage deps
#
print_blue "==> Configuring vim..."
if ! [ -e ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
print_green "==> Done."

if [ os = "Linux" ]; then
  print_blue "==> Installing files for Linux."
else
  print_blue "==> Installing files for OSX."
  # cd ~ && ./.osx
  # install brew
  # `sh $PWD/scripts/brew.zsh`
fi
print_green "==> Done."

exit 0
#
# config for linux and mac
#
# `sh $PWD/scripts/nvm.zsh`

. ~/.zshrc

