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

}
