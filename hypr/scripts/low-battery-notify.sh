#!/usr/bin/env bash

threshold=5
interval=60
notified=0
device="/org/freedesktop/UPower/devices/DisplayDevice"

while true; do
    info="$(upower -i "$device" 2>/dev/null)"

    if [ -n "$info" ]; then
        state="$(printf '%s\n' "$info" | awk '/state:/ {print $2; exit}')"
        percentage="$(printf '%s\n' "$info" | awk '/percentage:/ {gsub("%", "", $2); print int($2); exit}')"

        if [ "$state" = "discharging" ] && [ -n "$percentage" ] && [ "$percentage" -le "$threshold" ]; then
            if [ "$notified" -eq 0 ]; then
                notify-send -u critical -a "Battery" "Low battery" "Battery is at ${percentage}%. Plug in your charger."
                notified=1
            fi
        else
            notified=0
        fi
    fi

    sleep "$interval"
done
