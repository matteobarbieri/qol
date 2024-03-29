#!/bin/bash

[ $(whoami) = root ] || SUDO=sudo

######################
#### Install packages
######################

# Just install one of the available nerd fonts, patched
install_nerdfonts()
{

  # Pass the font name (e.g. 'Hack')
  FONT_NAME=$1

  echo -e "\e[92mInstalling nerdfonts (selected font: ${FONT_NAME})\e[0m"

  # Download the font
  ZIP_DST=/tmp/${FONT_NAME}.zip
  wget \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/${FONT_NAME}.zip" \
  -O "$ZIP_DST"

  # Install the font in the local fonts folder

  # Create the folder if it does not already exists
  mkdir -p ~/.local/share/fonts 2> /dev/null || echo -e "\e[93mLocal fonts folder already exists\e[0m"

  # Unzip the ttf files directly in that folder
  unzip "$ZIP_DST" -d ~/.local/share/fonts

  # echo -e "\e[92mFonts installed, manually change it in the terminal in order to properly display non standard glyphs\e[0m"
  echo -e "\e[92mNerdfonts ${FONT_NAME} installed\e[0m"

}

install_antigen()
{
  # Download the latest stable antigen release
  wget git.io/antigen -O ~/antigen.zsh

  # Download and install nerdfonts, passing the font name as parameter
  install_nerdfonts Hack
  install_nerdfonts Mononoki

  # Refresh font cache
  fc-cache -fv

  # TODO repeated code, create function

  # Backup possibly existing ~/.zshrc file
  if [ -f ~/.zshrc ]; then
    echo -e "\e[93mBacking up existing ~/.zshrc file to ~/.zshrc.pre-qol\e[0m"
    cp ~/.zshrc ~/.zshrc.pre-qol
  fi

  # Copy the .zshrc
  cp "${SCRIPTPATH}/dotfiles/zsh/.zshrc" ~/.zshrc

  # Backup possibly existing ~/.powerlevelrc file
  if [ -f ~/.powerlevelrc ]; then
    echo -e "\e[93mBacking up existing ~/.powerlevelrc file to ~/.powerlevelrc.pre-qol\e[0m"
    cp ~/.powerlevelrc ~/.powerlevelrc.pre-qol
  fi

  # Copy the configuration file for the powerlevel9k theme
  # (adds a very fancy prompt)
  #cp "${SCRIPTPATH}/../dotfiles/zsh/.powerlevelrc" ~/.powerlevelrc
  #ln -s `realpath "${SCRIPTPATH}/dotfiles/zsh/.powerlevelrc"` ~/.powerlevelrc
  cp `realpath "${SCRIPTPATH}/dotfiles/zsh/.powerlevelrc"` ~/.powerlevelrc

}

setup_zsh()
{
  # Install zsh
  $SUDO apt -y install zsh

  ZSH=$(which zsh)

  # change the default shell to zsh
  echo -e "\e[92mEnter user password to change the current shell to zsh\e[0m"
  $SUDO chsh $USER -s $ZSH

  # change the SHELL environment variable
  export SHELL=$ZSH

  # Install antigen and copy configuration files for zsh/powerlevel9k
  install_antigen

  echo -e "\e[93mZsh installation and configuration complete. Logout and log back in to see the changes.\e[0m"

}
