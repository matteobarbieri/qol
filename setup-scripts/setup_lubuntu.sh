#!/bin/bash

ALIASES_FILE=~/.aliases

# Location of the script
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"


######################
#### Install packages
######################

# Update, just in case
sudo apt update

# Install git, vim, tmux, suckless-tools (includes dmenu), openssh-server,
# cmake, c
sudo apt install \
git tmux vim suckless-tools docky openssh-server cmake-curses-gui \
cmake pkg-config wget xfce4-terminal zsh

# Download and install Google Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Create alias for tmux
echo "alias tmux='tmux -2'" >> $ALIASES_FILE

## Install additional plugins for vim

# Ultimate vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
bash ~/.vim_runtime/install_awesome_vimrc.sh

# Install 'monokai' color scheme for vim
git clone https://github.com/sickill/vim-monokai.git ~/.vim_runtime/sources_non_forked/vim-monokai

# Set monokai as default colorscheme
echo "syntax enable" >> ~/.vim_runtime/my_configs.vim
echo "colorscheme monokai" >> ~/.vim_runtime/my_configs.vim

######################
#### Install anaconda
######################

# Download and install (press yes a couple of times)

cd ~/Downloads
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# Update, just in case
conda update -n base conda

# Create base environments (one at a time)

cd

# Version for python 2
conda create --name py2 python=2
. activate py2
conda install jupyter numpy scikit-learn seaborn
. deactivate

# Version for python 3
conda create --name py3 python=3
. activate py3
conda install jupyter numpy scikit-learn seaborn
. deactivate

# Create alias for jupyter on tmux
echo "alias jup='jupyter notebook --no-browser --ip=\"*\"'" >> $ALIASES_FILE
