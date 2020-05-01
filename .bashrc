#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
# Prompt
my_bash_prompt() {
  pstr="$(tput bold)$(tput setaf 3)$(whoami | awk '{print $1}')"
  pstr=$pstr"$(tput setaf 2) @ $(tput setaf 4)$(uname -a | awk '{print $2}') "
  wd=$(pwd | sed "s|$HOME|~|")
  pstr=$pstr"$(tput setaf 5)$wd$(tput sgr0)"
  echo "$pstr"
}
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export PS1="\[$(tput bold)\]\[$(tput setaf 7)\]\$ \[$(tput sgr0)\]"
export PS2="\[$(tput bold)\]\[$(tput setaf 7)\]> \[$(tput sgr0)\]"
export PROMPT_COMMAND=my_bash_prompt

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

#Bmad/Tao configuration
export DIST_BASE_DIR="/home/john/bmad_dist"
export DIST_SETUP_QUIET="Y"
export ACC_LOCAL_ROOT="/home/john/bmad_dist"
export ACC_BUILD_TEST_EXES="Y"
export LOG=$ACC_LOCAL_ROOT/compile.log
source ${DIST_BASE_DIR}/util/dist_source_me
ulimit -S -c 0
ulimit -S -s 10240
ulimit -S -d 25165824

neofetch
#eval "$(pyenv init -)"
## Fix for pyenv causing bsdtar not to be found
#export PATH="/home/john/.pyenv-fixes:$PATH"
