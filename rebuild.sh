#!/bin/bash

cd ~/dwlit

sudo rm config.h

sudo make clean

sudo make HOME_DIR=$(echo ~) install

sudo make clean
