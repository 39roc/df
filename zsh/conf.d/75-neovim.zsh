# Neovim 설정

# nvim이 설치되어 있지 않으면 종료
command -v nvim &>/dev/null || return 0

# 기본 에디터 설정
export EDITOR="nvim"
export VISUAL="nvim"

# vim → nvim 별칭
alias vim="nvim"
alias vi="nvim"

# 빠른 설정 접근
alias nvimconf="nvim $DOTFILES/nvim/.config/nvim/init.lua"
