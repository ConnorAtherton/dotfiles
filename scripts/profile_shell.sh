#!/bin/bash

echo -e "Zsh profiling:\n"
for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
echo -e "Done.\n\n"

echo -e "Bash profiling: \n"
for i in $(seq 1 10); do /usr/bin/time bash -i -c 'exit >/dev/null'; done
echo -e "Done.\n\n"
