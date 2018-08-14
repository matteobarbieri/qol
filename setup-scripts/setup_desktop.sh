#!/bin/bash

ALIASES_FILE=~/.aliases

######################
#### Install packages
######################

# Install git, vim, tmux, suckless-tools (includes dmenu), openssh-server,
# cmake, c
sudo apt install \
suckless-tools docky

# Download and install Google Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb

cd
