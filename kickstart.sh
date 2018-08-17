#!/bin/bash

# Just install git, clone the repository and start the actual installation process

sudo apt install git

mkdir ~/repo 2> /dev/null || echo "Directory ~/repo already exists"
cd ~/repo

git clone https://github.com/matteobarbieri/qol.git

# bash ~/repo/qol/setup-scripts/setup_lubuntu.sh
