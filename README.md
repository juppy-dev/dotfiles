# dotfiles

Personal config files, managed with [chezmoi](https://www.chezmoi.io/) and backed up to `juppy-dev/dotfiles`.

Source of truth lives in `~/.local/share/chezmoi`; each `dot_`/`private_` prefix maps to a real file under `$HOME`.

## Restore on a new machine

Two steps — chezmoi restores the **config files**, then a script restores the
**Claude Code setup** (plugins, MCP servers, skills) that can't live as plain files.

```sh
# 1. config files (shell, editors, git, ssh, Claude configs, statusline, ...)
chezmoi init --apply juppy-dev/dotfiles

# 2. Claude Code: plugins + codegraph MCP + skills tree
~/.local/share/chezmoi/bin/claude-bootstrap.sh
```

Preview step 1 before applying with `chezmoi diff`. Prereqs for step 2: `claude`
and `git` on PATH, logged into the same Claude account (claude.ai connectors
return on their own).

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
| `.claude/settings.json` | Claude Code | Settings (permissions, env, theme, statusLine). |
| `.claude/statusline-command.sh` | Claude Code | Active status-line script (referenced by `settings.json` → `statusLine`). |
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

## Claude Code migration tooling (`bin/`)

chezmoi versions config *files*, but plugins, MCP servers, and the skills tree
aren't files it can manage. Those live under `bin/` (chezmoi-ignored, so it's
never applied to `~/bin`):

| Path | Purpose |
|------|---------|
| `bin/claude-bootstrap.sh` | Fresh-machine restore: installs plugins + marketplaces, adds the codegraph MCP, and rebuilds the skills tree from `bin/payload/`. Run **after** `chezmoi apply`. Does **not** touch `CLAUDE.md`/`settings.json`/statusline — chezmoi owns those. |
| `bin/refresh-skills.sh` | Run on this machine to re-capture the skills payload (46/78 skills have no public source, so they must be carried). Rsyncs `~/.agents/skills` + local `~/.claude/skills` dirs into `bin/payload/`, then you commit. |
| `bin/payload/` | The carried skills: `skills/` (source tree), `claude-skills/` (local-only skills), `.skill-lock.json`, `AGENTS.md`. |

To keep the skills payload current after adding/editing skills:

```sh
~/.local/share/chezmoi/bin/refresh-skills.sh
chezmoi git -- add bin/payload
chezmoi git -- commit -m "chore(migrate): refresh skills payload"
chezmoi git -- push
```

## Updating the backup

```sh
chezmoi re-add        # pull current live files into the source (live -> source)
chezmoi cd            # jump to the source repo
git add <paths>       # stage intended files (avoid `git add -A`)
git commit -m "..."   # conventional, single-author
git push
```

> Direction matters: `add`/`re-add` capture live files **into** the repo (backup); `apply` writes the repo **onto** the machine (restore). To back up, never run `apply` — it would overwrite live files with the repo's version.
