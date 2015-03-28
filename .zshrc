local pathdirs funcdirs

#
# Environment variables
#
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/home'
export EDITOR='vim'
export DOCKER_HOST="tcp://localhost:2375"
# export ARCHFLAGS="-arch x86_64"
#
# TODO: copy private key into google instance too.
#
# export SSH_KEY_PATH="~/.ssh/rsa_id"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

unset path
unset PATH
echo $PATH
echo "========"
echo path
echo PATH

#
# Create a list of directories to add to the path
#
pathdirs=(
    /usr/local/bin
    /usr/local/opt/coreutils/libexec/gnubin
		/usr/local/heroku/bin
    /bin

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
      echo "adding to path" $dir
        path=($dir $path)
    fi
}

echo $path
export path

#
# Create a list of function paths for zsh
#
funcdirs=(
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
    fpath=($dir $fpath)
  fi
}

#
# rbenv init
#
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

# if which ruby >/dev/null && which gem >/dev/null; then
#   PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
# fi

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
# TODO: find out exactly what /dev/null is
# TODO: find a way to clear this path first.
#
# export path >/dev/null
# export fpath >/dev/null

#
# TODO: what does this actually do?
#
typeset path fpath >/dev/null

# When sourcing .zshrc we only want the general functions
# to be sourced

#
# Source everything into the shell
#
source $HOME/.aliases
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/scripts/all.zsh

