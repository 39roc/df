# Agnoster theme prompt customization

if typeset -f prompt_segment >/dev/null; then
	prompt_context() {
		if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
			prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
		fi
	}
fi

# AWS profile segment colors (agnoster's built-in prompt_aws shows "AWS: $AWS_PROFILE")
# 일반 프로필은 녹색, *-prod / *production* 프로필은 빨간색으로 강조하여 실수 방지
AGNOSTER_AWS_BG=green
AGNOSTER_AWS_FG=black
AGNOSTER_AWS_PROD_BG=red
AGNOSTER_AWS_PROD_FG=yellow
