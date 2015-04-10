# use zsh
# chsh -s $(which zsh)
#
rm -f ~/.zcompdump* >/dev/null 2>&1

local pathdirs funcdirs

#
# Environment variables
#
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/home'
export EDITOR='vim'
export DOCKER_HOST="tcp://localhost:2375"
export ARCHFLAGS="-arch x86_64"
export VIMRC="~/.vimrc"

#
# TODO: copy private key into google instance too.
#
# export SSH_KEY_PATH="~/.ssh/rsa_id"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
    /usr/local/bin
    /usr/local/opt/coreutils/libexec/gnubin
		/usr/local/heroku/bin
    /usr/bin
    /bin
    /sbin
    /usr/sbin
    /usr/X11/bin

    $HOME/Applications/VMWare\ Fusion.app/Content/Library
    $HOME/bin
    $HOME/.rbenv/bin
    $HOME/google-cloud-sdk/bin
    $HOME/Bitnami/arc/arcanist/bin
    $HOME/pebble-dev/PebbleSDK-3.0-dp1/bin
)

# Query the gem configuration to get the correct path
# XXX: This might cause problems if you alias 'gem' to something else after the path has been setup.
if [[ -x $(which gem) ]]; then
  # 's.:.' creates an array by splitting on ':'.
  gemdirs=(${(s.:.)"$(gem environment gempath)"})
  # The paths above don't end with /bin.
  for dir ($gemdirs) { pathdirs=($pathdirs "$dir/bin") }
fi

# Add directories which exist to the path
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
)

#
# Add existing function directories to the fpath
#
for dir ($funcdirs) {
  if [[ -x $dir ]]; then
    fpath=($fpath $dir)
  fi
}

# source $ZSH/oh-my-zsh
source $ZSH/oh-my-zsh.sh

#
# rbenv init
#
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

#
# Enable fzf
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# Remap some keys
#
bindkey '^b' beginning-of-line

#
# TODO: what does this actually do?
#
export path
export fpath

#
# Source everything into the shell
#
source $HOME/.aliases
source $HOME/.dotfiles/scripts/all.zsh

