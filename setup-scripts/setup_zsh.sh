#!/bin/bash

######################
#### Install packages
######################

# Location of the script. NOTE: does not have trailing '/'
# It should probably look something like /home/user/repo/qol/setup_scripts
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Just install one of the available nerd fonts, patched
install_nerdfonts()
{

  # Pass the font name (e.g. 'Hack')
  FONT_NAME=$1

  echo -e "\e[92mInstalling nerdfonts '${FONT_NAME}'"

  # Download the font
  wget \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/${FONT_NAME}.zip" \
  -O ~"/Downloads/${FONT_NAME}.zip"

  # Install the font in the local fonts folder

  # Create the folder if it does not already exists
  mkdir -p ~/.local/share/fonts 2> /dev/null || echo "Local fonts folder already exists"

  # Unzip the ttf files directly in that folder
  unzip ~"/Downloads/${FONT_NAME}.zip" -d ~/.local/share/fonts

  # Refresh font cache
  fc-cache -fv

  echo -e "\e[92mFonts installed, manually change it in the terminal in order to properly display non standard glyphs"

}

install_antigen()
{
  # Download the latest stable antigen release
  wget git.io/antigen -O ~/antigen.zsh

  # Download and install nerdfonts, passing the font name as parameter
  install_nerdfonts Hack

  # TODO repeated code, create function

  # Backup possibly existing ~/.zshrc file
  if [ -f ~/.zshrc ]; then
    echo "Backing up existing ~/.zshrc file to ~/.zshrc.pre-qol"
    cp ~/.zshrc ~/.zshrc.pre-qol
  fi

  # Copy the .zshrc
  cp "${SCRIPTPATH}/../dotfiles/zsh/.zshrc" ~/.zshrc

  # Backup possibly existing ~/.powerlevelrc file
  if [ -f ~/powerlevelrc ]; then
    echo "Backing up existing ~/.powerlevelrc file to ~/.powerlevelrc.pre-qol"
    cp ~/.powerlevelrc ~/.powerlevelrc.pre-qol
  fi

  # Copy the configuration file for the powerlevel9k theme
  # (adds a very fancy prompt)
  cp "${SCRIPTPATH}/../dotfiles/zsh/.powerlevelrc" ~/.powerlevelrc

}

setup_zsh()
{
  # Install zsh
  sudo apt install zsh

  ZSH=`which zsh`

  # change the default shell to zsh
  echo "Enter user password to change the current shell to zsh"
  chsh -s $ZSH # (need to enter user password)

  # change the SHELL environment variable
  export SHELL=$ZSH

  # Install antigen and copy configuration files for zsh/powerlevel9k
  install_antigen

}
