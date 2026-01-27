#!/bin/bash

# Get current volume percentage
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

# Check if muted
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "\[MUTED\]")

if [ "$MUTED" ]; then
    notify-send "Volume" "Muted"
else
    notify-send "Volume" "Current: $VOLUME%"
fi