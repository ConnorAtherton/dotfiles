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

# install vim.plug to manage deps
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "$PWD ---------"
if [ $OS = "Linux" ]; then
  # config for thinkpad...
else
  echo "OSX detected: installing relevant files."
  # cd ~ && ./.osx
  # install brew
  `sh $PWD/scripts/brew.zsh`
fi

# config for linux and mac

# installs useful function aliases into shell
source ~/.zshrc
