#!/usr/bin/env bash
# Install cli for the Mac App Store
brew install mas

# GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# other useful utilities like `sponge`.
brew install moreutils

# networking
brew install telnet ipcalc prips wget

# shells
brew install zsh bash

# Switch to using brew-installed zsh as default shell
if ! grep -F -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# more recent versions of some macOS tools.
brew install vim grep

# git tools
brew install git lazygit

# other usefull binaries
brew install hugo ngrep xz tree jq shellcheck ranger direnv make tmux

brew install fzf \
 && /usr/local/opt/fzf/install --no-bash --no-fish --key-bindings --no-completion --update-rc

brew install go dep

brew tap jesseduffield/lazydocker \
 && brew install lazydocker

# Kubernetes
brew install kubernetes-cli kubectx
brew tap johanhaleby/kubetail \
 && brew install kubetail
brew install stern
brew install txn2/tap/kubefwd
brew install kubernetes-helm

# Hashicorp
brew install terraform
