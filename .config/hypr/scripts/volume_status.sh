#!/bin/bash

# Get current volume percentage
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

# Check if muted
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "\[MUTED\]")

if [ "$MUTED" ]; then
    hyprctl notify 2 1500 "rgb(00FFCC)" "Volumen: Muted"
else
    hyprctl notify 2 1500 "rgb(00FFCC)" "Volumen: $VOLUME%"
fi
