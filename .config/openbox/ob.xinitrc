#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile
xrdb ~/.Xresources
exec openbox
