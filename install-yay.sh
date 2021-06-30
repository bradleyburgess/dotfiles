#!/bin/bash

if [[ ! -d ~/temp ]]
then
  mkdir ~/temp
fi

cd ~/temp

sudo pacman -Syy && sudo pacman -S --needed git base-devel
if [[ -z $(command -v go) ]]
then
  sudo pacman -Syy && sudo pacman -S go
fi

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/dotfiles
sudo rm -rf ~/temp/yay

if [[ ! -f ~/install-scripts.log ]]
then
  echo -e "Install Scripts Run:\n\n" >> ~/install-scripts.log
fi
echo "install-yay" >> ~/install-scripts.log
