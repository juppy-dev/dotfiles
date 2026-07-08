#!/usr/bin/env bash
# refresh-skills.sh — run on THIS machine to update the skills payload committed
# in this repo (bin/payload/). Captures the parts of the Claude Code setup that
# CANNOT be re-fetched from the internet: the skills source tree + local-only
# skills. Plugins and MCP servers are NOT captured here — claude-bootstrap.sh
# re-fetches those on a fresh machine.
#
# After running, back up the repo:
#   chezmoi git -- add bin/payload && chezmoi git -- commit -m '...' && chezmoi git -- push
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # .../chezmoi/bin
PAYLOAD="$HERE/payload"

echo "==> Refreshing skills payload into $PAYLOAD"
mkdir -p "$PAYLOAD"

# 1. Skills source tree (~/.agents/skills) + manifests. Every ~/.claude/skills
#    symlink points here. --delete mirrors removals; exclude .git so we never
#    embed a nested git repo in the payload.
rsync -a --delete --exclude '.DS_Store' --exclude '.git' "$HOME/.agents/skills" "$PAYLOAD/"
[ -f "$HOME/.agents/.skill-lock.json" ] && cp "$HOME/.agents/.skill-lock.json" "$PAYLOAD/"
[ -f "$HOME/.agents/AGENTS.md" ]        && cp "$HOME/.agents/AGENTS.md"        "$PAYLOAD/"

# 2. Local real-dir skills under ~/.claude/skills (not symlinks into ~/.agents),
#    detected dynamically so new local skills are picked up.
rm -rf "$PAYLOAD/claude-skills"
mkdir -p "$PAYLOAD/claude-skills"
if [ -d "$HOME/.claude/skills" ]; then
  for d in "$HOME/.claude/skills"/*/; do
    name="$(basename "$d")"
    if [ ! -L "${d%/}" ]; then            # real directory, not a symlink
      rsync -a --exclude '.DS_Store' --exclude '.git' "${d%/}" "$PAYLOAD/claude-skills/"
      echo "    + local skill: $name"
    fi
  done
fi

echo
echo "Done. Review and back up the payload:"
echo "    chezmoi git -- add bin/payload"
echo "    chezmoi git -- commit -m 'chore(migrate): refresh skills payload'"
echo "    chezmoi git -- push"
