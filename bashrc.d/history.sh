# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# http://askubuntu.com/a/67306
PROMPT_COMMAND="history -a; ${PROMPT_COMMAND:-}"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=400000000
HISTFILESIZE=$(( HISTSIZE * 2 ))
