# Dev Setup

A collection of scripts and gists required for different personal dev setups.

## Structure

- `scripts/` - Setup scripts for different environments
- `gists/` - Code snippets and configurations

## Scripts

- `scripts/mac_terminal_setup.sh` - Comprehensive macOS terminal setup including Homebrew installation, zsh autocomplete, syntax highlighting, and many useful tools

## Gists

- `gists/mac-terminal/` - Minimal macOS terminal configuration restore
  - `setup.sh` - Restore-only script for when Homebrew is already installed
  - `zshrc` - Minimal zsh configuration file
  - `README.md` - Documentation

## Usage

### Comprehensive Setup (Recommended for new machines)
For a complete terminal setup including Homebrew and many tools:
```bash
./scripts/mac_terminal_setup.sh
```

### Minimal Restore (When you already have Homebrew)
To restore just the zsh configuration without installing additional tools:
```bash
./gists/mac-terminal/setup.sh
```

The comprehensive script installs:
- Homebrew (if not present)
- zsh-autosuggestions & zsh-syntax-highlighting
- Additional tools: fzf, z, bat, exa, htop, ripgrep, jq, tree, thefuck, starship
- Full-featured `.zshrc` with aliases and configuration

The gist version is for restoring configuration only, assuming Homebrew is already installed.