# Agnoster theme prompt customization

if typeset -f prompt_segment >/dev/null; then
	prompt_context() {
		if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
			prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
		fi
	}
fi

# AWS profile prompt segment
# awsp 는 선택 프로필을 [default]로 복사하므로 AWS_PROFILE 이 아닌
# awsp 가 기록한 원본 이름(~/.aws/.default_source)을 표시한다.
# 일반 프로필은 녹색, *-prod / *production* 프로필은 빨간색으로 강조하여 실수 방지
if typeset -f prompt_segment >/dev/null; then
	prompt_aws() {
		[[ "$SHOW_AWS_PROMPT" = false ]] && return
		local p="$AWS_PROFILE"
		[[ -z "$p" && -f "$HOME/.aws/.default_source" ]] && p=$(<"$HOME/.aws/.default_source")
		[[ -z "$p" ]] && return
		case "$p" in
			*-prod|*production*) prompt_segment red yellow "aws: ${p:gs/%/%%}" ;;
			*) prompt_segment green black "aws: ${p:gs/%/%%}" ;;
		esac
	}
fi
