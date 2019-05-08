#!/bin/bash

# Change defaults
# JUst in case the shell was not changed
update-alternatives --set x-terminal-emulator /usr/bin/urxvt
usermod -s /usr/bin/zsh "$(whoami)"

# Install Docker
# Add Docker’s official GPG key:
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Check the GPG fingerprint successfully added (should see output from this command)
sudo apt-key fingerprint 0EBFCD88
sudo apt-get install docker-ce

# Add the Docker repository for the Xenial build
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   xenial \
   stable"

# Create a new docker group
sudo groupadd docker

# Add your user to the docker group.
# This script assumes that your current user
# is the one you want to be a docker admin
sudo usermod -aG docker "$USER"

