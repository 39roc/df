# Shell integrations

# Local environment
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# zoxide (smart cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
