#!/bin/bash

# Check WiFi connection using nmcli
INFO=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes')

if [ -n "$INFO" ]; then
    SSID=$(echo $INFO | cut -d: -f2)
    SIGNAL=$(echo $INFO | cut -d: -f3)
    hyprctl notify 2 1500 "rgb(00FFCC)" "Connected to $SSID, Signal: ${SIGNAL}%"
else
    hyprctl notify 2 1500 "rgb(00FFCC)" "Not Connected"
fi
