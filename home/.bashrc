# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias up='yay -Syu'
alias clean='sudo pacman -Rns $(pacman -Qdtq) ; yay -Sc'
alias ins='yay -S'

alias c="clear"
alias ..="cd .."
alias cd="z"
alias ls="eza -l -a -G --icons=auto --group-directories-first"
alias yz="yazi"
alias lg="lazygit"

fastfetch

eval "$(starship init bash)"

export _ZO_DOCTOR=0
eval "$(zoxide init bash)"
export PATH="$HOME/.local/bin:$PATH"
