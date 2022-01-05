#!/bin/bash

TEST_LOCATION="/home/$USER/temp/installer-test"
[[ $DRY_RUN == 1 ]] && mkdir -p $TEST_LOCATION
source ./lib.bash

install_baseutils () {
  display_install_step "Base Utils"
  if [[ $DRY_RUN == 1 ]]
  then
    cat << EOF
Dry Run:
  sudo apt update && sudo apt upgrade && sudo apt install \\
    baobab \\
    curl \\
    gparted \\
    htop \\
    iftop \\
    mosh \\
    ncdu \\
    openssh \\
    pdftk \\
    ranger \\
    ripgrep \\
    rsync \\
    silversearcher-ag \\
    tmux \\
    tree \\
    unzip \\
    wget
EOF
  else
    sudo apt update && sudo apt upgrade && sudo apt install \
      baobab \
      curl \
      gparted \
      htop \
      iftop \
      mosh \
      ncdu \
      openssh-client \
      openssh-server \
      pdftk \
      ranger \
      ripgrep \
      rsync \
      silversearcher-ag \
      tmux \
      tree \
      unzip \
      wget
  fi
}

install_dotfiles () {
  display_install_step "Dotfiles"
  if [[ $DRY_RUN == 1 ]];
  then
    echo "Dry Run: Clone git repo; symlink .bashrc"
  else
    [[ ! -d ~/dotfiles ]] && git clone https://github.com/bradleyburgess/dotfiles.git ~/dotfiles;
    [[ -f ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc_old;
    ln -s ~/dotfiles/.bashrc ~/.bashrc;
  fi
}

install_ohmyzsh () {
  display_install_step "Oh My Zsh"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Oh My Zsh"
  else
    sudo apt install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    mv ~/.zshrc ~/.zshrc_old
    ln -s ~/dotfiles/.zshrc ~/.zshrc
  fi
}

install_tmux () {
  display_install_step "Tmux"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Link tmux config; install plugins"
  else
    if [[ -f ~/.tmux.conf ]]
    then
      mv ~/.tmux.conf ~/.tmux.conf_old
    fi
    ln -s dotfiles/.tmux.conf ~/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux start-server
    tmux new-session -d
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux kill-server
  fi
}

install_neovim () {
  display_install_step "Neovim"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Download Neovim; link; select-editor"
  else
    sudo wget -O /usr/bin/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    sudo chmod +x /usr/bin/nvim.appimage
    sudo ln -s /usr/bin/nvim.appimage /usr/bin/nvim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 50
    sudo select-editor
    if [[ -d "~/.config/nvim" ]]
    then
      mv ~/.config/nvim ~/.config/nvim_backup
    fi
    git clone https://github.com/NvChad/NvChad ~/.config/nvim
    ln -s ~/dotfiles/config/nvim/custom ~/.config/nvim/lua/custom
    nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
    fi
}

install_fzf () {
  display_install_step "FZF"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install FZF"
  else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  fi
}

install_node () {
  display_install_step "Node"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install Node"
  else
    NVM_VERSION=$(get_latest_release "nvm-sh/nvm")
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install --lts
  fi
}

install_docker () {
  display_install_step "Docker"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install Docker"
  else
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
      sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose
    # sudo curl -sSL https://get.docker.com | sh
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
  fi
}

install_nerdfonts () {
  display_install_step "Nerd Fonts"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install Nerd Fonts"
  else
    NERD_FONTS_VERSION=$(get_latest_release ryanoasis/nerd-fonts)
    NERD_FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$(get_latest_release ryanoasis/nerd-fonts)/FiraCode.zip"
    wget -O ~/temp/FiraCode.zip $NERD_FONTS_URL
    unzip ~/temp/FiraCode.zip -d ~/temp/FiraCode
    rm ~/temp/FiraCode/*Windows\ Compatible*
    sudo mkdir -p /usr/local/share/fonts/FiraCode && sudo cp ~/temp/FiraCode/Fira*.ttf /usr/local/share/fonts/FiraCode/
    fc-cache -f -v
    rm -rf ~/temp/FiraCode
    rm ~/temp/FiraCode.zip
  fi
}

dconf_settings () {
  display_install_step "dconf settings"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install dconf settings"
  else
    [[ -z $(command -v dconf) ]] && whiptail --title "Installation: dconf settings" --msgbox "dconf is not installed! Skipping." && return 1;
    gsettings set org.gnome.desktop.input-sources xkb-options "['compose:ralt','caps:swapescape']";
    gsettings set org.gnome.desktop.interface clock-show-weekday true;
    gsettings set org.gnome.desktop.interface clock-show-weekday true;
    gsettings set org.gnome.desktop.interface enable-hot-corners true;
    gsettings set org.gnome.desktop.interface monospace-font-name "FiraCode Nerd Font Mono 12";
    gsettings set org.gnome.gedit.preferences.editor use-default-font false;
    gsettings set org.gnome.nautilus.list-view default-column-order "['name', 'size', 'type', 'owner', 'group', 'permissions', 'where', 'date_modified', 'date_modified_with_time', 'date_accessed', 'recency', 'starred', 'detailed_type']";
    gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified', 'starred']";
    gsettings set org.gnome.nautilus.preferences default-folder-viewer "list-view";
    gsettings set org.gnome.nautilus.preferences search-view "list-view";
    gsettings set org.gnome.shell.extensions.dash-to-dock manualhide true;
    gsettings set org.gnome.shell.extensions.pop-shell active-hint true;
    gsettings set org.gtk.Settings.FileChooser show-hidden true;
    gsettings set org.gtk.Settings.FileChooser show-size-column true;
    gsettings set org.gtk.Settings.FileChooser show-type-column true;
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true;
    gsettings set org.gnome.gedit.preferences.editor editor-font "Fira Mono 22";
    gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Super>Page_Down']";
    gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Super>Page_Up']";
  fi
}

install_flatpaks () {
  display_install_step "Flatpaks"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install Flatpaks"
  else
    if [[ -z $(command -v flatpak) ]]
    then
      whiptail \
        --title "Installation: Flatpaks" \
        --msgbox "Flatpak is not installed! Skipping." 0 0
        return 1;
    fi
    display_install_step "Flatpak Apps"
    flatpak install -y flathub \
      org.chromium.Chromium \
      org.chromium.Chromium.Codecs
  fi
}

install_brother_drivers () {
  display_install_step "Brother Drivers" "Brother Printer & Scanner Drivers"
  if [[ $DRY_RUN == 1 ]]
  then
    echo "Dry Run: Install Brother Printer Drivers"
  else
    mkdir -p ~/temp
    wget -O ~/temp/linux-brother.gz https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz
    gunzip ~/temp/linux-brother.gz
    cd ~/temp/linux-brother
    sudo bash ~/temp/linux-brother
    rm ~/temp/linux-brother*
  fi
}

# install_mergerfs () {
#   display_install_step "MergerFS & SnapRAID"
#   whiptail --title "Installation: MergerFS" --msgbox \
# "Note the following drives. We will select which drives to use as
# storage in the next window, and the SNAPRAID volume in the following.
# $(lsblk -o NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT)" 0 0 --scrolltext
#   readarray -t PARTITIONS < <(df | grep '^/dev' | cut -d' ' -f1 | sort)
#   OPTIONS=()
#   for part in "${PARTITIONS[@]}"; do OPTIONS+=($part "$(get_partition_info $part)" off); done
#   STORAGE_DISKS=$(whiptail --title "MergerFS Storage Disks" \
#     --checklist "Select the disks for MergerFS storage pool:" 0 0 0 \
#     "${OPTIONS[@]}" \
#     3>&1 1>&2 2>&3)
#   if [[ -z $STORAGE_DISKS ]]
#   then
#     whiptail --msgbox "No disks selected. Aborting!" 0 0
#     return 1
#   fi
#   if [[ $DRY_RUN == 1 ]]
#   then echo "Dry Run: sudo apt update && sudo apt install fuse mergerfs"
#   else
#     sudo apt update && sudo apt install fuse mergerfs
#   fi
#   ROOT=""
#   FSTAB=""
#   SUDO=""
#   if [[ $DRY_RUN == 1 ]]
#   then
#     ROOT=$TEST_LOCATION
#     FSTAB="$ROOT/etc/fstab"
#     mkdir -p $ROOT/mnt $ROOT/etc
#     touch $FSTAB
#     echo "" > $FSTAB
#     SUDO=""
#   else
#     ROOT="/"
#     FSTAB="/etc/fstab"
#     SUDO="sudo"
#   fi
#   $SUDO echo -e "\n\n# MergerFS Storage Pool:" >> $FSTAB
#   for disk in $STORAGE_DISKS
#   do
#     DISK=$(dequote $disk)
#     DISK=$(sed -e 's/\/dev\///' <<< $DISK)
#     MOUNTPOINT="/mnt/disk-$DISK"
#     FSTAB_LINE="PARTUUID=$(get_partuuid $disk) $MOUNTPOINT  ext4  defaults  0 0"
#     $SUDO mkdir $ROOT$MOUNTPOINT
#     $SUDO echo $FSTAB_LINE >> $FSTAB
#   done;
#   $SUDO echo -e "/mnt/disk-*  /mnt/storage  fuse.mergerfs direct_io,defaults,allow_other,minfreespace=50G,fsname=mergerfs 0 0" >> $FSTAB
#   OPTIONS=()
#   for part in "${PARTITIONS[@]}"
#   do 
#     if [[ -z $(echo "${STORAGE_DISKS[@]}" | grep $part) ]]
#     then
#       OPTIONS+=($part "$(get_partition_info $part)" off)
#     fi
#   done
#   PARITY_DISK=$(whiptail --title "Installation: SnapRAID" \
#   --radiolist "Select SNAPRAID disk" 0 0 0 \
#   "${OPTIONS[@]}" \
#   3>&1 1>&2 2>&3)
#   if [[ -z $PARITY_DISK ]]
#   then
#     whiptail --msgbox "No Parity Disk selected! Aborting." 0 0
#     return 1
#   fi
#   echo $PARITY_DISK
# }

# symlink_nvimconfig () {
#   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#   nvim --headless -u ~/dotfiles/nvim/config/01.plugins.vim +PlugInstall +qall
#   if [[ ! -d ~/.config ]]
#   then
#     mkdir ~/.config
#   fi
#   ln -s ~/dotfiles/nvim ~/.config/nvim
# }
