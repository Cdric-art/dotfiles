#!/usr/bin/env bash
# Power menu for Waybar (wofi)
choice=$(printf '%s\n' "  Lock" "  Log out" "  Reboot" "  Shut down" |
    wofi --dmenu -i -p "Power" --lines 5 --width 220 --cache-file /dev/null)

case "$choice" in
    *Lock)        hyprlock ;;
    *"Log out")   hyprctl dispatch 'hl.dsp.exit()' ;;
    *Reboot)      systemctl reboot ;;
    *"Shut down") systemctl poweroff ;;
esac
