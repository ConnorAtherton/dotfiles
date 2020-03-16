#!/bin/bash

function update:all() {
  update::vim
  update::rust
}

function update::firmware() {
  update-firmware
  update-iwlwifi
}

function update::kubectl() {
	KUBERNETES_VERSION=$(curl -sSL https://storage.googleapis.com/kubernetes-release/release/stable.txt)
	# curl -sSL "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" > /usr/local/bin/kubectl
	curl -sSL "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/darwin/amd64/kubectl" > /usr/local/bin/kubectl
	chmod +x /usr/local/bin/kubectl
	echo "$(kubectl version --client --short)"
}

function update::apt() {
	apt -y update
	apt -y upgrade
	apt -y autoremove
	apt -y autoclean
	apt -y clean
	rm -rf /var/lib/apt/lists/*
}

function update::vim() {
  vim +PlugUpdate +qall
}

function update::brew() {
  brew upgrade
  # TODO: Update individual brews here also
}

function update::rust() {
  rustup update
}
