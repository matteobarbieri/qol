#!/bin/bash

# Core packages such as git, tmux and openssh

setup_core()
{

  # Read the aliases file path as first parameter
  ALIASES_FILE=$1

  ######################
  #### Install packages
  ######################

  # Install git, tmux, openssh-server,
  # cmake, c
  sudo apt install \
  git \
  tmux \
  htop \
  wget \
  openssh-server \
  cmake-curses-gui \
  suckless-tools \
  cmake pkg-config

  # Create alias for tmux
  echo "alias tmux='tmux -2'" >> $ALIASES_FILE
  
  # Add custom git aliases to .gitconfig
  cat `realpath "${SCRIPTPATH}/../dotfiles/.gitconfig"` >> ~/.gitconfig

  # Install tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Create symlink to .tmux.conf
  ln -s `realpath "${SCRIPTPATH}/../dotfiles/.tmux.conf"` ~/.tmux.conf

}
