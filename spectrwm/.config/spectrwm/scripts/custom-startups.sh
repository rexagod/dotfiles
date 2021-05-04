#!/bin/bash

# Synchronous operations below, need to wait till startup ticks are done with.
sleep 1

# Hide polybar initially.
# polybar-msg cmd hide

# Map Caps Lock to Escape.
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Bluetooth manager.
blueman-tray &
