rm -f ~/.zcompdump >/dev/null 2>&1

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
# History settings
#

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL="erasedups:ignoreboth"
HISTTIMEFORMAT='%F %T '

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

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
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

#
# Go programming
#
mkdir -p "$GOPATH/bin"

#
# FZF fuzzy searching
#
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
source ~/.aliases
source ~/.functions

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

# Print out profiling
# zprof
