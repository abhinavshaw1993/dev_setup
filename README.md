# Dev Setup

A collection of repeatable recipes for different personal dev setups.

## Structure

- `recipes/` - Repeatable configuration recipes for different environments

## Recipes

- `recipes/mac-terminal/` - macOS terminal configuration
  - `setup.sh` - Setup recipe for when Homebrew is already installed
  - `zshrc` - Minimal zsh configuration file
  - `README.md` - Documentation

## Usage

For macOS terminal setup (requires Homebrew already installed):
```bash
./recipes/mac-terminal/setup.sh
```

This setup installs:
- zsh-autosuggestions & zsh-syntax-highlighting plugins
- Git-aware prompt with branch information
- Tab completion with selection menu
- Command history suggestions
- Syntax highlighting
- 10,000 entry command history