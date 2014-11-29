#!/usr/bin/env zsh

#
# REMOVE OLD DOTFILES
echo "Removed old dotfiles"
rm -rf $HOME/.vim
rm -f $HOME/.zprofile
rm -f $HOME/.zshrc
rm -f $HOME/.zprofile
rm -f $HOME/.aliases
rm -f $HOME/.tmux.conf
rm -f $HOME/.osx

FILEPATH=$PWD/files

cd files
find . ! -path . -maxdepth 1 | while read file
do
	echo 'SYMLINKING -> ' ${file:2};
	ln -s $PWD/${file:2} $HOME/${file:2};
done

#
# SYMLINKS
echo "Created symlinks for the dotfiles"

echo "Creating symlinks for vim to root"
ln -fs $FILEPATH $HOME
ln -fs $HOME/.vim/.vimrc $HOME/.vimrc
ln -fs $HOME/.vim/.vimrc.after $HOME/.vimrc.after
ln -fs $HOME/.vim/.vimrc.before $HOME/.vimrc.before

echo "Resetting .osx new settings"
cd ~ && ./.osx && source .zshrc

