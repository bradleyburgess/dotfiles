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

mkdir ~/temp

# install mergerfs, fuse & snapraid
if [[ -n $(command -v apt) ]]
then
  sudo apt update
  sudo apt install mergerfs fuse wget
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
    sudo pacman -Syy && yay -S snapraid mergerfs fuse2 wget
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

cd ~/temp

# Copy mergerfs example to fstab
sudo cp /etc/fstab /etc/fstab_old                # backup existing fstab
cp ~/dotfiles/merger-fstab-example fstabtemp     # create temp file
blkid >> fstabtemp                               # copy list of disks with uuids
echo "" >> fstabtemp
if [[ -e /dev/disk/by-id ]]                      # get size of every disk
then
  df -h /dev/disk/by-id/* >> fstabtemp
elif [[ -e /dev/disk/by-uuid ]]
then
  df -h /dev/disk/by-uuid/* >> fstabtemp
fi
sed -i 's/^/# /' fstabtemp                       # comment every line
sudo cat fstabtemp >> /etc/fstab                 # add to fstab

# Cleanup
cd ~/temp
rm -rf docker-snapraid fstabtemp

if [[ ! -f ~/install-scripts.log ]]
then
  echo -e "Install Scripts Run:\n\n" >> ~/install-scripts.log
fi
echo "install-snapraid" >> ~/install-scripts.log

exit 0
