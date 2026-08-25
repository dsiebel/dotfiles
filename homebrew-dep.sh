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

# setup fzf
/usr/local/opt/fzf/install --no-bash --no-fish \
 --key-bindings --no-completion --update-rc

# setup nano prerequisites
mkdir -p ~/.cache/nano/backups/
