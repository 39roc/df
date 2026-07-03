# Custom aliases

# kubectl
command -v kubectl &>/dev/null && alias k='kubectl'

# Tizen sdb
[[ -x "$HOME/tizen-studio/tools/sdb" ]] && alias sdb="$HOME/tizen-studio/tools/sdb"

# Docker Compose
command -v docker-compose &>/dev/null && alias ds='docker-compose'

# Claude Code (dangerously skip permissions)
command -v claude &>/dev/null && alias ccd='claude --dangerously-skip-permissions'

# AWS profile switcher — 선택한 프로필의 값을 [default] 프로필로 복사(영속 전환)
#   awsp <name>  지정 프로필을 기본(default)으로 전환
#   awsp         fzf로 골라서 전환
awsp() {
	local profile="$1"
	if [[ -z "$profile" ]]; then
		profile=$(aws configure list-profiles | grep -vx default | fzf --height 40% --prompt="Set default AWS profile> ")
		[[ -z "$profile" ]] && return
	fi
	if ! aws configure list-profiles | grep -qx "$profile"; then
		echo "awsp: profile '$profile' not found" >&2
		return 1
	fi
	local key val
	for key in aws_access_key_id aws_secret_access_key aws_session_token region output; do
		val=$(aws configure get "$key" --profile "$profile" 2>/dev/null)
		if [[ -n "$val" ]]; then
			aws configure set "$key" "$val" --profile default
		elif [[ "$key" == aws_session_token ]]; then
			aws configure set "$key" "" --profile default   # 이전 세션 토큰 잔재 제거
		fi
	done
	print -r -- "$profile" >"$HOME/.aws/.default_source"   # 프롬프트 표시용 원본 이름 기록
	unset AWS_PROFILE   # 환경변수가 [default]를 덮어쓰지 않도록 해제
	echo "default profile <- $profile"
}
alias awsw='cat "$HOME/.aws/.default_source" 2>/dev/null || echo default'   # 현재 기본 프로필
alias awsl='aws configure list-profiles'                                    # 프로필 목록
