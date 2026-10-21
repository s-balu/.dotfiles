# Dotfiles

Personal macOS terminal, editor, and Git configuration. Keep the checkout at
`~/.dotfiles`. Edit the files here; application config paths are symlinks to them.

## Install or verify symlinks

Python 3 is required. From a checkout at `~/.dotfiles`:

```sh
cd "$HOME/.dotfiles"
python3 install.py --dry-run
python3 install.py
python3 install.py --check
```

The installer backs up existing destination files and directories to
`~/.local/state/dotfiles-backups/<timestamp>/` before replacing them. Correct
symlinks are left alone, so rerunning it is safe. It only installs links;
applications, dependencies, fonts, and plugins must be installed separately.

| Repository source | Runtime path |
| --- | --- |
| `dot_zshrc` | `~/.zshrc` |
| `tmux/tmux.conf` | `~/.tmux.conf`, `~/.tmux/.tmux.conf` |
| `tmux/tmux.conf.local` | `~/.tmux.conf.local`, `~/.tmux/.tmux.conf.local` |
| `alacritty/alacritty.toml` | `~/.config/alacritty.toml` |
| `nvim/` | `~/.config/nvim` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `git/gitconfig` | `~/.gitconfig` |
| `git/config/` | `~/.config/git` |
| `local/xm1/` (optional, ignored) | `~/.config/xm1` |

For an individual manual link, first back up any existing destination:

```sh
mkdir -p "$HOME/.config"
ln -s "$HOME/.dotfiles/alacritty/alacritty.toml" "$HOME/.config/alacritty.toml"
```

## Dependencies and machine-specific settings

The interactive shell uses tmux, Oh My Zsh, Starship, zoxide, eza, and fortune.
Aliases also reference Neovim, lazygit, Jupyter, personal Python environments,
and remote hosts. Review `aliases.list` before reusing it on another machine.

Oh My Zsh needs `zsh-autosuggestions`, `zsh-syntax-highlighting`, `vi-mode`, and
`zsh-interactive-cd`; the last plugin requires fzf. Alacritty uses JetBrainsMono
Nerd Font. VimTeX expects latexmk and Skim on macOS. Homebrew, Ruby, and Oh My Zsh
paths in `dot_zshrc` are machine-specific.

## Private settings in a public repository

The entire `local/` directory is ignored. Copy its files separately to a new
machine; they are intentionally absent from a fresh clone.

- `local/shell.local.zsh`: sourced by `dot_zshrc` when present. Put private
  environment variables and API keys here; use permissions `600`.
- `local/gitconfig.local`: included by `git/gitconfig`. Set your Git identity:

  ```sh
  mkdir -p "$HOME/.dotfiles/local"
  git config --file "$HOME/.dotfiles/local/gitconfig.local" user.name "Your Name"
  git config --file "$HOME/.dotfiles/local/gitconfig.local" user.email "you@example.com"
  chmod 600 "$HOME/.dotfiles/local/gitconfig.local"
  ```

- `local/xm1/`: optional Texmaker settings, including recent-document state.

Before staging changes, check what Git will include:

```sh
git check-ignore local/shell.local.zsh local/gitconfig.local
git status --short
git diff --cached --stat
```

Never force-add `local/`.

## tmux sessions and recovery

The prefix is **Ctrl-a**. The shell creates or attaches to session `0`.
`tmux/tmux.conf` is based on Oh My Tmux; customize `tmux/tmux.conf.local`.

Resurrect and Continuum are enabled. Continuum saves roughly every 15 minutes
while its status-line hook runs.

- Save now: **Ctrl-a**, then **Ctrl-s**.
- Restore after an unexpectedly empty startup: **Ctrl-a**, then **Ctrl-r**.
  Restore before saving the empty layout over the previous snapshot.
- Reload settings: `tmux source-file ~/.tmux.conf`.
- Update plugins manually: **Ctrl-a**, then **u**.

## Alacritty

Only TOML is maintained.  
The annoying flashing visual bell is disabled with `bell.duration = 0`.

## Neovim

`nvim/` contains LazyVim settings, plugin definitions, spell dictionaries, and
`lazy-lock.json`. Plugins and runtime state remain in `~/.local/share/nvim` and
`~/.local/state/nvim`.
