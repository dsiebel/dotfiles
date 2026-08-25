# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
[[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.bash"

# Default options
# ---------------
export FZF_DEFAULT_OPTS='--height 40% --border --info=inline'
