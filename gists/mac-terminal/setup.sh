#!/bin/bash
# Restore the saved configuration on an Apple Silicon Mac with Homebrew.
set -euo pipefail

script_dir="$(dirname "${BASH_SOURCE[0]}")"
config="$script_dir/zshrc"
brew=/opt/homebrew/bin/brew

if [[ "$(uname -s)" != Darwin || ! -x "$brew" ]]; then
  printf '%s\n' 'This setup requires macOS with Homebrew installed at /opt/homebrew.' >&2
  exit 1
fi

if [[ -n "${ZDOTDIR:-}" && "$ZDOTDIR" != "$HOME" ]]; then
  printf '%s\n' 'A custom ZDOTDIR is configured. Merge the saved zshrc into that configuration manually.' >&2
  exit 1
fi

zsh -n "$config"
"$brew" install zsh-autosuggestions zsh-syntax-highlighting

if [[ -e "$HOME/.zshrc" || -L "$HOME/.zshrc" ]]; then
  if cmp -s "$config" "$HOME/.zshrc"; then
    printf '%s\n' 'Your .zshrc already matches the saved configuration.'
    exit 0
  fi
  if [[ -L "$HOME/.zshrc" || ! -f "$HOME/.zshrc" ]]; then
    printf '%s\n' 'Your .zshrc is a symlink or non-regular file. Merge this configuration manually.' >&2
    exit 1
  fi
  backup="$(mktemp "$HOME/.zshrc.backup.XXXXXX")"
  cp -p "$HOME/.zshrc" "$backup"
  printf 'Previous configuration saved to %s\n' "$backup"
fi

cp "$config" "$HOME/.zshrc"
printf '%s\n' 'Installed. Open a new Terminal window to activate the configuration.'
