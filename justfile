# docs: https://github.com/casey/just/
# cheat-sheet: https://cheatography.com/linux-china/cheat-sheets/justfile/
# template: https://github.com/dsiebel/repository-template/blob/main/Justfile
set shell := ["bash", "-euo", "pipefail", "-c"]
set unstable
set script-interpreter := ['bash', '-euxo', 'pipefail']

docker_machine_name	:= "default"

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
	echo ln -sfn "{{ justfile_directory() }}/.oh-my-zsh" "${HOME}/.oh-my-zsh"
	echo ln -sfn "{{ justfile_directory() }}/.zsh-custom" "${HOME}/.zsh-custom"

	# we can not link the entire `.config` dir, it would only clutter up the git checkout
	mkdir -p "${HOME}/.config"
	echo ln -sfn "{{ justfile_directory() }}/.config/starship.toml" "${HOME}/.config/starship.toml"

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


# set up docker-machine. Use docker_machine_name to overwrite machine name
docker-machine:
	"{{ justfile_directory() }}/docker-machine.sh" "{{ docker_machine_name }}"

# Runs all the tests on the files in the repository.
test: shellcheck

# Runs the shellcheck tests on the scripts.
[script]
shellcheck:
	# if this session isn't interactive, then we don't want to allocate a
	# TTY, which would fail, but if it is interactive, we do want to attach
	# so that the user can send e.g. ^C through.
	if [[ -t 0 ]]; then
		DOCKER_FLAGS="--tty"
	fi

	docker run --rm --interactive "${DOCKER_FLAGS}" \
		--name dotfiles-shellcheck \
		--volume "{{ justfile_directory() }}:/opt/src:ro" \
		--volume "{{justfile_directory() }}/test.sh:/opt/test.sh:ro" \
		--workdir /opt/src \
		--entrypoint /opt/test.sh \
		ghcr.io/dsiebel/shellcheck-docker:latest
