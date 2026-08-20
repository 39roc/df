# Add `ccd` alias for Claude Code dangerous mode

## Context
Claude Code의 `--dangerously-skip-permissions` 모드를 빠르게 실행하기 위한 alias `ccd`를 추가한다.

## Changes

### `zsh/conf.d/40-aliases.zsh`
기존 alias 패턴에 맞춰 아래 추가:

```zsh
# Claude Code (dangerously skip permissions)
command -v claude &>/dev/null && alias ccd='claude --dangerously-skip-permissions'
```

## Verification
- `source ~/.zshrc` 후 `which ccd` 또는 `type ccd`로 alias 등록 확인
