#!/bin/sh
picom &
setbg &
# Set a random terminal colorscheme
#wal --theme random_dark && [ -f /home/john/.config/alacritty/update_colors.sh ] \
#  && /home/john/.config/alacritty/update_colors.sh
# Shuffle wallpapers
while true; do
  setbg "/home/john/Pictures/space/$(ls /home/john/Pictures/space/ | shuf | head -n 1)"
  sleep 10m
done &
dwmblocks &
nm-applet &
