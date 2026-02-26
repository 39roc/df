#!/bin/bash
# Agnoster-inspired statusLine for Claude Code
# Read JSON input from stdin
input=$(cat)

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
SESSION_NAME=$(echo "$input" | jq -r '.session_name // empty')
CONTEXT_REMAINING=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Build status line segments
segments=""

# User segment (like Agnoster's prompt_context)
USER_SEG="$(whoami)"
if [ -n "$SSH_CLIENT" ]; then
  USER_SEG="${USER_SEG}@$(hostname -s)"
fi

# Directory segment (show basename like \W)
DIR_NAME="${CURRENT_DIR##*/}"
[ -z "$DIR_NAME" ] && DIR_NAME="/"

# Git segment (skip optional locks for performance)
GIT_SEG=""
if git -c core.useBuiltinFSMonitor=false rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=$(git -c core.useBuiltinFSMonitor=false branch --show-current 2>/dev/null)
  if [ -n "$BRANCH" ]; then
    # Check for dirty working directory
    if ! git -c core.useBuiltinFSMonitor=false diff --quiet 2>/dev/null || \
       ! git -c core.useBuiltinFSMonitor=false diff --cached --quiet 2>/dev/null; then
      GIT_SEG=" ± $BRANCH"
    else
      GIT_SEG=" ⎇ $BRANCH"
    fi
  fi
fi

# Context window segment (if available)
CONTEXT_SEG=""
if [ -n "$CONTEXT_REMAINING" ]; then
  CONTEXT_SEG=" [ctx:${CONTEXT_REMAINING}%]"
fi

# Build final output: user  dir [git] [model] [context]
printf "%s  %s%s [%s]%s" "$USER_SEG" "$DIR_NAME" "$GIT_SEG" "$MODEL_DISPLAY" "$CONTEXT_SEG"
