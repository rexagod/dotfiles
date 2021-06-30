#!/bin/bash

# Synchronous operations below, need to wait till startup ticks are done with.
sleep 1

# Hide polybar initially.
# polybar-msg cmd hide

# Map Caps Lock to BackSpace.
# setxkbmap -option caps:backspace
# setxkbmap -option shift:both_capslock
# xmodmap -e "clear Lock"

# Bluetooth manager.
blueman-tray &

# Backup packages.
pacman -Qe | awk '{print $1}' > ~/dotfiles/pacman-lists/pkglist.txt
