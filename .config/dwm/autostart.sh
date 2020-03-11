#!/bin/sh
picom &
setbg &
# Shuffle wallpapers
while true; do
  setbg "/home/john/Pictures/backgrounds/$(ls /home/john/Pictures/backgrounds/ | shuf | head -n 1)"
  sleep 10m
done &
dwmblocks &
