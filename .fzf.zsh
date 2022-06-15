# Auto-completion
# ---------------
# HOMEBREW_PREFIX won't work here, because fzf is only installed for arm64
# [[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# HOMEBREW_PREFIX won't work here, because fzf is only installed for arm64
# source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Default options
# ---------------
export FZF_DEFAULT_OPTS='--height 40% --border --info=inline'
