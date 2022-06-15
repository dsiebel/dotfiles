# Load the shell dotfiles, and then some:
# # * ~/.aliases      Shell aliases
# # * ~/.functions    Helper functions
# # * ~/.dockerfunc   Docker specific helper functions
# # * ~/.extra        Other setting that MUST NOT be committed
# # * ~/.path         Extend `$PATH`. Always loaded last.
for file in ~/.{aliases,functions,dockerfunc,extra,path}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git brew osx sublime kubectl kube-ps1)
plugins=(brew copyfile copypath direnv docker git kubectl helm macos web-search)

source $ZSH/oh-my-zsh.sh

# load fzf
[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

# google-cloud-sdk completions
[ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ] \
	&& source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# https://starship.rs
if command -v starship > /dev/null ; then
	eval "$(starship init zsh)"
fi
