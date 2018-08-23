#!/bin/bash

# Just install one of the available nerd fonts, patched
install_colorschemes()
{

  echo -e "\e[92mInstalling custom color schemes for xfce4-terminal\e[0m"

  ### Copy the color schemes to the local config folder for xfce4-terminal

  # Create the folder if it does not already exists
  mkdir -p ~/.local/share/xfce4/terminal/colorschemes 2> /dev/null || echo -e "\e[93mLocal folder for xfce4-terminal color schemes already exists\e[0m"
  # Copy color scheme files
  cp $SCRIPTPATH/../colorschemes/xfce4-terminal/* \
  ~/.local/share/xfce4/terminal/colorschemes/

  ### Also copy the default config file in order to activate the correct
  # Create the folder if it does not already exists
  mkdir -p ~/.config/xfce4/terminal 2> /dev/null || echo -e "\e[93mLocal folder for xfce4-terminal configuration file already exists\e[0m"
  # Copy configuration file
  cp $SCRIPTPATH/../dotfiles/xfce4-terminal/terminalrc \
  ~/.config/xfce4/terminal/terminalrc

  # echo -e "\e[92mColor schemes installed, manually set it in terminal preferences to use them\e[0m"
  echo -e "\e[92mColor schemes installed and set\e[0m"

}

setup_xfce4-terminal()
{

  ######################
  #### Install packages
  ######################

  # Install zsh
  echo "\e[92mInstalling xfce4-terminal\e[0m"
  sudo apt install xfce4-terminal

  # Set xfce4-terminal as default x terminal emulator
  echo "\e[92mSetting xfce4-terminal as default x terminal emulator\e[0m"
  sudo update-alternatives \
  --set x-terminal-emulator `which xfce4-terminal`.wrapper

  # Install install_colorschemes
  install_colorschemes
}
