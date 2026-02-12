# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing shell configuration and other environment setup files.

## Structure

- `zsh/.zshrc` — Minimal loader (sources `conf.d/*.zsh` in order)
- `zsh/conf.d/` — Modular zsh config files, sourced by numeric prefix:
  - `00-omz.zsh` — Oh-my-zsh core (theme, plugins, source)
  - `10-path.zsh` — PATH additions (pnpm, Tizen)
  - `20-nvm.zsh` — Node Version Manager
  - `30-completions.zsh` — Completion system (AWS, Terraform, Azure, kubectl, Helm)
  - `40-aliases.zsh` — Custom aliases (k, sdb, ds)
  - `50-prompt.zsh` — Agnoster prompt customization
  - `60-integrations.zsh` — Shell integrations (zoxide, local env)
  - `90-sdkman.zsh` — SDKMAN (must be last)

## Deployment

Dotfiles are intended to be symlinked to their target locations (e.g., `zsh/.zshrc` → `~/.zshrc`). Only the `.zshrc` file needs to be symlinked; `conf.d/` files are sourced via the `$DOTFILES` variable.

## Adding New Tool Configuration

1. Create a new `.zsh` file in `zsh/conf.d/` with an appropriate numeric prefix
2. Use 10-unit gaps (e.g., 70, 80) for ordering flexibility
3. Do NOT use prefix 90 or higher (reserved for SDKMAN which must load last)
4. No changes needed to `.zshrc` — new files are auto-sourced
