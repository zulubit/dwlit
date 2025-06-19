#!/usr/bin/env bash

# Define Nord colors (with # prefix for Rofi)
NORD0="#2E3440"   # Polar Night (dark background)
NORD4="#ECEFF4"   # Snow Storm (light text)
NORD11="#BF616A"  # Aurora Red (accent color)

# Define menu options
options=(
    "Lock"
    "Suspend"
    "Hibernate" 
    "Reboot"
    "Shutdown"
    "Logout"
)

# Get user selection using rofi with inline styling
choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu \
    -p "Power Menu: " \
    -font "Hack Nerd Font Mono 16" \
    -theme-str "window { background-color: ${NORD0}; border-color: ${NORD11}; }" \
    -theme-str "inputbar { children: [prompt, entry]; }" \
    -theme-str "prompt { text-color: ${NORD11}; }" \
    -theme-str "entry { placeholder: \"Power Menu: \"; }" \
    -theme-str "listview { lines: 6; }" \
    -theme-str "element { background-color: ${NORD0}; text-color: ${NORD4}; }" \
    -theme-str "element selected { background-color: ${NORD11}; text-color: ${NORD0}; }" \
    -theme-str "element urgent { background-color: ${NORD11}; text-color: ${NORD0}; }" \
    -theme-str "element active { background-color: ${NORD0}; text-color: ${NORD11}; }")

# Define swaylock command (remove # from color for swaylock)
SWAYLOCK="swaylock --color ${NORD0#\#}ff --ring-color ${NORD11#\#} --text-color ${NORD4#\#}"

# Handle selection
case "$choice" in
    "Lock") $SWAYLOCK ;;
    "Suspend") $SWAYLOCK & sleep 1; loginctl suspend ;;
    "Hibernate") $SWAYLOCK & sleep 1; loginctl hibernate ;;
    "Reboot") systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
    "Logout") loginctl terminate-user "$USER" ;;
    *) echo "Invalid selection" >&2; exit 1 ;;
esac

