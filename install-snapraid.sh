#!/bin/bash

if [[ -z $(command -v docker) ]]
then
  echo "Docker must be installed before you run this script."
  exit 1
fi

echo -e "\nThis script will install mergerfs and snapraid"
echo -e 'Would you like to continue? Type "yes" to continue'
read CONTINUE_PROMPT

if [[ $CONTINUE_PROMPT != "yes" ]]
then
  exit 0
fi

if [[ -n $(command -v apt) ]]
then
  sudo apt update
  sudo apt install mergerfs fuse
  mkdir -p ~/temp
  cd ~/temp
  git clone https://github.com/IronicBadger/docker-snapraid.git
  cd docker-snapraid
  chmod +x build.sh
  ./build.sh
  cd build/
  dpkg -i snapraid*.deb

elif [[ -n $(command -v pacman) ]]
then
  if [[ -z $(command -v yay) ]]
  then
    echo -e "\nYay must be installed first. Please run install-yay.sh\n"
    exit 1
  else
    sudo pacman -Syy && yay -S snapraid mergerfs fuse2
  fi

else
  echo -e "\nPackage manager not recognized!"
  exit 1
fi

# Install snapraid-runner
sudo mkdir /opt/snapraid-runner
cd /opt/snapraid-runner
wget https://raw.githubusercontent.com/Chronial/snapraid-runner/master/snapraid-runner.py
wget -O snapraid-runner.conf https://raw.githubusercontent.com/IronicBadger/ansible/master/roles/epsilon/templates/opt/snapraid-runner.j2

exit 0
