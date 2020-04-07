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

  conda create --name $ENV_NAME python=$PYTHON_VERSION
  . activate $ENV_NAME
  conda install -y jupyter numpy scikit-learn seaborn
  . deactivate
}

setup_anaconda()
{
  # Download and install (press yes a couple of times)

  echo $SHELL
  # Save the name of the file in a variable for further use
  ANACONDA_INSTALL_SCRIPT=Miniconda3-latest-Linux-x86_64.sh

  # Create the folder if it does not already exists
  mkdir -p ${HOME}/Downloads 2> /dev/null || echo -e "\e[93mDownloads folder already exists\e[0m"

  wget "https://repo.continuum.io/miniconda/${ANACONDA_INSTALL_SCRIPT}" \
  -O "${HOME}/Downloads/${ANACONDA_INSTALL_SCRIPT}"

  $SHELL "${HOME}/Downloads/${ANACONDA_INSTALL_SCRIPT}"

  # In case shell is zsh, add conda path to .zshrc
  if [[ "$SHELL" =~ "zsh" ]]; then
    echo "# Added by miniconda installer" >> ~/.zshrc
    # TODO fix for mac systems
    # TODO fix also for different miniconda
    TMPLINE="export PATH=/home/$USER/miniconda3/bin:\$PATH"
    echo $TMPLINE >> ~/.zshrc
    source ~/.zshrc
  else
    source ~/.bashrc
  fi

  # Update, just in case
  conda update -n base conda

  # Create base environments (one at a time)

  # Version for python 2
  # create_standard_condaenv 2

  # Version for python 3
  # create_standard_condaenv 3

  # Create alias for jupyter so that it does not open a browser window
  # (useful for tmux sessions) and which can be accessed remotely without
  # the need to create tunnels
  # TODO remove, it is already included in aliases?
  #echo "alias jup='jupyter notebook --no-browser --ip=\"*\"'" >> $ALIASES_FILE

  echo -e "\e[93mAnaconda setup complete\e[0m"
}
