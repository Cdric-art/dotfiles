alias up='sudo eix-sync && sudo emerge -avuDN @world'
alias clean='sudo emerge -a --depclean && sudo eclean-dist -d'
alias ins='sudo emerge -av'

alias c="clear"
alias ..="cd .."
alias cd="z"
alias ls="eza -l -a --icons=auto"
alias yz="yazi"
alias lg="lazygit"

fastfetch

eval "$(starship init bash)"

export _ZO_DOCTOR=0
eval "$(zoxide init bash)"
