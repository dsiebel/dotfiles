#!/usr/bin/env bash
set -e

brew bundle install --no-upgrade

# Switch to using brew-installed zsh as default shell
# TODO: this seems to require $PATH to be setup properly beforehand.
zsh_path="$(command -v zsh)"
readonly zsh_path
if ! grep -F -q "${zsh_path}" /etc/shells; then
  echo "${zsh_path}" | sudo tee -a /etc/shells;
  chsh -s "${zsh_path}";
fi;

# set iterm integration
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh \
 -o ~/.iterm2_shell_integration.zsh

# setup fzf
/usr/local/opt/fzf/install --no-bash --no-fish \
 --key-bindings --no-completion --update-rc

# setup kubectl and krew
# https://github.com/kubernetes-sigs/krew#bash-and-zsh
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install \
    --manifest=krew.yaml --archive=krew.tar.gz
)
"${HOME}/.krew/bin/kubectl-krew" install \
 doctor get-all krew outdated preflight restart sniff tail

# setup nano prerequisites
mkdir -p ~/.cache/nano/backups/
