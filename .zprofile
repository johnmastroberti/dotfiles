#!/bin/sh
# Profile file. Runs on login.

# use ~/.Xdefaults
#xrdb ~/.Xdefaults

# Adds `~/.local/bin` and all subdirectories to $PATH
export PATH="$PATH:$HOME/.cargo/bin:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILE="vifm"
export PAGER="less"
export MANPAGER='nvim +"setl hlsearch" +Man!'
export MANWIDTH=999
export SUDO_ASKPASS="$HOME/.local/bin/dmenu/dmenupass"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export GOPATH="$HOME/.local/go"
export GNUPLOT_LIB="$XDG_CONFIG_HOME/gnuplot"
export LESSHISTFILE="-"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# common SSH targets
export LAPTOP="192.168.50.54"
export RASPI="192.168.50.175"

#Geant4 configuration
if [ -d /home/john/.local/lib/geant ]; then
  cd "/home/john/.local/lib/geant/geant4.10.06.p01-build/" && source "/home/john/.local/lib/geant/geant4.10.06.p01-build/geant4make.sh" && cd
fi

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server if bspwm/openbox not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >/dev/null && exec startx

# Switch escape and caps if tty:
sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null

