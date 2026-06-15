#!/bin/bash

ALIASES_FILE=~/.aliases

install_google_chrome()
{
  # Download and install Google Chrome
  wget \
  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  -O "$HOME/Downloads/google-chrome-stable_current_amd64.deb"

  sudo dpkg -i "$HOME/Downloads/google-chrome-stable_current_amd64.deb"
}

setup_desktop()
{
  ######################
  #### Install packages
  ######################

  # Install suckless-tools (includes dmenu), xcompmgr
  sudo apt install -y \
      xcompmgr \
      suckless-tools

  # Install chrome
  install_google_chrome

}
