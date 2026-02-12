# Agnoster theme prompt customization

if typeset -f prompt_segment >/dev/null; then
	prompt_context() {
		if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
			prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
		fi
	}
fi
