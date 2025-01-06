#!/bin/bash

# Load colors from the imported theme
. ~/dwlit/scripts/theme/theme

# Nerd Font Icons
ICON_TIME=" 󱑃"      # Time icon
ICON_BATTERY=" "   # Battery icon
ICON_NET_CONNECTED=" " # Wi-Fi connected icon
ICON_NET_DISCONNECTED=" 󱚼" # Wi-Fi disconnected icon
ICON_VOLUME=" "     # Volume icon
ICON_VOLUME_MUTED=" "  # Volume muted icon

# Function to get the current time
get_time() {
    echo "^fg($black)^bg($blue)$ICON_TIME ^bg() ^fg($white)$(date '+%H:%M:%S')"
}

# Function to get battery status and color
get_battery() {
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    
    # Check if battery is below 15% for red background
    if [ "$BATTERY" -lt 15 ]; then
        BATTERY_BG_COLOR=$red  # Red background for low battery
    else
        BATTERY_BG_COLOR=$green  # Default background color for battery
    fi
    
    echo "^fg($black)^bg($BATTERY_BG_COLOR)$ICON_BATTERY ^bg() ^fg($white)$BATTERY%"
}

# Function to get network status
get_network() {
    NETWORK_STATUS=$(nmcli -t -f DEVICE,TYPE,STATE dev status | grep 'wifi:connected')
    if [[ -z "$NETWORK_STATUS" ]]; then
        NET_STATUS_ICON=$ICON_NET_DISCONNECTED
        NET_BG_COLOR=$red  # Red background for disconnected Wi-Fi
    else
        NET_STATUS_ICON=$ICON_NET_CONNECTED
        NET_BG_COLOR=$green  # Default background color for connected Wi-Fi
    fi

    echo "^fg($black)^bg($NET_BG_COLOR)$NET_STATUS_ICON ^bg()"
}

# Function to get volume status and color
get_volume() {
    VOLUME=$(pamixer --get-volume)
    VOLUME_MUTED=$(pamixer --get-mute)

    # If the volume is muted, change the icon and status, and set red background
    if [[ "$VOLUME_MUTED" == "true" ]]; then
        VOLUME_ICON=$ICON_VOLUME_MUTED
        VOLUME_STATUS="Muted"
        VOLUME_BG_COLOR=$red  # Red background for muted volume
    else
        VOLUME_ICON=$ICON_VOLUME
        VOLUME_STATUS="$VOLUME"
        VOLUME_BG_COLOR=$green  # Default background color for volume
    fi

    echo "^fg($black)^bg($VOLUME_BG_COLOR)$VOLUME_ICON ^bg() ^fg($white)$VOLUME_STATUS"
}

# Main loop
while true; do
    # Get outputs from functions
    TIME_OUTPUT=$(get_time)
    BATTERY_OUTPUT=$(get_battery)
    NETWORK_OUTPUT=$(get_network)
    VOLUME_OUTPUT=$(get_volume)

    # Combine everything in the final output
    echo "$BATTERY_OUTPUT $VOLUME_OUTPUT $TIME_OUTPUT $NETWORK_OUTPUT"

    sleep 1
done

