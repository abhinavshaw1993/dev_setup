# macOS Terminal setup

This saves the Zsh configuration used with Apple's built-in Terminal app.
No replacement terminal app or shell framework is required.

## Difference from Comprehensive Script
This gist provides a **minimal restore-only** setup, while the comprehensive script (`scripts/mac_terminal_setup.sh`) provides a **complete installation** including Homebrew and many additional tools.

**Use this gist when:** You already have Homebrew installed and just want to restore/apply the zsh configuration.

**Use the comprehensive script when:** You're setting up a new machine or want to install Homebrew along with many additional terminal utilities.

## Included

- Two-line prompt: cyan working directory and green command marker.
- Yellow Git branch, with `*` for unstaged tracked changes and `+` for staged
  changes; merge/rebase status is shown when available. Untracked files do not
  affect these markers.
- Zsh Tab completion for Git commands, branches, and paths, with a selection menu.
- `zsh-autosuggestions`: gray suggestions from history, then completion.
- `zsh-syntax-highlighting`: command coloring to help spot typos.
- Up to 10,000 saved history entries, ignoring consecutive duplicate commands.
- The existing `$HOME/.local/bin` PATH entry.

The saved `zshrc` is a snapshot of the configuration on this Mac. The plugin paths
target the standard Apple Silicon Homebrew installation at `/opt/homebrew`.

## One-time setup / restore

### Minimal Setup (Restore only)
Prerequisites: macOS, Zsh, and [Homebrew](https://brew.sh/) at `/opt/homebrew`.
Review `zshrc` and `setup.sh`, then run from any directory:

```bash
bash ~/projects/dev_setup/gists/mac-terminal/setup.sh
```

The script installs the two plugins, backs up an existing regular `~/.zshrc` to a
unique `~/.zshrc.backup.*` file, and copies the saved configuration into place.
It **replaces**, rather than merges, your configuration. Incorporate any custom
aliases or other settings into the saved file before restoring it. An identical
configuration is left in place. Custom ZDOTDIR setups and differing symlinked
configurations require a manual merge.

### Comprehensive Setup (Install + Configure)
For a complete terminal setup including Homebrew installation and many additional
tools, use the comprehensive script:

```bash
bash ~/projects/dev_setup/scripts/mac_terminal_setup.sh
```

This script will:
1. Install Homebrew if not present
2. Install numerous terminal utilities and tools
3. Create a full-featured `.zshrc` with aliases, prompt configuration, and plugins
4. Set up Git configuration

On an Intel Mac, adjust the plugin paths and the setup script's Homebrew path to
match your installation before using these files.

## Everyday use

New Terminal windows and tabs automatically read `~/.zshrc`. There is no setup
command to run each time. After editing the configuration, open a new window or
run `exec zsh` in an idle shell to load it in the current window.

- Type a previous command prefix to see an inline suggestion.
- Press **Right Arrow** at the end of the line to accept it.
- Use **Tab** for completion; with multiple choices, press Tab again to enter the
  menu and use arrow keys and Enter to select.
- Run `git switch ` followed by Tab inside a repository to complete branch names.

Example prompt:

```text
~/projects/my-repository [feature-branch*+]
❯
```

## Maintenance

Changes to this snapshot do not automatically change your active `~/.zshrc`.
Keep the two in sync deliberately, reviewing any local additions before copying.
The setup script has not been run as part of saving this gist; the current Mac
already has the plugins and active configuration installed.

Terminal color profiles and font choices are managed separately under
**Terminal → Settings → Profiles**. No appearance profile was changed during this
setup. Git verbosity settings suggested in conversation were not applied and are
not part of this configuration.
