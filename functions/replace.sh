#!/bin/bash

_do_replace() {
	echo ">> Searching '${FROM}' in '${1}' ..."

	echo
	ag "${FROM}" "${1}"

	# echo
	# vared -p "Replace in '${1}'? [y/N] " -c REPLY

	# if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	# 	return 0
	# fi

	sed -i file.bak "s/${FROM}/${TO}/g" "${1}"
}

replace() {
  if [[ $# != 2 ]]; then
    echo "$0 <string-to-search> <replacement>"
    return 1
  fi

  export FROM="$1"
  export TO="$2"

  echo "Replacing '${FROM}' with '${TO}'"

  ag -l "${FROM}" . | while read -r file; do
    _do_replace "${file}"
  done
}