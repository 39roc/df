# Completion system initialization and tool-specific completions

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# AWS CLI
command -v aws_completer &>/dev/null && complete -C "$(command -v aws_completer)" aws

# Terraform
command -v terraform &>/dev/null && complete -o nospace -C "$(command -v terraform)" terraform

# Azure CLI
if command -v brew &>/dev/null; then
	az_completion="$(brew --prefix)/etc/bash_completion.d/az"
	[[ -f "$az_completion" ]] && source "$az_completion"
	unset az_completion
fi

# kubectl
command -v kubectl &>/dev/null && source <(kubectl completion zsh)

# Helm
command -v helm &>/dev/null && source <(helm completion zsh)
