#!/bin/zsh

function tarball() {
  pg_ctl start;
  eval "$*"
  pg_ctl stop;
}
