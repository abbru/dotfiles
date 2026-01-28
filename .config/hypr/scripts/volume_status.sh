#!/bin/bash

# Unique ID for volume notifications
NOTIFY_ID=2500

# Get current volume percentage
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

# Check if muted
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "\[MUTED\]")

if [ "$MUTED" ]; then
    # When muted, we show it clearly without the progress bar
    notify-send -r "$NOTIFY_ID" -u low -i audio-volume-muted "Volume" "Status: Muted"
else
    # When active, we use the 'value' hint to trigger the progress bar in Mako/Dunst
    notify-send -r "$NOTIFY_ID" -u low -h int:value:"$VOLUME" -h string:category:"volume" "Volume" "Current: $VOLUME%"
fi
