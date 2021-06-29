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
# check nvim
if [[ -z $(command -v nvim) ]]
then
  echo "\nPlease install Neovim before continuing...\n"
  exit 1
# check tmux
elif [[ -z $(command -v tmux) ]]
then
  echo "\nPlease install Tmux before continuing...\n"
  exit 1
# check node (for COC)
elif [[ -z $(command -v node) ]]
then
  echo "\nNode is not installed. Would you like to install nvm from git, or exit"
  echo "and install from your package manager?\n"
  echo "Type git/exit"
  read NODE_INSTALL
  if [[ $NODE_INSTALL != "git" ]]
  then
    echo "\nExiting... Please make sure to install Node before continuing.\n"
    exit 0
# check fzf
elif [[ -z $(command -v fzf) ]]
then
  echo "\nFZF is not installed. Would you like to install from git, or exit"
  echo "and install from your package manager?\n"
  echo "Type git/exit"
  read FZF_INSTALL
  if [[ $FZF_INSTALL != "git" ]]
  then
    echo "\nExiting ... Please make sure to install FZF before continuing.\n"
    exit 0
  fi
fi

cd ~

# symlink bashrc
echo "\nBacking up and setting up bashrc...\n"
mv .bashrc .bashrc_old
ln -s dotfiles/.bashrc .

# symlink tmuxrc & install tpm & install plugins
echo "\nSetting up tmux config and plugins...\n"
if [[ -f ~/.tmux.conf ]]
then
  mv .tmux.conf .tmux.conf_old
fi
ln -s dotfiles/.tmux.conf .
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

# install fzf
if [[ $FZF_INSTALL = "git" ]]
then
  echo "\nInstalling fzf...\n"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# install nvm and lts node
if [[ $NODE_INSTALL = "git" ]]
then
  NVM_VERSION=$(get_latest_release "nvm-sh/nvm")
  echo "\nInstalling nvm and node lts...\n"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm install --lts
fi

# install vim-plugged and plugins
echo "Installing vim-plugged and plugins..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugInstall +qall

# symlink nvim
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

echo "\nAll done!"
