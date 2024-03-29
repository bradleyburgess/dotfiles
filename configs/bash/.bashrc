# ~/.bashrc: executed by bash(1) for non-login shells.

export BASH_CONFIG_DIR="/home/$USER/dotfiles/configs/bash"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac





# ============================================================================
# GENERAL
# ============================================================================
HISTCONTROL=ignoreboth                 # History: no duplicates / blank starts
shopt -s histappend                    # Append to history; don't overwrite
HISTSIZE=1000                          # History length
HISTFILESIZE=2000                      # History size
shopt -s checkwinsize                  # Check terminal resize
shopt -s globstar                      # "**" path expansion
set -o vi                              # vi keybindings for bash

# Enable programmable completion features 
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi





# ===========================================
# COLORS
# ===========================================
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi
# Enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'





# ===========================================
# NVM ENVIRONMENT
# ===========================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion





# ===========================================
# ORIGINAL $PS1 SETTING
# ===========================================
# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt





# ===========================================
# SOURCE BASH CONFIGS
# ===========================================
source $BASH_CONFIG_DIR/.bash_aliases        # Source global aliases
source $BASH_CONFIG_DIR/.bash_prompt         # Set prompt
source $BASH_CONFIG_DIR/git-completion.bash  # Enable git bash completion
source $BASH_CONFIG_DIR/tmux-completion.bash # Enable tmux bash completion

export PATH=$PATH:/home/$USER/bin:/home/$USER/dotfiles/scripts

# Source FZF config
[ -f /home/$USER/.fzf.bash ] && source /home/$USER/.fzf.bash

# Source machine-specific settings
if [ -f $BASH_CONFIG_DIR/.bash_$HOSTNAME ]; then
    source $BASH_CONFIG_DIR/.bash_$HOSTNAME
fi
#. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
