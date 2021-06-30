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
