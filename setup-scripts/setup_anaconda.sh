#!/bin/bash

ALIASES_FILE=~/.aliases

######################
#### Install anaconda
######################

create_standard_condaenv()
{
  # Create a conda environment with standard packages
  # (jupyter numpy scikit-learn seaborn)

  # Python version is passed as a parameter
  PYTHON_VERSION=$1

  ENV_NAME="py${PYTHON_VERSION}"

  conda create --name $ENV_NAME python=PYTHON_VERSION
  . activate $ENV_NAME
  conda install jupyter numpy scikit-learn seaborn
  . deactivate
}

setup_anaconda()
{
  # Download and install (press yes a couple of times)

  # Save the name of the file in a variable for further use
  ANACONDA_INSTALL_SCRIPT=Miniconda3-latest-Linux-x86_64.sh

  wget "https://repo.continuum.io/miniconda/${ANACONDA_INSTALL_SCRIPT}" \
  -O "~/Downloads/${ANACONDA_INSTALL_SCRIPT}"

  $SHELL Miniconda3-latest-Linux-x86_64.sh

  # Update, just in case
  conda update -n base conda

  # Create base environments (one at a time)

  # Version for python 2
  create_standard_condaenv 2

  # Version for python 3
  create_standard_condaenv 3

  # Create alias for jupyter so that it does not open a browser window
  # (useful for tmux sessions) and which can be accessed remotely without
  # the need to create tunnels
  echo "alias jup='jupyter notebook --no-browser --ip=\"*\"'" >> $ALIASES_FILE

  echo "Anaconda setup complete"
}
