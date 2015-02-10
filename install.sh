#!/usr/bin/env zsh

# DETERMINE OS
case $( uname -s ) in
Linux)
    OS="LINUX"
    ;;
Darwin)
    OS="MAC"
    ;;
esac

#
# REMOVE OLD DOTFILES
echo "Removing old dotfiles"
files=( .vim .zprofile .zshrc .aliases .tmux.conf \
        .osx )
for f in "${files[@]}"; do
  FILEPATH=$HOME/$f
  if [[ -a $FILEPATH ]]
  then
    if [[ -d $FILEPATH ]]
    then
      rm -rf $FILEPATH
    else
      rm -r $FILEPATH
    fi
  fi
done

FILEPATH=$PWD/files

#
# Symlink files back into correct dir
cd files
find . ! -path . -maxdepth 1 | while read file
do
	echo 'SYMLINKING -> ' ${file:2};
	ln -s $PWD/${file:2} $HOME/${file:2};
done
cd ..

echo "Creating symlinks for vim to root"
ln -fs $FILEPATH $HOME
ln -fs $HOME/.vim/.vimrc $HOME/.vimrc
ln -fs $HOME/.vim/.vimrc.after $HOME/.vimrc.after
ln -fs $HOME/.vim/.vimrc.before $HOME/.vimrc.before

if [ $OS = "Linux" ]; then
  # config for thinkpad...
else
  echo "Resetting .osx new settings"
  # cd ~ && ./.osx
fi

source ~/.zshrc
source "$PWD/scripts/all.zsh"
