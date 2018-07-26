#!/usr/bin/env bash

__install() {
    sudo apt-get update
    sudo apt-get install --no-install-recommends --yes --autoremove \
    "$@"
}

__install apt-transport-https build-essential git make curl wget vim tmux xz-utils \
 docker.io docker-compose

sudo mkdir -p /usr/local/opt
git clone --depth 1 https://github.com/junegunn/fzf.git /usr/local/opt/fzf
/usr/local/opt/fzf/install --bin


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

__install kubectl
