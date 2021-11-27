#!/bin/bash

# Install common packages from pkglist

echo -e "\nThis script will install the list of packages found at ~/pkglist."

# Check for existing pkglist in home dir; copy sample if not
if [[ ! -f ~/pkglist ]]
then
  if [[ ! -f ~/dotfiles/pkglist-sample ]]
  then
    echo -e "# Add packages to install below, one per line with no whitespace\n\n" >> ~/pkglist
  else
    cp ~/dotfiles/pkglist-sample ~/pkglist
  fi
fi

# Edit pklist file with vim or vi
if [[ -n $(command -v vim) ]]
then
  vim ~/pkglist
else
  vi ~/pkglist
fi

echo -e "\nPkglist found. Would you like to proceed with the installation?"
echo -e 'Type "yes" to proceed.'
read INSTALL_PROMPT
if [[ $INSTALL_PROMPT != "yes" ]]
then
  exit 1
fi

# Install packages with either apt or pacman
if [[ -n $(command -v apt) ]]
then
  sudo apt update && sudo apt install $(grep -v '^#\|^#' ~/pkglist)
elif [[ -n $(command -v pacman) ]]
then
  sudo pacman -Sy && sudo pacman -S $(grep -v '^#\|^#' ~/pkglist)
else
  echo "Package manager not recognized!"
fi

if [[ ! -f ~/install-scripts.log ]]
then
  echo -e "Install Scripts Run:\n\n" >> ~/install-scripts.log
fi
echo "install-packages" >> ~/install-scripts.log
echo $(grep -v '^#' ~/pkglist | sed 's/^/  - /') >> ~/install-scripts.log

exit 0
