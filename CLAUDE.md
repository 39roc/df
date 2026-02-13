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
  - `75-neovim.zsh` — Neovim settings (EDITOR, aliases)
  - `90-sdkman.zsh` — SDKMAN (must be last)
- `nvim/.config/nvim/` — Neovim configuration (LazyVim distribution):
  - `init.lua` — Entry point (loads config.lazy)
  - `lua/config/lazy.lua` — lazy.nvim bootstrap and plugin spec
  - `lua/config/options.lua` — Custom Neovim options
  - `lua/config/keymaps.lua` — Custom key mappings
  - `lua/config/autocmds.lua` — Custom autocommands
  - `lua/plugins/` — Plugin specs (one file per plugin or group)
  - `lazyvim.json` — LazyVim extras tracker (auto-managed)
  - `stylua.toml` — Lua formatter config

## Deployment

Dotfiles are deployed using [GNU Stow](https://www.gnu.org/software/stow/) and symlinks:
- `zsh/.zshrc` → `~/.zshrc` (manual symlink; `conf.d/` files are sourced via `$DOTFILES`)
- `nvim/` → Stow package: `cd ~/df && stow nvim` creates `~/.config/nvim` symlink

## Adding New Tool Configuration

1. Create a new `.zsh` file in `zsh/conf.d/` with an appropriate numeric prefix
2. Use 10-unit gaps (e.g., 70, 80) for ordering flexibility
3. Do NOT use prefix 90 or higher (reserved for SDKMAN which must load last)
4. No changes needed to `.zshrc` — new files are auto-sourced

## Neovim / LazyVim

- Configuration uses the [LazyVim](https://www.lazyvim.org/) distribution
- Plugin data is stored in `~/.local/share/nvim/lazy/` (NOT in the dotfiles repo)
- To add a plugin: create a new `.lua` file in `nvim/.config/nvim/lua/plugins/`
- To enable a LazyVim extra: use `:LazyExtras` inside Neovim (updates `lazyvim.json`)
- `lazyvim.json` should be committed — it tracks which extras are enabled
