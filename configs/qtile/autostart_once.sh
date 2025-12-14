#!/bin/bash

dbus-update-activation-environment --all
dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP GNOME_SHELL_SESSION_MODE
eval $(gnome-keyring-daemon --start --components=secrets,gpg,ssh)

dbus-send --session --dest=org.freedesktop.secrets /org/freedesktop/secrets \
  org.freedesktop.Secret.Service.SetAlias string:'default' \
  objpath:'/org/freedesktop/secrets/collection/login' >/dev/null 2>&1

picom &
nitrogen --restore &
xinput set-prop 13 304 1 &
setxkbmap -option compose:ralt &
autorandr --change &
pcloud &
light-locker &
