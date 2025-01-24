#!/bin/sh

# Start DBus session in the background
dbus-launch --sh-syntax --exit-with-session &

export GTK_THEME="Nordic"

# Set the GTK2 theme
export GTK2_RC_FILES="$HOME/.themes/Nordic/gtk-2.0/gtkrc"

# Set Wayland environment variables
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM=wayland-egl
export XDG_SESSION_TYPE=xwayland
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland

# Stop the power key from shuting down the system without warning
export HANDLE_POWER_KEY=ignore

# Add Flatpak executables to the PATH for wmenu to detect
export PATH="$PATH:$HOME/.local/bin:/var/lib/flatpak/exports/bin"

# Launch dwlit with styling
dbus-run-session ~/dwlit/scripts/./bar.sh | dwlit


