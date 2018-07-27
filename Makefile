MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --no-print-directory
MAKEFLAGS += --warn-undefined-variables

SHELL := bash
.SHELLFLAGS := -euo pipefail -c

.ONESHELL:

# add local scripts to PATH for easy reference
# try to avoid nesting scripts!
PATH := $(PATH):$(CURDIR)/scripts

OS=$(shell source scripts/detect-os; echo $$OS_NAME | tr '[:upper:]' '[:lower:]' | sed 's/ /-/')
KERNEL=$(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(shell uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VERSION=$(shell source scripts/detect-os; echo $$VERSION)

.PHONY: help
help:
	@echo "Kernel: $(KERNEL), OS: $(OS), Architecture: $(ARCH), Version: $(VERSION)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: install
install: $(OS)
	@echo "your $(OS) is all set up for you."

.PHONY: bin
bin: ## install bin directory files
	for file in $(shell find $(CURDIR)/bin -type f -not -name "meldDiff" \
	 -not -name ".*.swp" -not -name "vgaswitcheroo.sh"); do
		f=$$(basename $$file);
		sudo ln -sf $$file /usr/local/bin/$$f
	done

.PHONY: dotfiles
dotfiles: ## install the dotfiles for current user
	git submodule init
	git submodule update
	for file in $(shell find $(CURDIR) -maxdepth 1 -name ".*" -not -name ".gitignore" \
	 -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do
		f=$$(basename $$file)
		ln -sfn $$file $(HOME)/$$f
	done
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore

.PHONY: darwin
darwin: bin dotfiles vim brews casks docker-machine ## setup macos
	setup-darwin
	install-vscode-extensions

.PHONY: linux-mint
linux-mint: bin dotfiles vim ## setup linux mint
	setup-linux-mint
	install-vscode-deb
	install-vscode-extensions

.PHONY: fzf ## install fzf
fzf:
	install-fzf

.PHONY: vim
vim: ## install amix/vimrc
	install-vimrc

.PHONY: homebrew (macos)
homebrew: ## install homebrew
	if ! which brew; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	brew update

.PHONY: brews
brews: homebrew ## install brews (macos)
	install-brews


.PHONY: casks
casks: homebrew ## install homebrew casks (macos)
	install-casks

DOCKER_MACHINE_NAME ?= default

.PHONY: docker-machine
docker-machine: ## set up docker-machine (macos). Use DOCKER_MACHINE_NAME to overwrite machine name
	setup-docker-machine $(DOCKER_MACHINE_NAME)

.PHONY: composer
composer: ## install composer (requires php)
	install-composer

.PHONY: test
test: shellcheck ## Runs all the tests on the files in the repository.

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [[ -t 0 ]] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += --tty
endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm --interactive $(DOCKER_FLAGS) \
		--name df-shellcheck \
		--volume $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		--entrypoint scripts/run-shellcheck \
		dsiebel/shellcheck-docker
