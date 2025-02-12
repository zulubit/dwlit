#!/bin/bash

export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=Wayland
export GTK_USE_PORTAL=1
export GTK_THEME=Nordic

exec dbus-run-session  dwlit
