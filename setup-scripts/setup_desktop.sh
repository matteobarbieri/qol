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

  # Install suckless-tools (includes dmenu), xcompmgr and docky
  sudo apt install \
  xcompmgr \
  suckless-tools \
  docky

  # TODO add docky to autostart?

  # Install chrome
  install_google_chrome

}
