#!/bin/bash

# Adapted from chadwm, thank you! https://github.com/siduck/chadwm

interval=0

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
  echo "^bg(5e81ac) CPU ^bg() $cpu_val"
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
  echo "^bg(5e81ac)  ^bg() $get_capacity"
}

brightness() {
  echo "^bg(5e81ac)  ^bg() $(cat /sys/class/backlight/*/brightness)"
}

mem() {
  echo "^bg(5e81ac)  ^bg() $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
  case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
    up) echo "^bg(5e81ac) 󰤨 ^bg() Connected" ;;
    down) echo "^bg(bf616a) 󰤭 ^bg() Disconnected" ;;
  esac
}

clock() {
  echo "^bg(5e81ac) 󱑆 ^bg() $(date '+%d %B %H:%M')"
}

while true; do
  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ]
  interval=$((interval + 1))

  # Collecting all outputs into one string
  output="$(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock) "
  
  # Output the string to the bar
  echo "$output"
  
  sleep 1
done

