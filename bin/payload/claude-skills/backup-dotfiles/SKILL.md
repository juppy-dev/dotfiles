---
name: backup-dotfiles
description: Back up local config files to the chezmoi dotfiles repo (juppy-dev/dotfiles). Use when the user says "/backup-dotfiles", "back up my dotfiles", "back up my configs", "sync my dotfiles", "commit my config changes", or after editing shell/editor/CLI/Claude configs they want versioned.
---

# Backup dotfiles

Capture the current state of the machine's tracked config files into the chezmoi
source repo and push it to the backup remote. Configs are managed with
[chezmoi](https://www.chezmoi.io/); the source repo is `~/.local/share/chezmoi`,
remote `git@github.com:juppy-dev/dotfiles.git`.

## Direction — READ FIRST

- `chezmoi add` / `chezmoi re-add` pull **live → source** (this is a backup).
- `chezmoi apply` pushes **source → live** (this is a *restore*).

**When backing up, NEVER run `chezmoi apply`** — it would overwrite live files
with whatever the repo holds and destroy un-captured local changes.

Prefer native chezmoi commands throughout, including `chezmoi git -- …` for VCS
so everything runs against the source repo without a manual `cd`.

## Procedure

Run these in order. Stop and surface the problem if any step looks wrong.

1. **Preview drift** — what has changed on this machine since the last backup:
   ```sh
   chezmoi diff
   ```
   `chezmoi diff` shows the `apply` direction (source → live), so lines it would
   *remove* are content your live files have that the repo doesn't — i.e. exactly
   what this backup will capture. If empty, there's nothing to back up; say so and stop.

2. **Capture live → source:**
   ```sh
   chezmoi re-add
   ```
   This refreshes every already-managed file from its live version. To also start
   tracking a *new* file the user names, use `chezmoi add ~/path` (not re-add).

3. **Secrets scan (hard gate)** — scan the just-changed source before anything is
   committed. List changed source files and grep them:
   ```sh
   chezmoi git -- status --porcelain
   grep -rInE 'sk_live|sk_test|rk_(live|test)|pk_live|whsec_|ghp_[A-Za-z0-9]|github_pat_|gho_|xox[baprs]-|AKIA[0-9A-Z]{16}|-----BEGIN[A-Z ]+PRIVATE KEY-----|(api[_-]?key|secret|token|passwd|password|client[_-]?secret)\s*[:=]\s*["'"'"'][^"'"'"' ]{8,}' \
     ~/.local/share/chezmoi --exclude-dir=.git
   ```
   If anything matches, **STOP** — do not commit. Show the user the hit and ask how
   to handle it (exclude the file via `.chezmoiignore`, or encrypt with chezmoi's
   age support). Credential-bearing configs (`~/.config/stripe`, `~/.config/gh`)
   are deliberately untracked — keep them out.

4. **Review what will be committed:**
   ```sh
   chezmoi git -- status
   ```
   Source files use `dot_` / `private_` prefixes (e.g. `~/.tmux.conf` → `dot_tmux.conf`).
   Stage those source paths, not the live names.

5. **Commit + push:**
   ```sh
   chezmoi git -- add <specific source paths>     # NEVER `git add -A` / `git add .`
   chezmoi git -- commit -m "<conventional message>"
   chezmoi git -- push
   ```
   Commit rules (per the user's global git conventions):
   - **Conventional**: `type(scope): subject` — e.g. `chore(dotfiles): sync …`, `feat(dotfiles): track …`.
   - **Atomic**: one logical change per commit; split unrelated changes.
   - **Single author**: never add a `Co-Authored-By` or any attribution trailer.
   - Stage only intended paths; leave anything unrelated unstaged.

## Out of scope

This skill backs up **config files only**. The Claude setup payload (skills tree,
plugin list) lives in the same repo but is refreshed separately by
`~/.local/share/chezmoi/bin/refresh-skills.sh` — do not run it from here unless
the user explicitly asks to refresh skills too.

## Reference

- What's tracked / excluded and the full restore flow: `~/.local/share/chezmoi/README.md`.
- Restore on a new machine: `chezmoi init --apply juppy-dev/dotfiles`, then
  `~/.local/share/chezmoi/bin/claude-bootstrap.sh` for plugins/MCPs/skills.
