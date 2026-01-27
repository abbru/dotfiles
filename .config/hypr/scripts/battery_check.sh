#!/bin/bash

send_hypr_notify() {
    hyprctl notify "$1" 5000 "rgb($2)" "$3"
}

BAT_PATH=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)

# Initialization
# We use a variable to detect if we have external power (AC)
# Some systems use 'Full' when plugged in but at 100%
get_status() {
    local status=$(cat "$BAT_PATH/status")
    echo "$status"
}

LAST_STATUS=$(get_status)

while true; do
    CAPACITY=$(cat "$BAT_PATH/capacity")
    CURRENT_STATUS=$(get_status)

    # --- State Change Logic (Connect/Disconnect) ---
    if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
        
        # If it changes from something to Charging or Full, it means it was connected
        if [[ "$CURRENT_STATUS" == "Charging" || "$CURRENT_STATUS" == "Full" ]]; then
            send_hypr_notify 0 "00FFCC" "󱘖 Energy Connected ($CAPACITY%)"
        
        # If it changes from Charging/Full to Discharging, it means it was disconnected
        elif [[ "$CURRENT_STATUS" == "Discharging" ]]; then
            send_hypr_notify 2 "FFA500" "󰂁 Using Battery ($CAPACITY%)"
        fi
        
        LAST_STATUS="$CURRENT_STATUS"
    fi

    # --- Critical Levels Logic ---
    if [ "$CURRENT_STATUS" == "Discharging" ]; then
        if [ $CAPACITY -le 5 ]; then
            send_hypr_notify 1 "FF5555" "󰁺 Critical!: $CAPACITY%. Shutting down soon!"
            sleep 10
            continue
        elif [ $CAPACITY -le 10 ]; then
            send_hypr_notify 2 "FF5555" "󰁻 Battery low: $CAPACITY%"
        elif [ $CAPACITY -le 15 ]; then
            send_hypr_notify 0 "FFA500" "󰁼 Battery low: $CAPACITY%"
        fi
    fi

    sleep 2 # We lower it to 2 seconds for instant response
done
