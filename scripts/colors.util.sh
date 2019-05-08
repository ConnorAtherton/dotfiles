#!/bin/bash

if [ -z "$1" ]; then
    BREAK=1
else
    BREAK=$1
fi

for i in {0..255} ; do
    printf "\\x1b[38;5;%smcolour%s \\t" "$i" "$i"

    if [ $((i % BREAK)) -eq $((BREAK - 1)) ] ; then
        printf "\\n"
    fi
done
