#!/bin/bash

# Check WiFi connection using nmcli
INFO=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes')

if [ -n "$INFO" ]; then
    SSID=$(echo $INFO | cut -d: -f2)
    SIGNAL=$(echo $INFO | cut -d: -f3)
    notify-send "WiFi Status" "Connected to $SSID, Signal: ${SIGNAL}%"
else
    notify-send "WiFi Status" "Not connected"
fi