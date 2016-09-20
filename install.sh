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
  print_color 48 "$1"
}

print_blue() {
  print_color 32 "$1"
}

print_gray() {
  print_color 8 "$1"
}

print_red() {
  print_color 196 "$1"
}

step() {
  print_green "[ ] $1"
}

finish() {
  echo -en "\e[1A"; echo -e "\e[0K\r [x] $version. Done."
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
    elif [ -h $FILEPATH ]; then
      unlink $FILEPATH
    else
      rm $FILEPATH
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

  local name=$(basename $file)

  remove_from_home $name
  print_gray "==> Symlinking to $HOME/$name"
  ln -fs $PWD${file:1} $HOME/$name;
done

print_blue "==> Replacing all vim files..."
find ./.vim ! -path . -maxdepth 1 -iname ".*" | while read file
do
  if echo basename "$file" | grep -E '^.git*' >/dev/null; then
    continue
  fi

  local name=$(basename $file)

  remove_from_home $name
  print_gray "==> Symlinking to $HOME/$name"
  ln -fs $PWD${file:1} $HOME/$name;
done
print_green "==> Done."

print_blue "==> Checking for oh-my-zsh..."
if ! [ -e ~/.oh-my-zsh ]; then
  print_red "==> Install oh-my-zsh and run it again."
  print_red "==> "
  print_red '==> sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
  print_red "==> "
  exit 1
fi
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
  print_blue "==>  OSX detected: installing relevant files."

  # permissions
  # sudo chown -R $(whoami):admin /usr/local
  # chmod 775 ~/.osx
  # chmod 775 ~/scripts
  # cd ~ && ./.osx
  # install brew
  # `sh $PWD/scripts/brew.zsh`

  if ! [ $(which xcode-select) ]; then
    xcode-select --install
  fi
fi
print_green "==> Done."

#
# config for linux and mac
#
# `sh $PWD/scripts/nvm.zsh`
print_blue "==> Installing latest Ruby versions"
rbenv install -l | grep "^\s*\d.\d.\d$" | sort -r | head -n 3 | sed s/' '/''/g | sort | while read -r version; do
  print_green "==> $version"
  rbenv install $version &>/dev/null
  echo -en "\e[1A"; echo -e "\e[0K\r ==> $version. Done."
  rbenv global $version
done
print_green "==> Done."

print_blue "==> Installing npm modules"
. $PWD/scripts/npm.zsh
print_green "==> Done."

. ~/.zshrc

