# Custom aliases

# kubectl
command -v kubectl &>/dev/null && alias k='kubectl'

# Tizen sdb
[[ -x "$HOME/tizen-studio/tools/sdb" ]] && alias sdb="$HOME/tizen-studio/tools/sdb"

# Docker Compose
command -v docker-compose &>/dev/null && alias ds='docker-compose'

# Claude Code (dangerously skip permissions)
command -v claude &>/dev/null && alias ccd='claude --dangerously-skip-permissions'
