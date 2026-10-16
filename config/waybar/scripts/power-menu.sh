#!/usr/bin/env bash
# Power menu for Waybar (rofi)
choice=$(printf '%s\n' "  Lock" "  Log out" "  Reboot" "  Shut down" |
    rofi -dmenu -i -p "Power:" -theme-str 'listview { lines: 4; }')

case "$choice" in
    *Lock)        hyprlock ;;
    *"Log out")   hyprctl dispatch 'hl.dsp.exit()' ;;
    *Reboot)      systemctl reboot ;;
    *"Shut down") systemctl poweroff ;;
esac
