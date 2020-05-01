#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile
xrdb ~/.Xresources
# autostart script:
$HOME/.config/dwm/autostart.sh &
exec dwm 2>$HOME/log.txt
