#!/usr/bin/env zsh

#
# Store current OS
#
case $(uname -s) in
  Linux)
    OS="LINUX"
    ;;
  Darwin)
    OS="MAC"
    ;;
esac

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
find ./config ! -path . -maxdepth 1 -iname ".*" | while read file
do
  # file=$(basename $file)
  echo $file

  if [ $(echo basename "${file:2}" | grep -E '.git*') ]; then
    echo "Ignoring ${file:2}"
    continue
  fi

  echo "Removing from home. ${file}"
  remove_from_home ${file}
  echo "SYMLINKING $PWD${file:1} to $HOME/$(basename $file)"
  ln -fs $PWD${file:1} $HOME/$(basename $file);
done

#
# TODO: include this above in find
#
remove_from_home "functions"
ln -fs $PWD/functions $HOME/functions

#
# install vim.plug to manage deps
#
# if ! [ -e ~/.vim/autoload/plug.vim ]; then
#   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

if [ $OS = "Linux" ]; then
  echo "Linux detected: installing relevant files."
  # config for thinkpad...
else
  echo "OSX detected: installing relevant files."
  # cd ~ && ./.osx
  # install brew
  # `sh $PWD/scripts/brew.zsh`
fi

#
# config for linux and mac
#
# `sh $PWD/scripts/nvm.zsh`

. ~/.zshrc

