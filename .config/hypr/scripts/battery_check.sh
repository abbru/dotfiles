#!/bin/bash

# Unique ID to prevent notification stacking
NOTIFY_ID=3000

send_notification() {
    # $1: Urgency (low, normal, critical)
    # $2: Title
    # $3: Message
    notify-send -r "$NOTIFY_ID" -u "$1" "$2" "$3"
}

BAT_PATH=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)

if [ -z "$BAT_PATH" ]; then
    echo "No battery found"
    exit 1
fi

get_status() {
    cat "$BAT_PATH/status"
}

LAST_STATUS=$(get_status)

while true; do
    CAPACITY=$(cat "$BAT_PATH/capacity")
    CURRENT_STATUS=$(get_status)

    # --- State Change Logic (Connect/Disconnect) ---
    if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
        
        if [[ "$CURRENT_STATUS" == "Charging" || "$CURRENT_STATUS" == "Full" ]]; then
            send_notification "normal" "Energy Connected" "󱘖 Battery at $CAPACITY%"
        
        elif [[ "$CURRENT_STATUS" == "Discharging" ]]; then
            send_notification "normal" "Using Battery" "󰂁 Disconnected at $CAPACITY%"
        fi
        
        LAST_STATUS="$CURRENT_STATUS"
    fi

    # --- Critical Levels Logic (Only when Discharging) ---
    if [ "$CURRENT_STATUS" == "Discharging" ]; then
        if [ "$CAPACITY" -le 5 ]; then
            # Critical uses 'critical' urgency for RED borders in Mako
            send_notification "critical" "Critical!" "󰁺 $CAPACITY%. Shutting down soon!"
            sleep 10
            continue
        elif [ "$CAPACITY" -le 10 ]; then
            send_notification "normal" "Battery low" "󰁻 Level: $CAPACITY%"
        elif [ "$CAPACITY" -le 15 ]; then
            send_notification "low" "Battery low" "󰁼 Level: $CAPACITY%"
        fi
    fi

    sleep 5
done
