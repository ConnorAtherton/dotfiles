#!/bin/bash

# Manual locations
# /usr/local/bin/catherton -> binaries
# $HOME/installed/catherton -> shared install paths

# TODO: do this in a temporary directory, not here!
# TODO: Add checksums
# TODO: Write a function to install manually from file
# utils::file::download_and_verify \
#   https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip \
#   https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_SHA256sums
#
# wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
# unzip terraform_0.11.10_linux_amd64.zip

# # TODO: Move all binaries to a different location here
# sudo mv terraform /usr/local/bin/catherton/terraform

# TODO: Test
terraform --version

pull_github_code() {
  local url=$1
  local folder=$2

  if [[ ! -d "$folder" ]]; then
    env git clone --depth=1 "$url" "$folder"
  else
    cd "$folder" || exit
    env git pull "$url"
    cd - ||  exit
  fi
}


#
# TODO: pretty print
# NOTE: I took this line from looking at the install script and extracting
# just what I needed
#
# TODO: utils::commands::require "git"

pull_github_code \
  git@github.com:robbyrussell/oh-my-zsh.git \
  "$HOME/.oh-my-zsh"

# pull_github_code \
#   git@github.com:zsh-users/zsh-syntax-highlighting.git \
#   $HOME/installed/catherton/zsh-syntax-highlighting

