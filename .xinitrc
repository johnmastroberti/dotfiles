#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile
xrdb ~/.Xresources
# autostart script:
$HOME/.config/dwm/autostart.sh &
exec dwm
