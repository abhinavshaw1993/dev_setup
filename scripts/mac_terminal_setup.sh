#!/bin/bash

# macOS Terminal Setup Script
# Installs packages and configures terminal for zsh with autocomplete and syntax highlighting

echo "Setting up macOS terminal environment..."

# Check if Homebrew is installed, install if not
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install zsh-autosuggestions (for inline command suggestions)
echo "Installing zsh-autosuggestions..."
brew install zsh-autosuggestions

# Install zsh-syntax-highlighting (for colored command syntax)
echo "Installing zsh-syntax-highlighting..."
brew install zsh-syntax-highlighting

# Install other useful terminal tools
echo "Installing additional terminal utilities..."

# Git completion
brew install git

# fzf (fuzzy finder) for better tab completion and searching
brew install fzf
$(brew --prefix)/opt/fzf/install --all

# z.sh for quick directory navigation
brew install z

# bat (better cat)
brew install bat

# exa (better ls)
brew install exa

# htop (better top)
brew install htop

# ripgrep (better grep)
brew install ripgrep

# jq (JSON processor)
brew install jq

# tree (directory tree)
brew install tree

# thefuck (correct previous console command)
brew install thefuck

# starship (cross-shell prompt)
brew install starship

# Set up zshrc file if needed
echo "Creating/updating .zshrc configuration..."

# Backup existing zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    echo "Backed up existing .zshrc"
fi

# Create minimal zshrc with core functionality
cat > ~/.zshrc << 'EOL'
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Tab completion
autoload -Uz compinit
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
bindkey '^I' expand-or-complete

# Git-aware prompt
autoload -Uz vcs_info add-zsh-hook
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats ' [%b%u%c]'
zstyle ':vcs_info:git:*' actionformats ' [%b | %a%u%c]'

_personal_update_prompt() {
  vcs_info
  local git_info=${vcs_info_msg_0_//\%/%%}
  PROMPT='%F{cyan}%~%f%F{yellow}'"${git_info}"$'%f\n%F{green}❯%f '
}

add-zsh-hook -d precmd _personal_update_prompt
add-zsh-hook precmd _personal_update_prompt
_personal_update_prompt

# History configuration
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY HIST_IGNORE_DUPS

# Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Accept suggestions with Right Arrow
bindkey '^[[C' forward-char
bindkey '^[OC' forward-char

# Syntax highlighting (load last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases for better tools
alias ls='exa --group-directories-first'
alias ll='exa -la --group-directories-first'
alias la='exa -a --group-directories-first'
alias cat='bat'
alias grep='rg'
alias top='htop'
alias ps='procs'

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# z directory jumping
source /opt/homebrew/etc/profile.d/z.sh

# thefuck configuration
eval $(thefuck --alias)

# Starship prompt (uncomment if you want to use it)
# eval "$(starship init zsh)"

# Git identity
git config --global user.name "Abhinav Shaw"
git config --global user.email "abhinav.shaw1993@gmail.com"

# PATH additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Set default editor
export EDITOR="nano"

# Color support
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

EOL

# Apply changes
echo "Applying changes to current shell..."
source ~/.zshrc

echo ""
echo "========================================="
echo "Terminal setup complete!"
echo ""
echo "Installed packages:"
echo "✓ zsh-autosuggestions"
echo "✓ zsh-syntax-highlighting"
echo "✓ fzf (fuzzy finder)"
echo "✓ z (directory jumper)"
echo "✓ bat (better cat)"
echo "✓ exa (better ls)"
echo "✓ htop (better top)"
echo "✓ ripgrep (better grep)"
echo "✓ jq (JSON processor)"
echo "✓ tree (directory tree)"
echo "✓ thefuck (command corrector)"
echo "✓ starship (fancy prompt)"
echo ""
echo "To use the updated configuration in new terminals,"
echo "either restart your terminal or run:"
echo "  source ~/.zshrc"
echo ""
echo "Quick tips:"
echo "  • Press Tab for autocomplete"
echo "  ↑ Use arrow keys for command history"
echo "  • Use 'z' followed by directory name to jump"
echo "  • Use 'thefuck' to correct last command"
echo "========================================="