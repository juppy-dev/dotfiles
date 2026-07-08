#!/usr/bin/env bash
# Tokyo Nebula status line — mirrors the oh-my-posh prompt palette
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd="${cwd/#$home/~}"

# Colors matching tokyo-nebula palette (truecolor)
lilac='\033[38;2;196;168;255m'   # #c4a8ff  username
cyan='\033[38;2;0;212;255m'      # #00d4ff  path
green='\033[38;2;124;227;139m'   # #7ce38b  git clean
yellow='\033[38;2;255;216;102m'  # #ffd866  git dirty
gold='\033[38;2;224;175;104m'    # #e0af68  git stashed / runtime versions
purple='\033[38;2;167;139;250m'  # #a78bfa  git branch brackets
pink='\033[38;2;255;97;136m'     # #ff6188  context warn
reset='\033[0m'

# Nerd Font glyphs (defined as UTF-8 byte sequences so they survive edits
# and render under bash 3.2). Mirrors tokyo-nebula.omp.json icons.
icon_os=$(printf '\xef\x85\xb9')     #  U+F179 apple (macos override)
icon_dir=$(printf '\xef\x81\xbb')    #  U+F07B folder (path segment)
icon_git=$(printf '\xee\x82\xa0')    #  U+E0A0 branch (git default)
icon_model=$(printf '\xef\x8b\x9b')  #  U+F2DB microchip (model)

parts=()

# macOS icon + username (lilac)
parts+=("$(printf "${lilac}${icon_os} $(whoami)${reset}")")

# folder icon + path (cyan)
parts+=("$(printf "${cyan}${icon_dir} ${short_cwd}${reset}")")

# Git info (skip optional locks)
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.fsmonitor=false symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" -c core.fsmonitor=false rev-parse --short HEAD 2>/dev/null)

  # Detect dirty / stashed state
  git_color="$green"
  ahead=$(git -C "$cwd" -c core.fsmonitor=false rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
  behind=$(git -C "$cwd" -c core.fsmonitor=false rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
  staged=$(git -C "$cwd" -c core.fsmonitor=false diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  unstaged=$(git -C "$cwd" -c core.fsmonitor=false diff --name-only 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git -C "$cwd" -c core.fsmonitor=false ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
  stashes=$(git -C "$cwd" -c core.fsmonitor=false stash list 2>/dev/null | wc -l | tr -d ' ')

  if [ "$staged" -gt 0 ] || [ "$unstaged" -gt 0 ] || [ "$untracked" -gt 0 ]; then
    git_color="$yellow"
  elif [ "$stashes" -gt 0 ]; then
    git_color="$gold"
  fi

  suffix=""
  [ "$ahead" -gt 0 ]    && suffix="${suffix}↑${ahead} "
  [ "$behind" -gt 0 ]   && suffix="${suffix}↓${behind} "
  [ "$staged" -gt 0 ]   && suffix="${suffix}+${staged} "
  [ "$unstaged" -gt 0 ] && suffix="${suffix}!${unstaged} "
  [ "$untracked" -gt 0 ] && suffix="${suffix}?${untracked} "
  [ "$stashes" -gt 0 ]  && suffix="${suffix}*${stashes} "

  git_str="${icon_git} ${branch}"
  if [ -n "$suffix" ]; then
    suffix="${suffix% }"  # trim trailing space
    git_str="${git_str} ${purple}[${reset}${yellow}${suffix}${purple}]${reset}"
  fi

  parts+=("$(printf "${git_color}${git_str}${reset}")")
fi

# Model (gold, matching runtime version color)
if [ -n "$model" ]; then
  parts+=("$(printf "${gold}${icon_model} ${model}${reset}")")
fi

# Context usage — green → yellow (at 50%) → pink (at 80%)
if [ -n "$used_pct" ]; then
  used_int=$(printf '%.0f' "$used_pct")
  if [ "$used_int" -ge 80 ]; then
    ctx_color="$pink"
  elif [ "$used_int" -ge 50 ]; then
    ctx_color="$yellow"
  else
    ctx_color="$green"
  fi
  parts+=("$(printf "${ctx_color}ctx:${used_int}%%${reset}")")
fi

# Join segments with a wider gap
sep="   "
out=""
for p in "${parts[@]}"; do
  [ -n "$out" ] && out="${out}${sep}"
  out="${out}${p}"
done
printf '%s' "$out"
