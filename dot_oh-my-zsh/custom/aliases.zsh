# eza replaces ls
alias ls='eza -l --icons'
alias lsa='ls --total-size -a'
alias lsts='ls --total-size'
alias tree='eza -T'

# lazygit
alias lg=lazygit

# dotfiles
alias dotfiles="cd $HOME/.dotfiles"
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
