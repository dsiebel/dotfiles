# docs: https://github.com/casey/just/
# cheat-sheet: https://cheatography.com/linux-china/cheat-sheets/justfile/
# template: https://github.com/dsiebel/repository-template/blob/main/Justfile
set shell := ["bash", "-euo", "pipefail", "-c"]
set unstable
set script-interpreter := ['bash', '-euxo', 'pipefail']

_default:
  @just --list

# Installs everything
all: bin dotfiles macos vim homebrew-dep

# install bin directory files
[script]
bin:
	while IFS= read -r file; do
		f="$(basename "$file")"
		sudo ln -sf "$file" "/usr/local/bin/$f"
	done< <(find "{{ justfile_directory() }}/bin" -type f -not -name "meldDiff" -not -name ".*.swp" -not -name "vgaswitcheroo.sh")

# install the dotfiles for current user
[script]
dotfiles:
	git submodule init
	git submodule update

	while IFS= read -r file; do
		f="$(basename "${file}")"
		ln -sfn "${file}" "${HOME}/$f"
	done < <(find "{{ justfile_directory() }}" -type f -name ".*" -depth 1 -not -name ".git*" -not -name ".*.swp" -not -name ".gnupg")

	# special handling for .git* files to not mess with the repo
	while IFS= read -r file; do
		f="$(basename ${file})"
		echo ln -sfn "${file}" "${HOME}/${f/#dot/\.}"
	done< <(find {{ justfile_directory() }}/dotgit -name "dotgit*" -depth 1)

	# special handling for directories
	ln -sfn "{{ justfile_directory() }}/.oh-my-zsh" "${HOME}/.oh-my-zsh"
	ln -sfn "{{ justfile_directory() }}/.zsh-custom" "${HOME}/.zsh-custom"

	# we can not link the entire `.config` dir, it would only clutter up the git checkout
	mkdir -p "${HOME}/.config"
	ln -sfn "{{ justfile_directory() }}/.config/starship.toml" "${HOME}/.config/starship.toml"

	mkdir -p "${HOME}/.config/direnv"
	ln -sfn "{{ justfile_directory() }}/.config/direnv/direnv.toml" "${HOME}/.config/direnv/direnv.toml"

	mkdir -p "${HOME}/.config/mise"
	ln -sfn "{{ justfile_directory() }}/.config/mise/config.toml" "${HOME}/.config/mise/config.toml"

	mkdir -p "${HOME}/.config/yamllint"
	ln -sfn "{{ justfile_directory() }}/.config/yamllint/config.yaml" "${HOME}/.config/yamllint/config"

# setup macos
macos:
	"{{ justfile_directory() }}/macos.sh"

# install amix/vimrc
vim:
	"{{ justfile_directory() }}/vim.sh"

# install homebrew
[script]
homebrew:
	if ! command -v brew; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

# install brews
homebrew-dep: homebrew
	"{{ justfile_directory() }}/homebrew-dep.sh"

# install front via homebrew
[script]
homebrew-fonts: homebrew
	brew bundle install --file "{{ justfile_directory() }}/Brewfile-fonts"

# install vscode extensions
vscode-ext:
	"{{ justfile_directory() }}/vscode/install-vscode-extensions" "{{ justfile_directory() }}/vscode/extensions.txt"

# Runs all the tests on the files in the repository.
test: shellcheck

# Runs the shellcheck tests on the scripts.
[script]
shellcheck:
	pre-commit run --all-files shellcheck
