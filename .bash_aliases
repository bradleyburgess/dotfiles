#!/bin/bash

# GLOBAL ALIASES

alias dropbox='docker exec -it dropbox_personal dropbox'
alias dropboxesumc='docker exec -it dropbox_esumc dropbox'
alias getweather='curl wttr.in'
alias ll='ls -lahF'
alias pip3='python3 -m pip'
alias publicip='dig +short myip.opendns.com @resolver1.opendns.com'
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl shutdown'
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias update='sudo apt-get update && sudo apt-get upgrade'
