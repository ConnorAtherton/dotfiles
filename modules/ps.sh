#!/bin/bash

function ps::killer() {
  filter="$*"

  ps aux |
    grep "${filter}" |
    grep -v 'grep' |
    grep -v 'killer' |
    awk '{print $2}' |
    xargs -P 4 -I{} kill -9 {} || echo "Failed to kill {}";
}

