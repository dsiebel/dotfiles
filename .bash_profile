#!/usr/bin/env bash

# configure XDEBUG support
# export XDEBUG_CONFIG="idekey=XDEBUG";

# use vim as default editor for everything
export EDITOR="/usr/bin/vim"
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$EDITOR

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Prefer US English and use UTF-8
export LC_ALL='en_US.UTF-8';
export LANG='en_US.UTF-8';
export LC_LANG='en_US.UTF-8';

# Highlight section titles in man pages
export LESS_TERMCAP_md="${yellow}";

# Don't clear screen after quitting man page
export MANPAGER='less -X';
# export MANPATH="/usr/local/man:$MANPATH"

# setup java properly. Thanks, Steve!
export JAVA_HOME="$(/usr/libexec/java_home)";

# Golang $GOPATH. Do the kids still do it like this nowadays?
export GOPATH="${HOME}/workspace/source/Go"

# check for nvm and load it if present
#export NVM_DIR="/Users/dsiebel/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export GRADLE_USER_HOME="${HOME}/.gradle"

export GPG_TTY="$(tty)"

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# https://krew.sigs.k8s.io/docs/user-guide/advanced-configuration/
# used in `.path`
export KREW_ROOT="${HOME}/.krew"

# Allow `tenv` to automatically install missing versions
export TENV_AUTO_INSTALL=true

# Terragrunt: Default to Terraform instead of OpenTofo
# export TERRAGRUNT_TFPATH="terraform"

# Source user's bashrc
[[ -f "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc"
