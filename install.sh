#!/bin/bash
# Installation script for dotfiles

cd ~

# symlink bashrc
mv .bashrc .bashrc_old
ln -s dotfiles/.bashrc .

# symlink tmuxrc & install tpm
mv .tmux.conf .tmux.conf_old
ln -s dotfiles/.tmux.conf .
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install vim-plugged
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# symlink nvim
cd ~/.config
ln -s ~/dotfiles/nvim .

# symlink i3 configs, if installed
ITHREE=$(command -v i3)
if [[ ITHREE != "" ]]
then
  mkdir -p ~/.config/i3
  mkdir -p ~/.config/i3status
  ln -s ~/dotfiles/i3.conf ~/.config/i3/config
  ln -s ~/dotfiles/i3status.conf ~/.config/i3status/config
fi
