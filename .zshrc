# TODO: only if not already
# use zsh
# chsh -s $(which zsh)
rm -f ~/.zcompdump*

local pathdirs funcdirs

#
# Environment variables
#
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/home'
export EDITOR='vim'
export DOCKER_HOST="tcp://localhost:2375"
export ARCHFLAGS="-arch x86_64"

#
# TODO: copy private key into google instance too.
#
# export SSH_KEY_PATH="~/.ssh/rsa_id"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

unset path
unset fpath
unset PATH
unset FPATH

#
# Create a list of directories to add to the path
#
#PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
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
  # $install_path/share/zsh/$ZSH_VERSION/functions
  # $install_path/share/zsh/functions
  # $install_path/share/zsh/site-functions
  /share/zsh/$ZSH_VERSION/functions
  /share/zsh/functions
  /share/zsh/site-functions
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
  $HOME/scripts
)

#
# Add existing function directories to the fpath
#
for dir ($funcdirs) {
  if [[ -x $dir ]]; then
    echo $dir
    fpath=($dir $path)
  fi
}
echo $fpath

# export fpath

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
# TODO: make function path work so don't need this step
#
GEN_SCRIPTS=( peco general )
scripts=$HOME/.dotfiles/scripts
rm -f $scripts/all.zsh
for a in $GEN_SCRIPTS; do
  cat "$scripts/$a.zsh" >> "$scripts/all.zsh"
done

#
# TODO: what does this actually do?
#
# typeset path fpath >/dev/null 2>&1
export path

#
# Source everything into the shell
#
source $HOME/.aliases
# source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/scripts/all.zsh

