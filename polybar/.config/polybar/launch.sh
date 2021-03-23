#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Reload polybar and point it to config file
polybar --reload mainbar-spectrwm -c ~/.config/polybar/config &
