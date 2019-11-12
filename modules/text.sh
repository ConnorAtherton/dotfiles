#!/bin/bash

# Finds most common occurences or words in a text file
function text::most_common_words() {
    tr -cs A-Za-z '\n' |
    tr A-Z a-z |
    sort |
    uniq -c |
    sort -rn |
    sed ${1}q
}

# Counts blank lines present in stdin
# TODO: Make this a unix koan
function text::count_blank_lines() {
  awk 'BEGIN { x=0 }; /^$/ { x=x+1 }; END { print "\t" x }'
}

# Removes duplicate lines in a file and prints to stdout
function text::remove_duplicate_lines() {
  awk '!a[$0]++'
}
