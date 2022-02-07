# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors
precmd() {
  pstr="$(tput bold)$(tput setaf 3)$(whoami | awk '{print $1}')"
  pstr=$pstr"$(tput setaf 2) @ $(tput setaf 4)$(uname -a | awk '{print $2}') "
  wd=$(pwd -P | sed "s|$HOME|~|")
  gitbranch=$(git branch 2>/dev/null | grep \* | sed 's/\* //')
  if [[ -n $gitbranch ]]; then
    gitbranch="$(tput setaf 1)($gitbranch)"
  fi
  pstr=$pstr"$(tput setaf 5)$wd $gitbranch$(tput sgr0)"
  echo "$pstr"
}
PS1="%B$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/cache
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
# Fancy autocomplete
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Fix git autocomplete
__git_files () {
    _wanted files expl 'local files' _files
}

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Reverse i-search
bindkey '^R' history-incremental-pattern-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
if [[ "$0" != '-zsh' ]]; then
  zle-line-init() {
      zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
      echo -ne "\e[5 q"
  }
  zle -N zle-line-init
  echo -ne '\e[5 q' # Use beam shape cursor on startup.
  preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
fi

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

#Bmad/Tao configuration
export DIST_BASE_DIR="/home/john/bmad_dist"
export DIST_SETUP_QUIET="Y"
export ACC_LOCAL_ROOT="/home/john/bmad_dist"
export ACC_BUILD_TEST_EXES="Y"
export LOG=$ACC_LOCAL_ROOT/compile.log
if [ -f ${DIST_BASE_DIR}/util/dist_source_me.zsh ]; then
  source ${DIST_BASE_DIR}/util/dist_source_me.zsh
else
  echo "Note: bmad not configured..."
fi
[ -f ~/.config/bmad/bmad_settings ] && source ~/.config/bmad/bmad_settings
#[ -f ~/.Bmad_Dist_Setup_Log.tmp ] && rm ~/.Bmad_Dist_Setup_Log.tmp
# ulimit -S -c 0
# ulimit -S -s 10240
# ulimit -S -d 25165824

# Geant4 configuration
# if [ -d /home/john/.local/lib/geant ]; then
#  cd "/home/john/.local/lib/geant/geant4.10.06.p01-build/" && source "/home/john/.local/lib/geant/geant4.10.06.p01-build/geant4make.sh" && cd
# fi

# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")" >/dev/null
fi

# Cenns 10
export CENNSMC="$HOME/Documents/research/cenns10geant4"
CENNS_SETUP="$CENNSMC/setenv.sh"
if [ -f $CENNS_SETUP ]; then
  export CENNSMC
  source $CENNS_SETUP
fi

#neofetch
#eval "$(pyenv init -)"
## Fix for pyenv causing bsdtar not to be found
#export PATH="/home/john/.pyenv-fixes:$PATH"

source ~/.config/lsx/lsx.sh


# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
