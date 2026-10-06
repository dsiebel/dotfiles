#!/usr/bin/env bash

# Setup homebrew env vars
# Note: PATH will be overwritten later
if [[ "$(/usr/bin/arch)" == "i386" ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
else
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

for file in ~/.{aliases,bash_aliases,dockerfunc,extra,functions,fzf.bash,path}; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
done;
unset file;

# Added by OrbStack: command-line tools and integration
source "${HOME}/.orbstack/shell/init.zsh" 2>/dev/null || :

# google-cloud-sdk completions
[[ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ]] \
	&& source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# https://starship.rs
if command -v starship > /dev/null ; then
	eval "$(starship init bash)"
fi

# worktrunk shell integration
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi
