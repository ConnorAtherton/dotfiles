#!/bin/zsh

# Makes a tarball of a directory
function tarball() {
  if [ $# -lt 1 ]; then
    echo>&2 tarball DIRECTORY
    return 2
  fi

  local parent="$(dirname "$1")"
  local dir="$(basename "$1")"

  run tar -czvf "$dir.tgz" -C "$parent" "$dir/"
}
