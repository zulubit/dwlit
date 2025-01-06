#!/bin/bash

# Print a green message with space above and below
echo -e "\n\e[32mStarting installation process in ~/dwlit...\e[0m\n"

cd ~/dwlit

# Remove config.h
echo -e "\n\e[32mRemoving config.h...\e[0m\n"
sudo rm config.h

# Clean and install
echo -e "\n\e[32mCleaning and installing dwlit...\e[0m\n"
sudo make clean
sudo make HOME_DIR=$(echo ~) install

# Clean again after install
echo -e "\n\e[32mCleaning after installation...\e[0m\n"
sudo make clean

# Change to dwlb directory
echo -e "\n\e[32mChanging directory to ~/dwlit/dwlb...\e[0m\n"
cd ~/dwlit/dwlb

# Install dwlb
echo -e "\n\e[32mInstalling dwlb...\e[0m\n"
sudo make install clean

