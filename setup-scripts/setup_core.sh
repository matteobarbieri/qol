#!/bin/bash

# Core packages such as git, tmux and openssh

ALIASES_FILE=~/.aliases

######################
#### Install packages
######################

# Install git, vim, tmux, suckless-tools (includes dmenu), openssh-server,
# cmake, c
sudo apt install \
git \
tmux \
htop \
wget \
openssh-server \
cmake-curses-gui \
cmake pkg-config

# Create alias for tmux
echo "alias tmux='tmux -2'" >> $ALIASES_FILE
