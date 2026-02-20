# fzf - 퍼지 파인더 설정
# 참고: 최적의 경험을 위해 아래 도구 설치를 권장합니다.
#   brew install bat fd eza

# fzf가 설치되어 있지 않으면 종료
command -v fzf &>/dev/null || return 0

# ---------------------------------------------------------------------------
# 프리뷰 도구 테마 (Monokai Classic 터미널용)
# ---------------------------------------------------------------------------
export BAT_THEME="Monokai Extended"

# ---------------------------------------------------------------------------
# 프리뷰 명령어 헬퍼
# ---------------------------------------------------------------------------
# bat이 있으면 구문 하이라이팅 프리뷰, 없으면 cat -n 사용
if command -v bat &>/dev/null; then
	_fzf_preview_file="bat --color=always --style=numbers --line-range=:500 {}"
else
	_fzf_preview_file="cat -n {}"
fi

# 디렉토리 프리뷰: eza > tree > ls 순서로 사용
if command -v eza &>/dev/null; then
	_fzf_preview_dir="eza --tree --level=2 --color=always --icons {}"
elif command -v tree &>/dev/null; then
	_fzf_preview_dir="tree -C -L 2 {}"
else
	_fzf_preview_dir="ls -la --color=always {}"
fi

# 파일/디렉토리 자동 판별 프리뷰
_fzf_preview_file_or_dir="[[ -d {} ]] && ${_fzf_preview_dir} || ${_fzf_preview_file}"

# ---------------------------------------------------------------------------
# 기본 검색 명령어 (fd가 있으면 .gitignore 및 숨김 파일 지원)
# ---------------------------------------------------------------------------
if command -v fd &>/dev/null; then
	export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
	export FZF_CTRL_T_COMMAND="fd --type f --type d --hidden --follow --exclude .git"
	export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# ---------------------------------------------------------------------------
# FZF_DEFAULT_OPTS - 전역 기본 옵션
# ---------------------------------------------------------------------------
export FZF_DEFAULT_OPTS=" \
  --height=60% \
  --min-height=20 \
  --layout=reverse \
  --border=rounded \
  --info=inline-right \
  --prompt='  ' \
  --pointer='▶' \
  --marker='✓' \
  --separator='─' \
  --scrollbar='│' \
  --preview-window='right:50%:border-left' \
  --preview '${_fzf_preview_file_or_dir}' \
  --bind='ctrl-/:toggle-preview' \
  --bind='ctrl-u:preview-half-page-up' \
  --bind='ctrl-d:preview-half-page-down' \
  --bind='ctrl-y:execute-silent(echo -n {+} | pbcopy)+abort' \
  --color='fg:#f8f8f2,bg:-1,hl:#f92672' \
  --color='fg+:#f8f8f2,bg+:#49483e,hl+:#f92672' \
  --color='info:#a6e22e,prompt:#66d9ef,pointer:#ae81ff' \
  --color='marker:#a6e22e,spinner:#ae81ff,header:#66d9ef' \
  --color='border:#75715e' \
"

# ---------------------------------------------------------------------------
# Ctrl+T - 파일 검색 (프리뷰 포함)
# ---------------------------------------------------------------------------
export FZF_CTRL_T_OPTS=" \
  --preview '${_fzf_preview_file_or_dir}' \
  --preview-window='right:50%:border-left:wrap' \
  --header='파일/디렉토리 검색 | Ctrl-/ 프리뷰 토글' \
"

# ---------------------------------------------------------------------------
# Alt+C - 디렉토리 이동 (트리 프리뷰)
# ---------------------------------------------------------------------------
export FZF_ALT_C_OPTS=" \
  --preview '${_fzf_preview_dir}' \
  --preview-window='right:50%:border-left' \
  --header='디렉토리 이동 | Ctrl-/ 프리뷰 토글' \
"

# ---------------------------------------------------------------------------
# Ctrl+R - 히스토리 검색 (프리뷰 비활성화)
# ---------------------------------------------------------------------------
export FZF_CTRL_R_OPTS=" \
  --preview-window='hidden' \
  --header='명령어 히스토리 | Ctrl-/ 프리뷰 토글 | Ctrl-Y 클립보드 복사' \
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
  --color='header:italic' \
"

# ---------------------------------------------------------------------------
# 키 바인딩 및 자동완성 로드
# ---------------------------------------------------------------------------
eval "$(fzf --zsh)"

# ---------------------------------------------------------------------------
# 헬퍼 변수 정리
# ---------------------------------------------------------------------------
unset _fzf_preview_file _fzf_preview_dir _fzf_preview_file_or_dir

# ---------------------------------------------------------------------------
# fe - fzf로 파일 검색 후 에디터로 열기 (Tab으로 멀티 선택 가능)
# ---------------------------------------------------------------------------
fe() {
	local files
	files=$(fzf --multi --header='파일 검색 → Enter로 에디터 열기 | Tab 멀티선택') && ${EDITOR:-vim} "${(@f)files}"
}
