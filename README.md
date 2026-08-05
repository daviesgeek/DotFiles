# Dotfiles

Personal macOS configuration managed with chezmoi and Homebrew.

The source repository is `~/Code/dotfiles`. Chezmoi prompts for a `personal`
or `work` profile and keeps identity values in the local chezmoi configuration,
not in Git.

## Fresh Setup

Install chezmoi, clone this repository, review the rendered changes, and apply
them:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

mkdir -p "$HOME/Code"
git clone https://github.com/daviesgeek/DotFiles.git "$HOME/Code/dotfiles"

chezmoi init --source "$HOME/Code/dotfiles"
chezmoi diff
chezmoi apply
```

The first apply can install Homebrew and Oh My Zsh when they are missing. It
does not install the complete Brewfile unless explicitly requested.

## Homebrew

Review the package set:

```sh
brew bundle check --verbose --no-upgrade \
  --file "$HOME/Code/dotfiles/Brewfile"
```

Install or upgrade the declared formulae, casks, and Mac App Store apps:

```sh
brew bundle install --file "$HOME/Code/dotfiles/Brewfile"
```

Existing direct-download applications may need one-by-one adoption:

```sh
brew install --cask --adopt <cask>
```

Mac App Store entries require an active App Store login. YubiKey Manager is
kept as a manual installation.

## Managed Configuration

Chezmoi manages shell, Git, tmux, Vim, VS Code, Zed, OpenCode, and selected
application configuration. The macOS defaults script applies curated Finder,
Dock, keyboard, trackpad, accessibility, and application preferences when its
rendered content changes.

Useful checks:

```sh
chezmoi status
chezmoi diff
chezmoi verify
```

Update the checkout and reapply it with:

```sh
chezmoi cd
git pull
chezmoi diff
chezmoi apply
```

## Secrets And Local State

SSH keys, GPG private keys, tokens, credentials, CLI login state, caches,
databases, and generated application state are not managed. Prompt answers,
including Git and text-expansion email values, are stored in the local
`~/.config/chezmoi/chezmoi.toml` and are not committed.

Authenticate tools such as `gh`, `glab`, Docker, npm, and cloud CLIs
separately after setup.

## Troubleshooting

- If Git signing fails, import the configured private GPG key.
- If `mas` fails, sign in to the Mac App Store.
- If a cask conflicts with an existing app, use `brew install --cask --adopt`.
- If Homebrew is not found after installation, open a new login shell.
