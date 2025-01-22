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
ICON_MIC_ON=" 󰍬"    # Microphone on icon
ICON_MIC_MUTED=" 󰍭" # Microphone muted icon
ICON_BLUETOOTH_ON=" 󰂯" # Bluetooth on icon
ICON_BLUETOOTH_OFF=" 󰂲" # Bluetooth off icon
ICON_LAN_CONNECTED=" 󰈀" # LAN connected icon
ICON_LAN_DISCONNECTED=" 󰇚" # LAN disconnected icon
ICON_POWER="⏻"  # Power icon

# Function to get the current time
get_time() {
    echo "^fg($black)^bg($blue)$ICON_TIME ^bg() ^fg($white)$(date '+%B %d') - $(date '+%H:%M')"
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
    
    echo "^fg($black)^bg($BATTERY_BG_COLOR)$ICON_BATTERY ^bg() ^fg($white)$BATTERY"
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

# Alternative network status for LAN
get_network_alt() {
    LAN_STATUS=$(nmcli -t -f DEVICE,TYPE,STATE dev status | grep 'ethernet:connected')
    if [[ -z "$LAN_STATUS" ]]; then
        LAN_STATUS_ICON=$ICON_LAN_DISCONNECTED
        LAN_BG_COLOR=$red  # Red background for disconnected LAN
    else
        LAN_STATUS_ICON=$ICON_LAN_CONNECTED
        LAN_BG_COLOR=$green  # Default background color for connected LAN
    fi

    echo "^fg($black)^bg($LAN_BG_COLOR)$LAN_STATUS_ICON ^bg()"
}

# Function to check if Bluetooth is active
get_bluetooth() {
    BLUETOOTH_STATUS=$(bluetoothctl show | grep -q "Powered: yes" && echo "on" || echo "off")
    if [[ "$BLUETOOTH_STATUS" == "on" ]]; then
        BT_ICON=$ICON_BLUETOOTH_ON
        BT_BG_COLOR=$green  # Green background for active Bluetooth
    else
        BT_ICON=$ICON_BLUETOOTH_OFF
        BT_BG_COLOR=$red  # Red background for inactive Bluetooth
    fi

    echo "^fg($black)^bg($BT_BG_COLOR)$BT_ICON ^bg()"
}

# Function to get volume and microphone status
get_volume() {
    DEFAULT_SINK="@DEFAULT_AUDIO_SINK@"
    DEFAULT_SOURCE="@DEFAULT_AUDIO_SOURCE@"

    # Get the volume percentage
    VOLUME=$(wpctl get-volume "$DEFAULT_SINK" | awk '{print $2*100}' | cut -d. -f1)

    # Check if the volume is muted
    VOLUME_MUTED=$(wpctl get-volume "$DEFAULT_SINK" | grep -o "MUTED")

    # Check if the microphone is muted
    MIC_MUTED=$(wpctl get-volume "$DEFAULT_SOURCE" | grep -o "MUTED")

    # Set microphone icon and background
    if [[ "$MIC_MUTED" == "MUTED" ]]; then
        MIC_ICON=$ICON_MIC_MUTED
        MIC_BG_COLOR=$red  # Red background for muted mic
    else
        MIC_ICON=$ICON_MIC_ON
        MIC_BG_COLOR=$green  # Default background color for mic
    fi

    # Set volume icon and background
    if [[ "$VOLUME_MUTED" == "MUTED" ]]; then
        VOLUME_ICON=$ICON_VOLUME_MUTED
        VOLUME_STATUS="Muted"
        VOLUME_BG_COLOR=$red  # Red background for muted volume
    else
        VOLUME_ICON=$ICON_VOLUME
        VOLUME_STATUS="$VOLUME"
        VOLUME_BG_COLOR=$green  # Default background color for volume
    fi

    MIC_OUTPUT="^fg($black)^bg($MIC_BG_COLOR)$MIC_ICON ^bg()"
    VOL_OUTPUT="^fg($black)^bg($VOLUME_BG_COLOR)$VOLUME_ICON ^bg() ^fg($white)$VOLUME_STATUS"
    echo "$MIC_OUTPUT $VOL_OUTPUT"
}

# Power button
get_power() {
    echo "^lm(~/dwlit/scripts/./power.sh)^fg($white) $ICON_POWER^lm()"
}

# Main loop
while true; do
    # Get outputs from functions
    TIME_OUTPUT=$(get_time)
    BATTERY_OUTPUT=$(get_battery)
    NETWORK_OUTPUT=$(get_network)
    NETWORK_ALT_OUTPUT=$(get_network_alt)
    BLUETOOTH_OUTPUT=$(get_bluetooth)
    VOLUME_OUTPUT=$(get_volume)
    POWER_OUTPUT=$(get_power)

    # Combine everything in the final output
    echo "$BATTERY_OUTPUT $VOLUME_OUTPUT $TIME_OUTPUT $NETWORK_OUTPUT $BLUETOOTH_OUTPUT$POWER_OUTPUT"

    sleep 1
done

