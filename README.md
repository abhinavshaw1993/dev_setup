# Dev Setup

A collection of scripts and gists required for different personal dev setups.

## Structure

- `gists/` - Code snippets and configurations for different environments

## Gists

- `gists/mac-terminal/` - macOS terminal configuration
  - `setup.sh` - Setup script for when Homebrew is already installed
  - `zshrc` - Minimal zsh configuration file
  - `README.md` - Documentation

## Usage

For macOS terminal setup (requires Homebrew already installed):
```bash
./gists/mac-terminal/setup.sh
```

This setup installs:
- zsh-autosuggestions & zsh-syntax-highlighting plugins
- Git-aware prompt with branch information
- Tab completion with selection menu
- Command history suggestions
- Syntax highlighting
- 10,000 entry command history