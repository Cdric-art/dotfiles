# /etc/skel/.bash_profile

# Connexion sur tty1 : lance Hyprland (remplace SDDM).
# Placé avant .bashrc pour ne pas afficher fastfetch dans le tty.
if [[ -z $WAYLAND_DISPLAY && $XDG_VTNR == 1 ]]; then
	exec start-hyprland >/dev/null 2>&1
fi

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi
