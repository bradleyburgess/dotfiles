#!/bin/bash

chosen=$(printf "Lock\nLogout\nReboot\nShutdown" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
    Lock) light-locker-command -l ;;
    Logout) qtile cmd-obj -o cmd -f shutdown ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
    *) exit 1 ;;
esac
