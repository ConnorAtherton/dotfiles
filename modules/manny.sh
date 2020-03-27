#!/bin/bash

NOTES="$HOME/.notes"

#
# Idea: Manny keeps track of notes and displays then as man pages, for quick retrieval in the terminal.
#

manny::view () {
  NOTE="$NOTES"/$1.md

  if [ ! -f "$NOTE" ]; then
    echo "No note entry for $1" >&2
    return 1
  fi

  TITLE="$(echo $1 | tr '[:lower:]' '[:upper:]')"
  SECTION="Notes"
  AUTHOR="catherton"
  DATE="$(date +'%B %d, %Y' -r "$NOTE")"

  pandoc \
    --standalone \
    --from markdown \
    --to man \
    --metadata title="$TITLE" \
    --metadata author="$AUTHOR" \
    --metadata section="$SECTION" \
    --metadata date="$DATE" \
    "$NOTE" | groff -T utf8 -man | less -R
}

manny::edit () {
  mkdir -p "$NOTES"
  ${EDITOR:-vim} "$NOTES/$1.md"
}
