#!/usr/bin/env bash

# 1. Get all files from MPD recursively
# 2. Pass to Rofi for selection (fuzzy search enabled)
# 3. If a selection is made, clear the current queue, add the file, and play
selection=$(mpc listall | rofi -dmenu -i -p "󰎇 Music" -theme-str 'window {width: 50%;}')

if [ -n "$selection" ]; then
    mpc clear
    mpc add "$selection"
    mpc play
    notify-send "Now Playing" "$selection" -i audio-speakers
fi
