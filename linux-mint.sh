#!/usr/bin/env bash

__install() {
    sudo apt-get update
    sudo apt-get install --no-install-recommends --yes --autoremove \
    "$@"
}

__install apt-transport-https build-essential git make curl wget vim tmux xz-utils \
 docker.io docker-compose

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

__install kubectl
