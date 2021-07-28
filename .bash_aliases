#!/bin/bash
# GLOBAL ALIASES

# NAVIGATION
# ============================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias godotfiles='cd ~/dotfiles'

# cd hack from https://www.redhat.com/sysadmin/cd-command
function cd {
  if [ $# -eq 0  ]; then
    pushd ~ > /dev/null
  elif [ " $1" = " -"  ]; then
    pushd "$OLDPWD" > /dev/null
  else
    pushd "$@" > /dev/null
  fi
}

# LS OPTIONS
# ============================
alias ll='ls -lah'
alias l='ls -lah'

# GREP
# ============================
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# TMUX
# ============================
alias tma='tmux attach -t'
# alias tmn='tmux new -s'
alias tml='tmux ls'
alias tmk='tmux kill-session -t'

function tmn() {
  if [[ $1 = "" ]]
  then
    tmux new-session
  elif [[ $1 = "." ]]
  then
    tmux new-session -s ${PWD##*/}
  else
    tmux new-session -s $1
  fi
}

function tmuxadmin() {
  cd ~/
  tmux new-session -d -s admin
  tmux rename-window -t admin:1 htop
  tmux new-window -t admin -a -n update
  tmux new-window -t admin -a -n backup
  tmux select-window -t admin:1
  tmux send -t admin:1 htop ENTER
  tmux attach -t admin
}

# GIT
# ============================
alias ga='git add '           # Add
alias gc='git commit '        # Commit
alias gco='git checkout '     # Checkout
alias gd='git diff '          # Diff
alias gl='git log --oneline'  # Log (oneline)
alias gpull='git pull '       # Pull
alias gpush='git push '       # Push
alias gs='git status '        # Status
alias gbl='git branch --list' # List branches
alias gbd='git branch -d '    # Delete branch

# SYS TOOLS
# ============================
alias pip3='python3 -m pip'
alias publicip='dig +short myip.opendns.com @resolver1.opendns.com'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl shutdown'

# GENERAL APPS
# ============================
alias getweather='curl wttr.in'
alias r="ranger"
alias gtypist="gtypist -s"

# OTHER IDEAS
# ============================

# Easy way to extract archives
# extract () {
#   if [ -f $1 ] ; then
#     case $1 in
#       *.tar.bz2)   tar xvjf $1    ;;
#       *.tar.gz)    tar xvzf $1    ;;
#       *.bz2)       bunzip2 $1     ;;
#       *.rar)       unrar x $1     ;;
#       *.gz)        gunzip $1      ;;
#       *.tar)       tar xvf $1     ;;
#       *.tbz2)      tar xvjf $1    ;;
#       *.tgz)       tar xvzf $1    ;;
#       *.zip)       unzip $1       ;;
#       *.Z)         uncompress $1  ;;
#       *.7z)        7z x $1        ;;
#       *)           echo "don't know how to extract '$1'..." ;;
#     esac
#   else
#     echo "'$1' is not a valid file!"
#   fi
# }
