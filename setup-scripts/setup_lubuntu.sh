#!/bin/bash

ALIASES_FILE=~/.aliases

# $SHELL

# Location of the script. NOTE: does not have trailing '/'
# It should probably look something like /home/user/repo/qol/setup_scripts
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Core stuff (tmux, htop et similia)
$SHELL "${SCRIPTPATH}/setup_core.sh"

# zsh, antigen and the related theme
# TODO

# vim and plugins
# TODO

# Install anaconda python and create standard virtual environments py2 and py3
# TODO

# Desktop stuff (docky, dmenu, Google Chrome...)
# TODO
