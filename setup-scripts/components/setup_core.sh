#!/bin/bash

# Core packages such as git, tmux and openssh

[ $(whoami) = root ] || SUDO=sudo

setup_core()
{

  ######################
  #### Install packages
  ######################

  # Install git, tmux, openssh-server,
  # cmake, c
  $SUDO apt update

  $SUDO apt install -y \
  git \
  tmux \
  htop \
  picom \ # compositor
  suckless-tools \ # dmenu, slock and some more
  wget \
  unzip \
  openssh-server \
  cmake-curses-gui \
  cmake pkg-config \
  silversearcher-ag

  BAT_VERSION=0.24.0
  FD_VERSION=9.0.0

  # Add custom git aliases to .gitconfig
  cat `realpath "${SCRIPTPATH}/dotfiles/.gitconfig"` >> ~/.gitconfig

  # Install tmux plugin manager
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Create symlink to .tmux.conf
  ln -s `realpath "${SCRIPTPATH}/dotfiles/.tmux.conf"` ~/.tmux.conf

  # Create backup copy of existing ~/.aliases file
  [ -f ~/.aliases ] && mv ~/.aliases ~/.aliases.bak

  # Create symlink to .aliases file
  ln -s `realpath "${SCRIPTPATH}/dotfiles/.aliases"` ~/.aliases

  # Download and install bat (cool replacement for cat)
  # TODO make it system-dependent (should download a different package depending
  # on the machine on which it is installed)
  mkdir -p ~/Downloads

  wget \
    https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb \
    -O ~/Downloads/bat_${BAT_VERSION}_amd64.deb

  $SUDO dpkg -i ~/Downloads/bat_${BAT_VERSION}_amd64.deb

  # Download and install `fd` (user friendlier replacement of `find`)
  # TODO make it system-dependent (should download a different package depending
  # on the machine on which it is installed)
  wget \
    https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd_${FD_VERSION}_amd64.deb \
    -O ~/Downloads/fd_${FD_VERSION}_amd64.deb

  $SUDO dpkg -i ~/Downloads/fd_${FD_VERSION}_amd64.deb

}
