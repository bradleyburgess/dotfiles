#!/bin/bash

source lib.bash
source modules.bash

DRY_RUN="1"
if (whiptail --title "Dry Run?" --yesno "Perform Dry Run?" 0 0); then
  DRY_RUN="1";
else
  DRY_RUN="0";
fi
export DRY_RUN

export TEST_LOCATION="/home/$USER/temp/installer-test"
[[ $DRY_RUN == 1 ]] && mkdir -p $TEST_LOCATION

CHOICES=$(whiptail \
  --title "System Installation" \
  --checklist "Choose your options:" 0 0 0 \
  "01" "Base Utils" on \
  "02" "Dotfiles" on \
  "03" "Oh My Zsh!" on \
  "04" "Tmux" on \
  "05" "NeoVim & NvChad" on \
  "06" "FZF" on \
  "07" "NVM & Node" on \
  "08" "Docker" on \
  "09" "Nerd Fonts" on \
  "10" "Dconf Settings" off \
  "11" "Flatpaks" off \
  "12" "Brother drivers" off \
  3>&1 1>&2 2>&3)

[[ $(echo $CHOICES | grep "01") ]] && install_baseutils && pressany;
[[ $(echo $CHOICES | grep "02") ]] && install_dotfiles && pressany;
[[ $(echo $CHOICES | grep "03") ]] && install_ohmyzsh && pressany;
[[ $(echo $CHOICES | grep "04") ]] && install_tmux && pressany;
[[ $(echo $CHOICES | grep "05") ]] && install_neovim && pressany;
[[ $(echo $CHOICES | grep "06") ]] && install_fzf && pressany;
[[ $(echo $CHOICES | grep "07") ]] && install_node && pressany;
[[ $(echo $CHOICES | grep "08") ]] && install_docker && pressany;
[[ $(echo $CHOICES | grep "09") ]] && install_nerdfonts && pressany;
[[ $(echo $CHOICES | grep "10") ]] && dconf_settings && pressany;
[[ $(echo $CHOICES | grep "11") ]] && install_flatpaks && pressany;
[[ $(echo $CHOICES | grep "12") ]] && install_brother_drivers && pressany;
