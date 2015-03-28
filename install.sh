#!/usr/bin/env zsh

#
# DETERMINE OS
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
# REMOVE OLD DOTFILES
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
find . ! -path . -maxdepth 1 -iname ".*" | while read file
do
  if [ $(echo "${file:2}" | grep -q -E '^.git*') ]; then
    continue
  fi

  echo 'Removing from home. ' ${file:2}
  remove_from_home ${file:2}
	echo 'SYMLINKING -> ' ${file:2};
	ln -fs $PWD/${file:2} $HOME/${file:2};
done

#
# install vim.plug to manage deps
#
if ! [ -e ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ $OS = "Linux" ]; then
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

source ~/.zshrc

