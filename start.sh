#!/bin/sh

# Start DBus session in the background
dbus-launch --sh-syntax --exit-with-session &

# Launch dwlit with styling
dbus-run-session ~/dwlit/scripts/./bar.sh | dwlit


