#!/bin/bash

# Function to handle errors and exit the script
error_exit() {
    echo "Error: $1"
    exit 1
}

# Update the system
sudo xbps-install -Syu || error_exit "Void failed to update befor starting the install"

# Install all the packages
sudo xbps-install -y NetworkManager Thunar tumbler gthumb base-devel base-system blueman curl mako elogind flatpak fcft polkit polkit-elogind lxsession void-repo-nonfree fcft-devel swaylock firefox foot gcc git libxml2-devel xdg-desktop-portal-wlr xdg-desktop-portal-gtk light make mesa-dri pamixer pavucontrol pipewire pulseaudio qt5-wayland qt6-wayland sof-firmware sof-tools swaybg wget wl-clipboard wlroots-devel wlroots0.18 wlroots0.18-devel wmenu dejavu-fonts-ttf xorg-server-xwayland grim slurp swappy vlc wf-recorder || error_exit "Package installation failed."

# add flathub
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Remove the wpa_supplicant symlink
sudo rm -f /var/service/wpa_supplicant || error_exit "Failed to remove wpa_supplicant symlink."

# Create correct symlinks in /var/service
sudo ln -s /etc/sv/NetworkManager /var/service || error_exit "Failed to create NetworkManager symlink."
sudo ln -s /etc/sv/dbus /var/service || error_exit "Failed to create dbus symlink."
sudo ln -s /etc/sv/elogind /var/service || error_exit "Failed to create elogind symlink."
sudo ln -s /etc/sv/bluetoothd /var/service || error_exit "Failed to create bluetoothd symlink."
sudo ln -s /etc/sv/polkitd /var/service || error_exit "Failed to create polkitd symlink."

# Build dwlit
sudo make install clean || error_exit "Failed to build and install dwlit."

# Make bar.sh and start.sh executable
chmod +x ~/dwlit/scripts/bar.sh || error_exit "Failed to make bar.sh executable."
chmod +x start.sh || error_exit "Failed to make start.sh executable."
chmod +x rebuild.sh || error_exit "Failed to make rebuild.sh executable."

# Install themes (add the installtheme.sh script)
chmod +x installtheme.sh || error_exit "Failed to make installtheme.sh executable."
./installtheme.sh || error_exit "Failed to run installtheme.sh."

# Add TTY1 auto-run configuration
AUTO_RUN_CHECK='if [ "$(tty)" = "/dev/tty1" ]; then\n    ~/dwlit/start.sh\nfi'
if ! grep -Fq "$AUTO_RUN_CHECK" ~/.bash_profile; then
    echo -e "\n# Auto-run ~/dwlit/start.sh on TTY1\n$AUTO_RUN_CHECK" >> ~/.bash_profile || error_exit "Failed to set up TTY1 auto-run."
fi

# Completion message
echo "You should 'sudo reboot' your system, then you can use './dwlit/start' after logging back in. you can start a terminal using windows_log + return when in a session and run 'ice' to get some usefull info. Your network connection is disabled, use 'nmtui' in the terminal to reconnect"

