#!/bin/bash

ALIASES_FILE=~/.aliases

######################
#### Install packages
######################

# Install zsh
sudo apt install zsh

chsh -s `which zsh`
