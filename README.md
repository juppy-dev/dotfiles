# dotfiles

Personal config files, managed with [chezmoi](https://www.chezmoi.io/) and backed up to `juppy-dev/dotfiles`.

Source of truth lives in `~/.local/share/chezmoi`; each `dot_`/`private_` prefix maps to a real file under `$HOME`.

## Restore on a new machine

```sh
chezmoi init --apply juppy-dev/dotfiles
```

Preview what would change first with `chezmoi diff`.

## What's tracked

Paths below are relative to `$HOME`.

### Shell (Zsh)

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.zshrc` | Zsh + Oh My Zsh | Interactive shell config. Plugins: `git`, `zsh-syntax-highlighting`, `zsh-autosuggestions`, `you-should-use`, `zsh-bat`. Includes the `claude()` wrapper that switches to the Nplus config inside `~/Nplus`. |
| `.zprofile` | Zsh | Login-shell startup (PATH, environment). |
| `.zshenv` | Zsh | Environment applied to every Zsh invocation. |
| `.oh-my-zsh/custom/aliases.zsh` | Oh My Zsh | Custom aliases (incl. `claude-nplus`). |

### Prompt & theming

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.p10k.zsh` | Powerlevel10k | Zsh prompt theme configuration. |
| `.config/oh-my-posh/tokyo-nebula.omp.json` | Oh My Posh | Prompt theme (`tokyo-nebula`). |

### Terminal & multiplexer

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.tmux.conf` | tmux | Terminal multiplexer config. |
| `Library/Application Support/com.mitchellh.ghostty/config.ghostty` | Ghostty | Terminal emulator config. |

### Editors

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.config/nvim/` | Neovim | lazy.nvim setup — `init.lua`, `lua/config/lazy.lua`, `lua/plugins/`. |
| `.config/zed/` | Zed | `settings.json`, `keymap.json`, `themes/`. |
| `Library/Application Support/Code/User/settings.json` | VS Code | User settings. |

### Git & SSH

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.gitconfig` | Git | Global git config. |
| `.config/git/ignore` | Git | Global gitignore. |
| `.ssh/config` | OpenSSH | Client host aliases / options (**keys are never tracked**). |

### CLI tools

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.config/btop/btop.conf` | btop | Resource monitor config. |
| `.config/lazygit/config.yml` | lazygit | Git TUI config. |
| `.config/xplr/init.lua` | xplr | TUI file explorer config (external plugins excluded — see below). |

### Claude Code

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.claude/CLAUDE.md` | Claude Code | Global instructions. |
| `.claude/settings.json` | Claude Code | Settings (permissions, env). |
| `.config/ccstatusline/settings.json` | ccstatusline | Claude Code status-line generator. |
| `.config/claude-status/config.json` | claude-status | Claude Code status-line utility. |

### Packages

| Path | App / Tool | Contents |
|------|-----------|----------|
| `.config/Brewfile` | Homebrew | `brew bundle` manifest — 32 formulae, 6 casks, 2 taps, 3 VS Code extensions. |

## Intentionally **not** tracked

Configured in `.chezmoiignore`:

- `.config/xplr/plugins` — vendored external plugin checkouts (re-installed, not backed up).
- `.config/zed/prompts` — binary LMDB database (state, not config).
- `**/.git` — embedded git repositories.

Also deliberately excluded because they hold **live credentials** — keep them out of the repo (use `chezmoi` age encryption if they ever need backing up):

- `.config/stripe` — Stripe CLI (API keys).
- `.config/gh` — GitHub CLI (tokens; also stored in the macOS keyring).

## Updating the backup

```sh
chezmoi re-add        # pull current live files into the source (live -> source)
chezmoi cd            # jump to the source repo
git add <paths>       # stage intended files (avoid `git add -A`)
git commit -m "..."   # conventional, single-author
git push
```

> Direction matters: `add`/`re-add` capture live files **into** the repo (backup); `apply` writes the repo **onto** the machine (restore). To back up, never run `apply` — it would overwrite live files with the repo's version.
