# ~/.zshrc - Modular zsh configuration
# Config files are loaded from conf.d/ in numeric order.

export DOTFILES="$HOME/df"

for conf in "$DOTFILES/zsh/conf.d/"*.zsh; do
	[ -r "$conf" ] && source "$conf"
done
unset conf
