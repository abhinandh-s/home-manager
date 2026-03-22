#!/usr/bin/env bash
# music-pick.sh — MPD fuzzy picker, filename only, no thumbnails

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
THEME_FILE="$SCRIPT_DIR/music-pick-theme.rasi"

# Build parallel arrays: display name → full relative path
declare -a names paths
while IFS= read -r track; do
    paths+=("$track")
    names+=("$(basename "$track")")
done < <(mpc listall)

# Join names for rofi input
printf '%s\n' "${names[@]}" \
    | rofi -dmenu -i -p "󰎇 Music" -theme "$THEME_FILE" \
    > /tmp/music-pick-sel

selected_name="$(<  /tmp/music-pick-sel)"
rm -f /tmp/music-pick-sel

[[ -z "$selected_name" ]] && exit 0

# Find the first matching full path (in case of duplicate filenames, picks first)
selected_path=""
for i in "${!names[@]}"; do
    if [[ "${names[$i]}" == "$selected_name" ]]; then
        selected_path="${paths[$i]}"
        break
    fi
done

[[ -z "$selected_path" ]] && exit 1

mpc clear
mpc add "$selected_path"
mpc play
notify-send "Now Playing" "$selected_name" -i audio-speakers
