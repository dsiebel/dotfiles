.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: bin dotfiles macos vim brews casks docker-machine ## Installs everything

.PHONY: bin
bin: ## install bin directory files
	for file in $(shell find $(CURDIR)/bin -type f -not -name "meldDiff" -not -name ".*.swp" -not -name "vgaswitcheroo.sh"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

.PHONY: dotfiles
dotfiles: ## install the dotfiles for current user
	git submodule init
	git submodule update
	for file in $(shell find $(CURDIR) -name ".*" -depth 1 -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore;

.PHONY: macos
macos: ## setup macos
	$(CURDIR)/macos.sh

.PHONY: vim
vim: ## install amix/vimrc
	$(CURDIR)/vim.sh

.PHONY: homebrew
homebrew: ## install homebrew
	if ! which brew; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	brew update

.PHONY: brews
brews: homebrew ## install brews
	$(CURDIR)/brews.sh


.PHONY: casks
casks: homebrew ## install homebrew casks
	$(CURDIR)/casks.sh

DOCKER_MACHINE_NAME ?= default

.PHONY: docker-machine
docker-machine: ## set up docker-machine. Use DOCKER_MACHINE_NAME to overwrite machine name
	$(CURDIR)/docker-machine.sh $(DOCKER_MACHINE_NAME)

.PHONY: composer
composer: ## install composer (requires php)
	$(CURDIR)/composer.sh
