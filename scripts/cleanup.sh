#!/bin/zsh

### Makes you owner of /usr/local
sudo chown -R `whoami` /usr/local

### Clear the brew cache
rm -rf `brew --cache`

### Recreate the brew cache
mkdir `brew --cache`

### Cleanup - cleans up old homebrew files
brew cleanup

### Prune - removes dead symlinks in homebrew
brew prune

### Doctor - runs homebrew checks for common error causing issues
brew doctor

