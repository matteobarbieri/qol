#!/bin/bash

# Just install git and whiptail (required for the menu), clone the repository and start the actual installation process

sudo apt install git whiptail

mkdir ~/repo 2> /dev/null || echo "Directory ~/repo already exists"
cd ~/repo

git clone https://github.com/matteobarbieri/qol.git

# bash ~/repo/qol/setup-scripts/setup_lubuntu.sh
