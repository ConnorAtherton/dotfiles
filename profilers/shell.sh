#!/bin/bash

echo -e "\\nZsh profiling: \\n"
# shellcheck disable=SC2034
for i in $(seq 1 10); do /usr/bin/time zsh -c exit; done

echo -e "\\nBash profiling: \\n"
# shellcheck disable=SC2034
for i in $(seq 1 10); do /usr/bin/time bash -c 'exit &>/dev/null'; done

echo -e "Done."
