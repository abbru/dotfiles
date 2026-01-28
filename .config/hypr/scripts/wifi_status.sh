#!/bin/bash

# Unique ID for network notifications
NOTIFY_ID=4000

# Check WiFi connection using nmcli
INFO=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes')

if [ -n "$INFO" ]; then
    SSID=$(echo "$INFO" | cut -d: -f2)
    SIGNAL=$(echo "$INFO" | cut -d: -f3)
    
    # We use the 'value' hint so the signal strength shows as a progress bar
    notify-send -r "$NOTIFY_ID" -u low -h int:value:"$SIGNAL" -i network-wireless "WiFi" "Connected to $SSID, Signal: ${SIGNAL}%"
else
    notify-send -r "$NOTIFY_ID" -u normal -i network-wireless-disconnected "WiFi" "Status: Not Connected"
fi
