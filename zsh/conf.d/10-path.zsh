# PATH additions

# local bin (claude, etc.)
[[ -d "$HOME/.local/bin" ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

# pnpm
if [[ -d "$HOME/Library/pnpm" ]]; then
	export PNPM_HOME="$HOME/Library/pnpm"
	[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"
fi

# Tizen CLI
[[ -d "$HOME/tizen-studio/tools/ide/bin" ]] && export PATH="$PATH:$HOME/tizen-studio/tools/ide/bin"
