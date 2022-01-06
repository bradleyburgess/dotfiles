# My dotfiles

Repo for my dotfiles and install / maintenance scripts.

## Installation

To install the dotfiles, run the following command:

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/bradleyburgess/dotfiles/main/scripts/installer/install-dotfiles.bash)"
```

## Maintenance

There is a system maintenance script for:

- updating system packages from distro repos
- updating flatpaks from flathub
- updating docker containers in `~/docker/docker-compose.yml`
- pruning docker images
- updating `neovim` appimage
- updating global `npm` packages

The script is put in `PATH`, so it can be run from anywhere with `maintenance`.

## Info

### NeoVim

`neovim` config is based on [NvChad](https://nvchad.github.io), but includes a few other plugins, bindings, and configs.

### Oh My Zsh!

`zsh` and `ohmyzsh` can be installed, and there are some default plugins enabled, as well as some bindings and so on in `.zshrc`.
