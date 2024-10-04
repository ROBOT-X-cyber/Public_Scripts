#####################################################################
###                                                               ###
### This config depends on NerdFonts to be used in your terminal, ###
### else the glyphs will not render correctly!!!                  ###
###                                                               ###
#####################################################################

# ~/.bashrc file for bash interactive shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable auto-cd
shopt -s autocd

# Prompt corrections and filename expansion
shopt -s cdspell  # Spell correction for directory names
shopt -s dirspell # Correct typos when changing directories
shopt -s nocaseglob # Case-insensitive globbing

# Key bindings - Use readline settings (compatible with bash)
bind '"\C-[[3;5~": kill-word'           # ctrl + del
bind '"\C-[[1;5C": forward-word'        # ctrl + ->
bind '"\C-[[1;5D": backward-word'       # ctrl + <-
bind '"\C-[[5~": beginning-of-history'  # page up
bind '"\C-[[6~": end-of-history'        # page down

# History settings
HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=2000
HISTCONTROL=ignoredups:ignorespace  # Ignore duplicates and commands starting with a space

# Display all history with the history command
alias history="history 0"

# Colored prompt and IP address settings

# Getting IP addresses
IP1=$(ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep eth0 | grep -Po "inet \K[\d.]+")
IP2=$(ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep tun0 | grep -Po "inet \K[\d.]+")
IP3=$(ip -4 addr | grep -v 127.0.0.1 | grep -v secondary | grep wlan0 | grep -Po "inet \K[\d.]+")

# Create prompt parts based on which interfaces are found
if [ -n "$IP1" ]; then
    LOCAL="\[\e[32m\]─🮤 \[\e[36m\]$IP1\[\e[32m\]🮥"
else
    LOCAL=""
fi

if [ -n "$IP2" ]; then
    VPN="\[\e[32m\]─🮤 \[\e[33m\]$IP2\[\e[32m\]🮥"
else
    VPN=""
fi

if [ -n "$IP3" ]; then
    WIFI="\[\e[32m\]─🮤直 \[\e[31m\]$IP3\[\e[32m\]🮥"
else
    WIFI=""
fi

DIR='\[\e[1;32m\]\w'
NAME='\[\e[34m\] \[\e[35m\]Abhirup'

# Custom prompt
PS1="\[\e[32m\]┌──🮤$NAME\[\e[32m\]🮥$LOCAL$VPN$WIFI\n\[\e[32m\]├──🮤\[\e[1;33m\]  $DIR\[\e[32m\]🮥\n\[\e[32m\]└─\[\e[34m\]   "

# Enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Enable syntax highlighting for bash
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Aliases
alias ll='ls -la'
alias la='ls -A'

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac
