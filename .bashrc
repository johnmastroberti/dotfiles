#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

#Bmad/Tao configuration
export DIST_BASE_DIR="/home/john/bmad_dist"
export DIST_SETUP_QUIET="Y"
export ACC_LOCAL_ROOT="/home/john/bmad_dist"
export LOG=$ACC_LOCAL_ROOT/compile.log
source ${DIST_BASE_DIR}/util/dist_source_me
ulimit -S -c 0
ulimit -S -s 10240
ulimit -S -d 25165824

neofetch
eval "$(pyenv init -)"
