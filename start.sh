#!/bin/sh

# Load colors from the imported theme
. ~/dweasy/scripts/theme/tokynight

# Start DBus session in the background
dbus-launch --sh-syntax --exit-with-session &

# Set the GTK3/GTK4 theme (works for GTK3 and GTK4 apps)
export GTK_THEME="Nordic"

# Set the GTK2 theme
export GTK2_RC_FILES="$HOME/.themes/Nordic/gtk-2.0/gtkrc"

# Set Wayland environment variables
export ELM_DISPLAY=wl
export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM=wayland-egl
export XDG_SESSION_TYPE=xwayland

# Add Flatpak executables to the PATH for wmenu to detect
export PATH="$PATH:$HOME/.local/bin:/var/lib/flatpak/exports/bin"

# Set light brightness to 50%
light -S 50

# Launch dwl with styling
dbus-run-session dwl -s "dwlb -ipc \
    -active-fg-color $black -active-bg-color $green \
    -occupied-fg-color $white -occupied-bg-color $grey \
    -inactive-fg-color $white -inactive-bg-color $black \
    -urgent-fg-color $red -urgent-bg-color $red \
    -middle-bg-color $black -middle-bg-color-selected $black \
    -no-active-color-title -center-title & \
    ~/dweasy/scripts/./bar.sh | dwlb -status-stdin all & \
    swaybg -i ~/dweasy/Background/bg.jpg -m fill & \
    pipewire & \
    wireplumber & \
    mako --background-color #$black \
         --text-color #$white \
         --border-color #$darkblue \
         --border-size 2 \
         --font 'Hack Nerd Font Mono 12' \
         --icons 1 \
         --max-icon-size 64 & \
    lxpolkit & \
    wait"

