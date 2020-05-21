#!/bin/bash
# Installation script for dotfiles

cd ~

# .bashrc
rm .bashrc
ln -s dotfiles/.bashrc .

# vim-plugged
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# nvim
cd ~/.config
ln -s ~/dotfiles/nvim .
