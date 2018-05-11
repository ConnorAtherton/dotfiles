#!/bin/zsh

# Checks if a command exists in the current environment.
#
# $1 - Command to check for
exists() {
  command -v "$1" &>/dev/null
}

# Find Operating system
os() {
  local os=

  case uname in
    Linux*) os=linux ;;
    Darwin*) os=darwin ;;
  esac

  echo "$os"
}

# Remove a file from the home directory.
#
# $1 - Name of file to remove
remove_from_home () {
  FILEPATH=$HOME/$1

  if [[ -a $FILEPATH ]]; then

    if [[ -d $FILEPATH ]]; then
      rm -rf $FILEPATH
    elif [ -h $FILEPATH ]; then
      unlink $FILEPATH
    else
      rm $FILEPATH
    fi
  fi
}

#
# Text functions
#

# Transforms a newline string to a comma string
#
# $1 - input string with newline chars
newline_join() {
  echo -e "$1" | tr -s '\r\n' ', ' | sed -e "s/, $//"
}

#
# Output functions
#

# Prints a message with a specific color. Mainly used for debug messages.
#
# $1 - ANSII color code
# $2 - Message to print
print_color() {
  echo -e "\e[38;05;${1}m ${2}\e[0m"
}

print_color_bold() {
  echo -e "\e[38;05;${1}m\e[1m ${2}\e[0m"
}

local prependStr=""

print_yellow() { print_color 33 "$prependStr$1" }
print_green()  { print_color 48 "$prependStr$1" }
print_green_bold()  { print_color_bold 48 "$prependStr$1" }
print_blue()   { print_color 32 "$prependStr$1" }
print_gray()   { print_color 8 "$prependStr$1" }
print_red()    { print_color 196 "$prependStr$1" }
debug()        { print_red "[DEBUG] $prependStr$1" }
bold()   { echo -e "\e[1m$1\e[0m" }

# Prints the dotfiles header. Only useful for the install script.
print_dotfiles_header() {
  print_color 201 "  __  _ _____              ___ _ _"
  print_color 13  " /  \/ |____ \       _    / __|_) |"
  print_color 123 "(_/\__/ _   \ \ ___ | |_ | |__ _| | ____  ___"
  print_color 155 "       | |   | / _ \|  _)|  __) | |/ _  )/___)"
  print_color 180 "       | |__/ / |_| | |__| |  | | ( (/ /|___ |"
  print_color 201 "       |_____/ \___/ \___)_|  |_|_|\____|___/"
  echo ""
}

up_n_lines() {
  echo -en "\e[${1}A"
}

#
# Spinner functions
#

# Starts the spinner and places the job in the background so we can do other work.
#
# $1 - Optional message to display with the spinner
start_spinner() {
  echo ""
  spinner_loop "$1" &

  # Store these as globals for when we stop
  spinner_message=$1
  spinner_pid=$!

  disown
}

# TODO
SPINNER_DOTS=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
SPINNER_ARROWS=(▹▹▹▹▹ ▸▹▹▹▹ ▹▸▹▹▹ ▹▹▸▹▹ ▹▹▹▸▹ ▹▹▹▹▸)

# The actual loop of the spinner.
#
# $1 - Optional message to display with the spinner
#
# ~private
spinner_loop() {
  local delay=0.1

  # NOTE: Doing this because in the future I would like to have multiple different dots to choose
  # from when configuring the dotfiles.
  local -a spinnerArray
  spinnerArray=('\' '|' '/' '-')

  local length=${#spinnerArray[*]}

  i=0
  charIndex=0
  arrChar=''

  # Start spinning
  while true
  do
    charIndex=$(($i%$length))
    arrChar=${spinnerArray:$charIndex:1}

    up_n_lines 1
    print_green "$arrChar $1"
    sleep $delay

    i=$(($i+1))
  done
}

stop_spinner() {
  local pid="${spinner_pid}"

  if [[ -z $pid ]]; then
    print_red "Tried to stop spinner but it was not running"
    exit 1
  fi

  kill $pid >/dev/null 2>&1

  up_n_lines 1
  print_green_bold "✔ $spinner_message"
}
