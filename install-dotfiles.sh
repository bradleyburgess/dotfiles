#!/bin/bash
# Installation script for dotfiles

# Get latest release of nvm
# from lukechilds/get_latest_release.sh
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                          # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                          # Pluck JSON value
  }

# First run check for required packages:
echo -e "\nChecking for Neovim..."
if [[ -z $(command -v nvim) ]]
then
  echo -e "\nPlease install Neovim before continuing...\n"
  exit 1
else
  echo "Neovim is installed!"
fi

echo -e "\nChecking for tmux..."
if [[ -z $(command -v tmux) ]]
then
  echo -e "\nPlease install Tmux before continuing...\n"
  exit 1
else
  echo "Tmux is installed!"
fi

echo -e "\nChecking for node..."
if [[ -z $(command -v node) ]]
then
  echo -e "Node is not installed. Would you like to install nvm from git, or exit"
  echo -e "and install from your package manager?\n"
  echo -e "Type git/exit"
  read NODE_INSTALL
  if [[ $NODE_INSTALL != "git" ]]
  then
    echo -e "\nExiting... Please make sure to install Node before continuing.\n"
    exit 0
  fi
else echo "Node is installed!"
fi

echo -e "\nChecking for fzf..."
if [[ -z $(command -v fzf) ]]
then
  echo -e "FZF is not installed. Would you like to install from git, or exit"
  echo -e "and install from your package manager?\n"
  echo -e "Type git/exit"
  read FZF_INSTALL
  if [[ $FZF_INSTALL != "git" ]]
  then
    echo -e "\nExiting ... Please make sure to install FZF before continuing.\n"
    exit 0
  fi
else
  echo "fzf is installed!"
fi

cd ~

# symlink bashrc
echo -e "\nSetting up bashrc..."
if [[ -f ~/.bashrc ]]
then
  mv ~/.bashrc ~/.bashrc_old
fi
ln -s dotfiles/.bashrc ~/.bashrc

# symlink tmuxrc & install tpm & install plugins
echo -e "\nSetting up tmux config and plugins..."
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

# install fzf
if [[ $FZF_INSTALL = "git" ]]
then
  echo -e "\nInstalling fzf...\n"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# install nvm and lts node
if [[ $NODE_INSTALL = "git" ]]
then
  NVM_VERSION=$(get_latest_release "nvm-sh/nvm")
  echo -e "\nInstalling nvm and node lts...\n"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm install --lts
fi

# install vim-plugged and plugins
echo -e "Installing vim-plugged and plugins..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless -u ~/dotfiles/nvim/config/01.plugins.vim +PlugInstall +qall

# symlink nvim
if [[ ! -d ~/.config ]]
then
  mkdir ~/.config
fi
cd ~/.config
ln -s ~/dotfiles/nvim .

# symlink i3 configs, if installed
if [[ -n $(command -v i3) ]]
then
  mkdir -p ~/.config/i3
  mkdir -p ~/.config/i3status
  ln -s ~/dotfiles/i3.conf ~/.config/i3/config
  ln -s ~/dotfiles/i3status.conf ~/.config/i3status/config
fi

cd ~

echo -e "\nAll done!"
echo -e "\nNext steps:\n\nInstall packges from the ~/.pkglist file"
echo -e "using install-packages.sh"

exit 0
