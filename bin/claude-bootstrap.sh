#!/usr/bin/env bash
# claude-bootstrap.sh — run on a FRESH machine AFTER
#   chezmoi init --apply juppy-dev/dotfiles
# has restored your config files.
#
# Restores the parts chezmoi can't manage as files: plugins (fetched fresh from
# the internet), the codegraph MCP, and the skills tree (from this repo's
# bin/payload). CLAUDE.md, settings.json and statusline-command.sh are already
# restored by chezmoi — this script does NOT touch them.
#
# Prereqs: `claude` (Claude Code) and `git` on PATH, logged into the same Claude
# account (so claude.ai connectors — Gmail, Notion, Drive, Figma... — come back
# on their own; they are account-level OAuth and cannot be scripted).
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # .../chezmoi/bin
PAYLOAD="$HERE/payload"
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }
step() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }

command -v claude >/dev/null || { echo "ERROR: 'claude' not found on PATH. Install Claude Code first."; exit 1; }
[ -d "$PAYLOAD/skills" ] || { echo "ERROR: skills payload not found at $PAYLOAD/skills — run 'chezmoi apply' first."; exit 1; }

# ---------------------------------------------------------------------------
# 1. Marketplaces + plugins (fetched fresh from the internet)
# ---------------------------------------------------------------------------
step "Plugins"
MARKETPLACES=(
  "obra/superpowers"                   # registers as: superpowers-dev
  "anthropics/claude-plugins-official" # registers as: claude-plugins-official
)
PLUGINS=(
  "superpowers@superpowers-dev"
  "swift-lsp@claude-plugins-official"
  "code-review@claude-plugins-official"
  "frontend-design@claude-plugins-official"
  "playwright@claude-plugins-official"
  "security-guidance@claude-plugins-official"
  "linear@claude-plugins-official"
  "shopify-ai-toolkit@claude-plugins-official"
  "stripe@claude-plugins-official"
)
for m in "${MARKETPLACES[@]}"; do
  if claude plugin marketplace add "$m" --scope user >/dev/null 2>&1; then ok "marketplace $m"
  else warn "marketplace $m (already added or failed)"; fi
done
for p in "${PLUGINS[@]}"; do
  if claude plugin install "$p" --scope user >/dev/null 2>&1; then ok "plugin $p"
  else warn "plugin $p (already installed or failed — check 'claude plugin list')"; fi
done

# ---------------------------------------------------------------------------
# 2. Global MCP server: codegraph (stdio). Needs the `codegraph` binary.
# ---------------------------------------------------------------------------
step "MCP servers"
if command -v codegraph >/dev/null; then
  if claude mcp add-json codegraph '{"type":"stdio","command":"codegraph","args":["serve","--mcp"]}' -s user >/dev/null 2>&1; then
    ok "codegraph MCP added (user scope)"
  else warn "codegraph MCP (already configured?)"; fi
else
  warn "codegraph binary not found — install it (e.g. 'brew install codegraph'), then run:"
  printf "      claude mcp add-json codegraph '{\"type\":\"stdio\",\"command\":\"codegraph\",\"args\":[\"serve\",\"--mcp\"]}' -s user\n"
fi
warn "Plugin MCPs (linear, playwright, stripe) ship with their plugins above — re-auth on first use."
warn "claude.ai connectors (Gmail, Notion, Drive, Calendar, Canva, Figma...) return automatically once you log in."
warn "Project-scoped MCPs (figma, shopify-dev-mcp) were intentionally skipped — re-add per project."

# ---------------------------------------------------------------------------
# 3. Skills — restore the source tree and recreate ~/.claude/skills symlinks
# ---------------------------------------------------------------------------
step "Skills"
mkdir -p "$HOME/.agents" "$HOME/.claude/skills"

# 3a. source tree + manifest
rsync -a "$PAYLOAD/skills" "$HOME/.agents/"
[ -f "$PAYLOAD/.skill-lock.json" ] && cp "$PAYLOAD/.skill-lock.json" "$HOME/.agents/"
[ -f "$PAYLOAD/AGENTS.md" ]        && cp "$PAYLOAD/AGENTS.md"        "$HOME/.agents/"
ok "restored ~/.agents/skills"

# 3b. one symlink per source skill: ~/.claude/skills/<name> -> ../../.agents/skills/<name>
count=0
for d in "$HOME/.agents/skills"/*/; do
  name="$(basename "$d")"
  ln -sfn "../../.agents/skills/$name" "$HOME/.claude/skills/$name"
  count=$((count+1))
done
ok "linked $count skills into ~/.claude/skills"

# 3c. real (local-only) skills copied as actual dirs
if [ -d "$PAYLOAD/claude-skills" ]; then
  for d in "$PAYLOAD/claude-skills"/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    rm -rf "$HOME/.claude/skills/$name"
    rsync -a "$d" "$HOME/.claude/skills/$name/"
    ok "local skill $name"
  done
fi

step "Done — restart Claude Code, then verify with:  claude plugin list  /  ls ~/.claude/skills"
