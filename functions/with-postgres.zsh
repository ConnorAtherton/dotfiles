#!/bin/zsh

function with-postgres() {
  pg_ctl start;
  eval "$*"
  pg_ctl stop;
}
