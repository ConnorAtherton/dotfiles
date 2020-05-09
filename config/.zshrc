load_module() {
  if [ -n "$ABORTED" ]; then
    return
  fi

  module="$1"
  if [ -f "$module" ]; then
    source $module

    if [ "$?" != "0" ]; then
      echo "Module $module failed to load. Exiting."
      export ABORTED=1
      return
    fi
  fi
}

# Make sure we are running interactively, else stop
[ -z "$PS1" ] && return

rm -f ~/.zcompdump >/dev/null 2>&1

# Gimme some vi
set -o vi

# Enable profiling
zmodload zsh/zprof

local pathdirs funcdirs

#
# Environment variables
#
export ZSH=$HOME/.oh-my-zsh
export EDITOR='vim'
export ARCHFLAGS="-arch x86_64"
export VIMRC="~/.vimrc"
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
export TERM=screen-256color
export NVM_DIR=$HOME/.nvm
export NODE_VERSION="lts/carbon"

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_TITLE="true"

#
# For gpg signing
#
export GPG_TTY=$(tty)

#
# History settings. I use the `hstr` tool to filter this.
#
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}
export HISTCONTROL="erasedups:ignoreboth:ignorespace"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export HISTTIMEFORMAT='%F %T '

#
# Unset everything from scratch so we control the
# variables.
#
unset path
unset PATH
# unset fpath
# unset FPATH

#
# Create a list of directories to add to the path
#
pathdirs=(
  # Location where I install tools manually (allows me to know I can delete)
  $HOME/bin

  # Needs to go first for shims
  $HOME/.rbenv/shims

  # Homebrew comes next, to give priority over anything I install
  /usr/local/bin
  /usr/local/sbin

  /bin
  /sbin
  /usr/sbin
  /usr/bin
  /usr/X11/bin

  # Golang
  $GOPATH/bin

  # Rust
  $HOME/.cargo/bin

  # Tex additions for pandoc
  /Library/TeX/texbin/

  # Android development
  $HOME/Library/Android/sdk/platform-tools
)

#
# Add directories which exist to the path
#
for dir ($pathdirs) {
  if [[ -d $dir ]]; then
    path=($path $dir)
  fi
}

#
# Create a list of function paths for zsh
#
funcdirs=(
  /usr/share/zsh/$ZSH_VERSION/functions
  /usr/share/zsh/functions
  /usr/share/zsh/vendor-completions
  /usr/local/share/zsh/$ZSH_VERSION/functions
  /usr/local/share/zsh/functions
  /usr/local/share/zsh/site-functions

  $HOME/functions
)

#
# Add existing function directories to the fpath
#
# working:
# /usr/share/zsh/functions
for dir ($funcdirs) {
  # fpath=($fpath $dir)

  # TODO: Add this check back in when it works...
  if [[ -x $dir ]]; then
    fpath=($fpath $dir)
  fi
}

#
# Use coreutils utilities instead of BSD
#
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# Max line-length in man pages (also respected by Vim's man.vim plugin!)
export MANWIDTH=100

#
# Go programming
#
mkdir -p "$GOPATH/bin"

#
# FZF fuzzy searching
#
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#
# Remap some keys
#
bindkey '^b' beginning-of-line

#
# Export everything
#
export path
export fpath
export PATH
export FPATH
export MANPATH

#
# Autoload functions
#
autoload -Uz peco-kill-process hide-hidden-files md permission \
  restart-finder show-hidden-files start-fokus flush-dns-cache

#
# Source everything into the shell
#
source $ZSH/oh-my-zsh.sh
# source ~/.aliases

#
# Gimme that zsh goodness
#
# TODO: Different destinations is just a permission thing
#
if [ "$(uname -s)" != "Linux" ]; then
  # TODO: if file if prefixed with uname, symlink it!
  # This only works for OSX right now
  source ~/.lazy_load
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

load_module ~/.aliases

for module in ~/dotfiles/functions/*.sh; do
  load_module $module
done

# Print out profiling
# zprof

# TOOD: Move this into a module
function java::version () {
  export JAVA_HOME=`/usr/libexec/java_home -v $1`
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

  echo "JAVA_HOME:" $JAVA_HOME
  echo "java -version:"

  java -version
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
