# use zsh
# chsh -s $(which zsh)
#
rm -f ~/.zcompdump >/dev/null 2>&1

# Enable profiling
zmodload zsh/zprof

local pathdirs funcdirs

#
# Environment variables
#
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME="$(/usr/libexec/java_home)"
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

#
# History settings
#

# Huge history without duplicates and a nice
# time format please.
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTTIMEFORMAT='%F %T '

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

#
# Gimme that zsh goodness
#
source $ZSH/oh-my-zsh.sh

#
# Unset everything from scratch so we control the
# variables.
#
unset path
unset fpath
unset PATH
unset FPATH

#
# Create a list of directories to add to the path
#
pathdirs=(
  # Needs to go first for shims
  $HOME/.rbenv/shims

  /usr/local/bin
  # NOTE: Homebrew's sbin
  /usr/local/sbin
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/go/libexec/bin

  /bin
  /sbin
  /usr/sbin
  /usr/bin
  /usr/X11/bin

  $GOPATH/bin

  $HOME/bin
  $HOME/.cargo/bin
)

#
# Query the gem configuration to get the correct path
# XXX: This might cause problems if you alias 'gem' to something else after the path has been setup.
#
if [[ -x $(which gem) ]]; then
  # 's.:.' creates an array by splitting on ':'.
  gemdirs=(${(s.:.)"$(gem environment gempath)"})
  # The paths above don't end with /bin.
  for dir ($gemdirs) { pathdirs=($pathdirs "$dir/bin") }
fi

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
local binary=$(which zsh)
local install_path=$binary:h:h # Strip bin/zsh to find installation path.

funcdirs=(
  $HOME/.zsh/func
  $install_path/share/zsh/$ZSH_VERSION/functions
  $install_path/share/zsh/functions
  $install_path/share/zsh/site-functions
  /usr/share/zsh/$ZSH_VERSION/functions
  /usr/share/zsh/functions
  /usr/share/zsh/site-functions
  /usr/share/zsh-completions
  /usr/local/share/zsh-completions
  /usr/share/zsh/$ZSH_VERSION/functions
  /usr/share/zsh/functions
  /usr/share/zsh/site-functions
  /usr/share/zsh-completions
  /usr/local/share/zsh-completions
  $HOME/functions
  $HOME/.functions
  $HOME/.dotfiles/functions
  $GOPATH/bin
)

#
# Add existing function directories to the fpath
#
for dir ($funcdirs) {
  if [[ -x $dir ]]; then
    fpath=($fpath $dir)
  fi
}

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

#
# Autoload functions
#
autoload -Uz peco-kill-process hide-hidden-files md permission \
  restart-finder show-hidden-files start-fokus flush-dns-cache

#
# Source everything into the shell
#
source ~/.lazy_load
source ~/.aliases
source ~/.functions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Print out profiling
# zprof
