#!/bin/bash

# Core packages such as git, tmux and openssh

setup_core()
{

  ######################
  #### Install packages
  ######################

  # Install git, tmux, openssh-server,
  # cmake, c
  sudo apt install -y \
  git \
  tmux \
  htop \
  wget \
  unzip \
  openssh-server \
  cmake-curses-gui \
  cmake pkg-config \
  silversearcher-ag

  # Add custom git aliases to .gitconfig
  cat `realpath "${SCRIPTPATH}/../dotfiles/.gitconfig"` >> ~/.gitconfig

  # Install tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Create symlink to .tmux.conf
  ln -s `realpath "${SCRIPTPATH}/../dotfiles/.tmux.conf"` ~/.tmux.conf

  # Create backup copy of existing ~/.aliases file
  [ -f ~/.aliases ] && mv ~/.aliases ~/.aliases.bak

  # Create symlink to .aliases file
  ln -s `realpath "${SCRIPTPATH}/../dotfiles/.aliases"` ~/.aliases

  # Download and install bat (cool replacement for cat)
  # TODO make it system-dependent (should download a different package depending
  # on the machine on which it is installed)
  wget \
    https://github.com/sharkdp/bat/releases/download/v0.18.2/bat_0.18.2_amd64.deb \
    -O ~/Downloads/bat_0.18.2_amd64.deb

  sudo dpkg -i ~/Downloads/bat_0.18.2_amd64.deb

  # Download and install `fd` (user friendlier replacement of `find`)
  # TODO make it system-dependent (should download a different package depending
  # on the machine on which it is installed)
  wget \
    https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb \
    -O ~/Downloads/fd_8.2.1_amd64.deb

  sudo dpkg -i ~/Downloads/fd_8.2.1_amd64.deb

}
