#!/bin/sh

rm -rf subprojects build config.h
cp -r subprojects_t subprojects

meson setup -Dwlroots:xwayland=enabled build

cd build

meson install

cd ..
