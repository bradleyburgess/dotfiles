# OHMYZSH / ZSH CONFIG --------------------------------------
export ZSH="/home/$USER/.oh-my-zsh"
export ZSH_CONFIG_DIR="/home/$USER/dotfiles/configs/zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
plugins=(
  asdf
  colored-man-pages
  colorize
  cp
  docker
  docker-compose
  fzf
  git
  npm
  sudo
  tmux
  web-search
)
source $ZSH/oh-my-zsh.sh
# -----------------------------------------------------------


# USER CONFIG -----------------------------------------------
export LANG=en_US.UTF-8
export PATH=$PATH:/home/$USER/bin:/home/$USER/dotfiles/scripts
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
source $ZSH_CONFIG_DIR/.zsh_aliases
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
[[ -f "$ZSH_CONFIG_DIR/.zshrc_$(hostname)" ]] && source $ZSH_CONFIG_DIR/.zshrc_$(hostname)
alias ll='ls -lha'
# -----------------------------------------------------------


# FZF / FUZZY FILE FINDING ----------------------------------
if [[ ! "$PATH" == */home/$USER/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/$USER/.fzf/bin"
fi
[[ $- == *i* ]] && source "/home/$USER/.fzf/shell/completion.zsh" 2> /dev/null
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /home/$USER/.fzf/shell/key-bindings.sh ]] && source "/home/$USER/.fzf/shell/key-bindings.zsh"
# -----------------------------------------------------------


# DEV: NODE NVM ---------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# -----------------------------------------------------------


# DEV: LATEX ------------------------------------------------
export PATH="/usr/local/texlive/2024/bin/x86_64-linux/:$PATH"

# DEV: PHP --------------------------------------------------
export PATH=$PATH:$HOME/.config/composer/vendor/bin
