# Oh-my-zsh core setup

export ZSH="$HOME/.oh-my-zsh"

if [[ -d "$ZSH" ]]; then
	ZSH_THEME="agnoster"

	plugins=(
		git
		zsh-autosuggestions
		zsh-syntax-highlighting
		docker
		docker-compose
	)

	source "$ZSH/oh-my-zsh.sh"
fi
