#!/usr/bin/env bash

# Define Nord colors
NORD0="2E3440"   # Polar Night (dark background)
NORD4="ECEFF4"   # Snow Storm (light text)
NORD11="BF616A"  # Aurora Red (accent color)

# Define menu options
options=(
    "Lock"
    "Suspend"
    "Hibernate" 
    "Reboot"
    "Shutdown"
    "Logout"
)

# Get user selection - FIXED LINE CONTINUATION
choice=$(printf "%s\n" "${options[@]}" | wmenu -i -b \
    -p "Power Menu: " \
    -f "Hack Nerd Font Mono 16px" \
    -N "$NORD0" -n "$NORD4" \
    -M "$NORD11" -m "$NORD0" \
    -S "$NORD11" -s "$NORD0")

# Define swaylock command
SWAYLOCK="swaylock --color ${NORD0}ff --ring-color $NORD11 --text-color $NORD4"

# Handle selection
case "$choice" in
    "Lock") $SWAYLOCK ;;
    "Suspend") $SWAYLOCK & sleep 1; loginctl suspend ;;
    "Hibernate") $SWAYLOCK & sleep 1; loginctl hibernate ;;
    "Reboot") loginctl reboot ;;
    "Shutdown") loginctl poweroff ;;
    "Logout") pkill -KILL -u "$USER" ;;
    *) echo "Invalid selection" >&2; exit 1 ;;
esac
