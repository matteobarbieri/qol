#!/bin/bash

ALIASES_FILE=~/.aliases

######################
#### Install packages
######################

# Install zsh
sudo apt install zsh

ZSH=`which zsh`

# change the default shell to zsh
chsh -s $ZSH # (need to enter user password)

# change the SHELL environment variable
export SHELL=$ZSH

# Download the latest stable antigen release
curl -L git.io/antigen > antigen.zsh
