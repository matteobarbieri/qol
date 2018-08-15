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

  echo "Installing nerdfonts '${FONT_NAME}'"

  # Download the font
  wget \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/${FONT_NAME}.zip" \
  -O "~/Downloads/${FONT_NAME}.zip"

  # Install the font in the local fonts folder

  # Create the folder if it does not already exists
  mkdir -p ~/.local/share/fonts 2> /dev/null || echo "Local fonts folder already exists"

  # Unzip the ttf files directly in that folder
  unzip "~/Downloads/${FONT_NAME}.zip" -d ~/.local/share/fonts

  # Refresh font cache
  fc-cache -fv

  echo "Fonts installed, manually change it in the terminal in order to properly display non standard glyphs"

}

install_antigen()
{
  # Download the latest stable antigen release
  curl -L git.io/antigen > ~/antigen.zsh

  # Download and install nerdfonts
  install_nerdfonts

  # Copy the .zshrc
  cp "${SCRIPTPATH}/../dotfiles/zsh/.zshrc" ~/.zshrc

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
  chsh -s $ZSH # (need to enter user password)

  # change the SHELL environment variable
  export SHELL=$ZSH

  # Install one font from the nerdfonts patched family
  FONT=Hack

  install_nerdfonts $FONT

  # Install antigen and copy configuration files for zsh/powerlevel9k
  install_antigen


}
