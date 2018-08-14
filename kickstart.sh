#!/bin/bash

# Just install git (and vim, in case there is need to edit files on the spot), clone the repository and start the actual installation process

sudo apt install git vim

mkdir ~/repo 2> /dev/null || echo "Directory ~/repo already exists"
cd ~/repo

git clone https://github.com/matteobarbieri/qol.git

# bash ~/repo/qol/setup-scripts/setup_lubuntu.sh
