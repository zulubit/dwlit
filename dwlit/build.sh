#!/bin/sh

rm -rf build config.h

rm build/config.h

meson setup -Dwlroots:xwayland=enabled build

cd build

meson install

cd ..
