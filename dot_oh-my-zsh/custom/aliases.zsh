# eza replaces ls
alias ls='eza -l --icons'
alias lsa='ls --total-size -a'
alias lsts='ls --total-size'
alias tree='eza -T'

# search dir with xplr, cd to selection
alias xcd='cd "$(xplr --print-pwd-as-result)"'

# lazygit
alias lg=lazygit

# dotfiles
alias dotfiles="cd $HOME/.dotfiles"
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# claude configs

alias claude-nplus="CLAUDE_CONFIG_DIR=~/.claude-nplus claude"
