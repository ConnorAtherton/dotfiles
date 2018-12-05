#!/bin/bash

docker run --restart always -d \
  --name git_ui \
  -p 8080:8080 \
  -e BASE_GIT_URL="git@g.infra.connoratherton.com" \
  -e SITE_TITLE="Code" \
  -v "/mnt/persistent_git_storage:/home/git" \
  -w /home/git \
  r.j3ss.co/gitiles

docker run --restart always -d \
  --name git_server \
  -p 127.0.0.1:2222:22 \
  -e "PUBKEY=$(cat ~/.ssh/authorized_keys)" \
  -v "/mnt/persistent_git_storage:/home/git" \
  r.j3ss.co/gitserver
