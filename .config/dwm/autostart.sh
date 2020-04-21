#!/bin/sh
picom &
setbg &
# Set a random terminal colorscheme
wal --theme random_dark
# Shuffle wallpapers
while true; do
  setbg "/home/john/Pictures/backgrounds/$(ls /home/john/Pictures/backgrounds/ | shuf | head -n 1)"
  sleep 10m
done &
dwmblocks &
