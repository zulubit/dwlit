#!/bin/sh

# Define menu options
options="Lock\nSuspend\nHibernate\nReboot\nShutdown\nLogout"

# Pipe options to wmenu and get the user's selection
choice=$(echo "$options" | wmenu \
    -p "What do you want to do? " \
    -f "Nerd 18" \
    -N "2E3440" -n "E5E9F0" \
    -M "A3BE8C" -m "2E3440" \
    -S "A3BE8C" -s "2E3440")

# Define swaylock command
SWAYLOCK="swaylock --color 1e1e2ef8 --ring-color 81a1c1 --text-color d1d3d8"

# Handle the choice
case $choice in
    Lock)
        $SWAYLOCK
        ;;
    Suspend)
        $SWAYLOCK &  # Lock the screen in the background
        sleep 1      # Give swaylock time to start before suspending
        loginctl suspend
        ;;
    Hibernate)
        $SWAYLOCK &  # Lock the screen in the background
        sleep 1      # Give swaylock time to start before hibernating
        loginctl hibernate
        ;;
    Reboot)
        loginctl reboot
        ;;
    Shutdown)
        loginctl poweroff
        ;;
    Logout)
        pkill -KILL -u "$USER"
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

