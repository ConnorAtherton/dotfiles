#!/bin/bash

docker run --restart always -d \
  --name git_ui \
  -p 127.0.0.1:8080:8080 \
  -e BASE_GIT_URL="git@playground" \
  -e SITE_TITLE="Code Playground" \
  -v "/mnt/persistent_git_storage:/home/git:ro" \
  -w /home/git \
  r.j3ss.co/gitiles

docker run --restart always -d \
  --name git_server \
  -p 0.0.0.0:2222:22 \
  -e "PUBKEY=$(cat /var/stacks/authorized_git_keys)" \
  -v "/mnt/persistent_git_storage:/home/git" \
  r.j3ss.co/gitserver
