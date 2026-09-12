#!/bin/bash
# Restore the saved configuration on an Apple Silicon Mac with Homebrew.
set -euo pipefail

echo "=== macOS Terminal Configuration Restore ==="

script_dir="$(dirname "${BASH_SOURCE[0]}")"
config="$script_dir/zshrc"
brew=/opt/homebrew/bin/brew

# Check if we're on macOS
if [[ "$(uname -s)" != Darwin ]]; then
    printf '%s\n' 'Error: This setup requires macOS.' >&2
    exit 1
fi

# Check if Homebrew is installed
if [[ ! -x "$brew" ]]; then
    # Check if Homebrew might be in Intel location
    intel_brew=/usr/local/bin/brew
    if [[ -x "$intel_brew" ]]; then
        echo "Detected Intel Mac Homebrew installation at /usr/local"
        brew="$intel_brew"
    else
        printf '%s\n' 'Error: Homebrew not found at /opt/homebrew or /usr/local.' >&2
        echo ''
        echo 'Install Homebrew first: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        exit 1
    fi
fi

echo "Found Homebrew at: $brew"

# Check for custom ZDOTDIR
if [[ -n "${ZDOTDIR:-}" && "$ZDOTDIR" != "$HOME" ]]; then
  printf '%s\n' 'Warning: A custom ZDOTDIR is configured. Merge the saved zshrc into that configuration manually.' >&2
  exit 1
fi

# Validate zshrc syntax
echo "Validating zshrc syntax..."
zsh -n "$config" || {
    echo "Error: Invalid syntax in zshrc file"
    exit 1
}

# Install required packages
echo "Installing required packages..."
"$brew" install zsh-autosuggestions zsh-syntax-highlighting

# Check existing .zshrc
if [[ -e "$HOME/.zshrc" || -L "$HOME/.zshrc" ]]; then
  if cmp -s "$config" "$HOME/.zshrc"; then
    printf '%s\n' 'Your .zshrc already matches the saved configuration.'
    exit 0
  fi
  
  # Check if it's a symlink or non-regular file
  if [[ -L "$HOME/.zshrc" || ! -f "$HOME/.zshrc" ]]; then
    printf '%s\n' 'Error: Your .zshrc is a symlink or non-regular file. Merge this configuration manually.' >&2
    exit 1
  fi
  
  # Create backup
  backup="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
  cp -p "$HOME/.zshrc" "$backup"
  echo "Previous configuration backed up to: $backup"
  
  echo ""
  echo "Your current .zshrc will be replaced with the saved configuration."
  echo "Any customizations in your existing .zshrc will be lost."
  read -p "Continue? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
  fi
fi

# Install configuration
echo "Installing configuration..."
cp "$config" "$HOME/.zshrc"
echo ""
echo "========================================="
echo "Configuration restore complete!"
echo ""
echo "Installed packages:"
echo "✓ zsh-autosuggestions"
echo "✓ zsh-syntax-highlighting"
echo ""
echo "Configuration features:"
echo "✓ Git-aware prompt with branch info"
echo "✓ Tab completion with selection menu"
echo "✓ Command history suggestions"
echo "✓ Syntax highlighting"
echo "✓ 10,000 entry command history"
echo ""
echo "To activate the configuration:"
echo "• Open a new Terminal window"
echo "• Or run: exec zsh"
echo ""
echo "========================================="
