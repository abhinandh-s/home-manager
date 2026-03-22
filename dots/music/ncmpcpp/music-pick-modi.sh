#!/usr/bin/env bash
# Called by Rofi as a script modi.
# When called with no args: print the list.
# When called with the selected item as $1: act on it.

MUSIC_DIR="${MPD_MUSIC_DIR:-$HOME/Music}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/music-pick"

get_cover() {
    local rel_path="$1"
    local full_path="$MUSIC_DIR/$rel_path"
    local cache_key
    cache_key=$(printf '%s' "$rel_path" | md5sum | cut -d' ' -f1)
    local cache_img="$CACHE_DIR/${cache_key}.jpg"

    if [[ ! -f "$cache_img" ]]; then
        if ! ffmpeg -y -loglevel quiet \
                -i "$full_path" \
                -an -vframes 1 \
                -vf "scale=256:256:force_original_aspect_ratio=decrease,pad=256:256:(ow-iw)/2:(oh-ih)/2:black" \
                "$cache_img" 2>/dev/null; then
            local dir
            dir="$(dirname "$full_path")"
            local found=""
            for candidate in "$dir/cover.jpg" "$dir/cover.png" \
                             "$dir/folder.jpg" "$dir/folder.png" \
                             "$dir/artwork.jpg" "$dir/Folder.jpg"; do
                if [[ -f "$candidate" ]]; then
                    found="$candidate"
                    break
                fi
            done
            if [[ -n "$found" ]]; then
                ffmpeg -y -loglevel quiet \
                    -i "$found" \
                    -vf "scale=256:256:force_original_aspect_ratio=decrease,pad=256:256:(ow-iw)/2:(oh-ih)/2:black" \
                    "$cache_img" 2>/dev/null
            fi
        fi
    fi
    echo "$cache_img"
}

if [[ -z "$@" ]]; then
    # List mode: print all tracks with icon annotations
    while IFS= read -r track; do
        icon=$(get_cover "$track")
        if [[ -f "$icon" ]]; then
            printf '%s\0icon\x1f%s\n' "$track" "$icon"
        else
            printf '%s\n' "$track"
        fi
    done < <(mpc listall)
else
    # Selection mode: play the chosen track
    selection="$@"
    mpc clear
    mpc add "$selection"
    mpc play

    cover=$(get_cover "$selection")
    if [[ -f "$cover" ]]; then
        notify-send "Now Playing" "$selection" -h string:image-path:"$cover"
    else
        notify-send "Now Playing" "$selection" -i audio-speakers
    fi
fi
