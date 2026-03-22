#!/usr/bin/env bash

# Select an Album
album=$(mpc list album | rofi -dmenu -i -p "󰀥 Select Album")

if [ -n "$album" ]; then
    mpc clear
    # Find all tracks by that album and add them
    mpc find album "$album" | mpc add
    mpc play
    notify-send "Queued Album" "$album"
fi
