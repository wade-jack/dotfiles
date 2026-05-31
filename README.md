# Dotfiles

Personal macOS development setup managed with [chezmoi](https://www.chezmoi.io/).

## New Machine Setup

### Prerequisites

Before running the chezmoi setup commands on a new machine:

1. Install Xcode Command Line Tools:

```sh
xcode-select --install
```

2. Install Homebrew from <https://brew.sh>.

3. Set up GitHub authentication.

Either use GitHub CLI and choose SSH when prompted:

```sh
brew install gh
gh auth login
```

Or create an SSH key and add it to GitHub:

```sh
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub
```

Add the public key to GitHub under **Settings > SSH and GPG keys**.

4. Confirm GitHub SSH works:

```sh
ssh -T git@github.com
```

5. Optional, set basic Git identity before chezmoi applies this repo:

```sh
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### Apply Dotfiles

After prerequisites:

```sh
brew install chezmoi
chezmoi init --apply git@github.com:<github-username>/dotfiles.git
brew bundle --file ~/.config/Brewfile
```

This repo keeps personal Git identity out of the public dotfiles. After applying, set identity in the local-only include file:

```sh
git config --file ~/.gitconfig.local user.name "Your Name"
git config --file ~/.gitconfig.local user.email "you@example.com"
```

Restart the shell:

```sh
exec fish
```

## Daily Usage

Check what differs between this machine and the repo:

```sh
chezmoi diff
chezmoi status
```

Edit a managed file through chezmoi:

```sh
chezmoi edit ~/.config/fish/config.fish
chezmoi apply
```

Record changes made directly in `$HOME`:

```sh
chezmoi add ~/.config/fish/config.fish
```

Commit and push changes:

```sh
chezmoi cd
git status
git add .
git commit -m "Update dotfiles"
git push
```

Pull updates on another machine:

```sh
chezmoi update
```

## Command Cheat Sheet

- `chezmoi edit <file>` changes the repo source.
- `chezmoi apply` applies the repo source to `$HOME`.
- `chezmoi add <file>` captures a `$HOME` file change back into the repo.
- `chezmoi diff` previews changes before applying or committing.
- `chezmoi update` pulls repo updates and applies them.
- `chezmoi cd` opens a shell in the source repo.

## Safety Rules

Do not add secrets, tokens, SSH private keys, shell history, caches, generated files, or machine-local app state.

Keep personal Git identity in `~/.gitconfig.local`; it is intentionally not managed by chezmoi.

Before committing, always run:

```sh
chezmoi diff
git status
```

## Managed Areas

- Fish shell config
- Git config
- Neovim config
- Starship prompt
- Yazi config
- Homebrew packages via `~/.config/Brewfile`

## Ignored On Purpose

- Fish universal variables
- Shell history
- SSH keys
- GitHub auth hosts
- local Git identity
- caches
- backup files
- generated dependencies
