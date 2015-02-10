# kill process
function peco-kill-process() {
    ps ax -o pid,time,command | peco --query "$LBUFFER" | awk '{print $1}' | xargs kill
}

alias pkp='peco-kill-process'

function switch_to_zsh() {
  chsh -s /bin/zsh
  echo "switched to zsh"
}

function install_xcode() {
  xcode-select --install
  echo "installed xcode"
}

# so useful!
function restart_finder() {
  killall Finder
}

function show_hidden_files() {
  defaults write com.apple.finder AppleShowAllFiles TRUE
  restart_finder
}

function hide_hidden_files() {
  defaults write com.apple.finder AppleShowAllFiles FALSE
  restart_finder
}

# find shorthand
# find ./ -name '*.js'
function f() {
  find . -name "$1"
}

# Create a new directory and enter it
function md() {
  mkdir -p "$1" && cd "$1"
}

