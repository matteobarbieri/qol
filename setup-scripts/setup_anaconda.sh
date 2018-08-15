#!/bin/bash

ALIASES_FILE=~/.aliases

######################
#### Install anaconda
######################

# Download and install (press yes a couple of times)

cd ~/Downloads
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

$SHELL Miniconda3-latest-Linux-x86_64.sh

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
