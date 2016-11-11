echo "==> Updating oh-my-zsh..."
echo "  > Rebasing against upstream..."
cd ~/.oh-my-zsh
git fetch upstream && git rebase upstream/master &> /dev/null

echo "  > Pulling master for all submodules..."
cd ~/.oh-my-zsh
git submodule foreach git pull origin master &> /dev/null
