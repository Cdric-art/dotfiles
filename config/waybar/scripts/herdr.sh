#!/bin/sh
# Ramène la fenêtre Herdr au premier plan, ou lance Herdr s'il n'est pas ouvert.
if hyprctl clients -j | jq -e 'any(.[]; .class == "herdr-app")' >/dev/null; then
    hyprctl dispatch 'hl.dsp.focus({ window = "class:herdr-app" })' >/dev/null
else
    setsid -f "$HOME/.local/bin/herdr-app" >/dev/null 2>&1
fi
