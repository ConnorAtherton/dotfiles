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

  debug "Removing from home $FILEPATH"
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

print_yellow() { print_color 3 "$prependStr$1" }
print_green()  { print_color 48 "$prependStr$1" }

print_green_bold()  {
  print_color_bold 48 "$prependStr$1"
}

print_blue()   { print_color 4 "$prependStr$1" }
print_gray()   { print_color 8 "$prependStr$1" }
print_red()    { print_color 196 "$prependStr$1" }

debug() {
  [[ -v $DOTFILES_DEBUG ]] && print_color_bold 8 "| \e[38;05;3m$1\e[0m"
}

bold() {
  echo -e "\e[1m$1\e[0m"
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
  spinner_stage_start_time=$(date +'%s')

  if [[ -v "${DOTFILES_DEBUG}" ]]; then
    print_green_bold "$1"
    return 0
  fi

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

stop_spinner() {
  local spinner_stage_end_time=$(date +'%s')
  local elapsed_time=$(($spinner_stage_end_time - $spinner_stage_start_time))

  if [[ -v "${DOTFILES_DEBUG}" ]]; then
    print_green "$1"
    echo -e "\e[38;05;8m Complete in ${elapsed_time}s\e[0m"
    echo ""
    return 0
  fi

  local pid="${spinner_pid}"

  if [[ -z $pid ]]; then
    print_red "Tried to stop spinner but it was not running"
    exit 1
  fi

  kill $pid >/dev/null 2>&1

  up_n_lines 1
  print_green_bold "✔ $spinner_message \e[38;05;8m(${elapsed_time}s)\e[0m"
}

# The actual loop of the spinner.
#
# $1 - Optional message to display with the spinner
#
# ~private
spinner_loop() {
  local delay=0.05

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

# print_theme_color_balls() {
# f=3 b=4
# for j in f b; do
#   for i in {0..7}; do
#     printf -v $j$i %b "\e[${!j}${i}m"
#   done
# done
# d=$'\e[1m'
# t=$'\e[0m'
# v=$'\e[7m'

# # Symbol
# s=
# # s=

# cat << EOF
#  $f0$s$d$s$t $f1$s$d$s$t $f2$s$d$s$t $f3$s$d$s$t
#  $f4$s$d$s$t $f5$s$d$s$t $f6$s$d$s$t $f7$s$d$s$t
# EOF
# }
