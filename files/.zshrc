export PATH="/usr/local/bin:/Users/Connor/Bitnami/arc/arcanist/bin:/Users/Connor/.rbenv/bin:/Users/Connor/google-cloud-sdk/bin:$PATH"
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set JAVA_HOME ENV variable
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/home'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# source all aliases
source $HOME/.aliases

# plugins
source $HOME/peco.zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git ruby)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# rbenv init
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
export DOCKER_HOST="tcp://localhost:2375"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Remap some keys
bindkey '^b' beginning-of-line

## Just a nice welcome
echo "Welcome back Connor\n"
