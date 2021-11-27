#!/bin/bash

if [[ -n $(command -v apt) ]]
then
  sudo apt update && sudo apt install curl
  sudo curl -sSL https://get.docker.com | sh
elif [[ -n $(command -v pacman) ]]
then
  sudo pacman -Syy && sudo pacman -S docker docker-compose
fi

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

if [[ ! -f ~/install-scripts.log ]]
then
  echo -e "Install Scripts Run:\n\n" >> ~/install-scripts.log
fi
echo "install-docker" >> ~/install-scripts.log
