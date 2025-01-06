#!/bin/bash

cd ~/dweasy

sudo rm config.h

sudo make clean

sudo make HOME_DIR=$(echo ~) install
