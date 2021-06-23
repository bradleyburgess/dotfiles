#!/bin/bash
# Installation script for dotfiles

cd ~

# bashrc
mv .bashrc .bashrc_old
ln -s dotfiles/.bashrc .

# tmuxrc
mv .tmux.conf .tmux.conf_old
ln -s dotfiles/.tmux.conf .

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# vim-plugged
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# nvim
cd ~/.config
ln -s ~/dotfiles/nvim .
