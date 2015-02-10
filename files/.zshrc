export PATH="/usr/local/bin:/Users/Connor/Bitnami/arc/arcanist/bin:/Users/Connor/.rbenv/bin:/Users/Connor/google-cloud-sdk/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/home'
export EDITOR='vim'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# source all aliases
source $HOME/.aliases
source $ZSH/oh-my-zsh.sh

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# export ARCHFLAGS="-arch x86_64"
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
export DOCKER_HOST="tcp://localhost:2375"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

### Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Remap some keys
bindkey '^b' beginning-of-line

rm -f "$PWD/scripts/all.zsh"
for a in `ls scripts`; do
  echo "found script - $a"
  cat "$PWD/scripts/$a" >> "$PWD/scripts/all.zsh"
done
# source "$PWD/scripts/all.zsh"
