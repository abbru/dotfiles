#!/bin/bash

while true; do
    # Check battery level and send notifications

    BAT_PATH=""
    for BAT in /sys/class/power_supply/BAT*; do
        if [ -d "$BAT" ]; then
            BAT_PATH="$BAT"
            break
        fi
    done

    if [ -z "$BAT_PATH" ]; then
        echo "No battery found"
        exit 1
    fi

    CAPACITY=$(cat $BAT_PATH/capacity)

    if [ $CAPACITY -le 5 ]; then
        notify-send "Battery Critical" "Battery at $CAPACITY%. Plug in immediately!"
        sleep 10  # Repeat critical warning every 10 seconds
    elif [ $CAPACITY -le 10 ]; then
        notify-send "Battery Low" "Battery at $CAPACITY%. Consider plugging in."
    elif [ $CAPACITY -le 15 ]; then
        notify-send "Battery Warning" "Battery at $CAPACITY%. Low battery."
    fi

    sleep 60  # Normal check interval
done
