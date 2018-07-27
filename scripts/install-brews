#!/usr/bin/env bash

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install shells
brew install zsh
brew install bash

# Switch to using brew-installed zsh as default shell
if ! grep -F -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

# Install git tools
brew install git
brew install git-lfs

# Install other usefull binaries
brew install hugo
brew install ngrep
brew install xz
brew install tree
brew install jq
brew install shellcheck
brew install ranger

brew install go
brew install dep

brew install awscli

brew install docker-machine-nfs

brew install kubernetes-cli
brew install kubectx

brew install telnet

# Install php & extensions
brew tap homebrew/php
brew install php71
brew install php71-apcu
brew install php71-imagick
brew install php71-intl
brew install php71-mcrypt
brew install php71-memcached
brew install php71-opcache
brew install php71-redis
brew install php71-xdebug
