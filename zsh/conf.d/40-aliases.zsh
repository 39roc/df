# Custom aliases

# kubectl
command -v kubectl &>/dev/null && alias k='kubectl'

# Tizen sdb
[[ -x "$HOME/tizen-studio/tools/sdb" ]] && alias sdb="$HOME/tizen-studio/tools/sdb"

# Docker Compose
command -v docker-compose &>/dev/null && alias ds='docker-compose'

# Claude Code (dangerously skip permissions)
command -v claude &>/dev/null && alias ccd='claude --dangerously-skip-permissions'

# AWS profile switcher
#   awsp <name>  프로필 지정 전환
#   awsp         fzf로 골라서 전환
awsp() {
	if [[ -z "$1" ]]; then
		local p
		p=$(aws configure list-profiles | fzf --height 40% --prompt="AWS profile> ")
		[[ -n "$p" ]] && export AWS_PROFILE="$p"
	else
		export AWS_PROFILE="$1"
	fi
	echo "AWS_PROFILE=${AWS_PROFILE:-default}"
}
alias awsw='echo "${AWS_PROFILE:-default}"'   # 현재 프로필 확인
alias awsl='aws configure list-profiles'      # 프로필 목록
