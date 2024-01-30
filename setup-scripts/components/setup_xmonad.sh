#!/bin/bash

[ $(whoami) = root ] || SUDO=sudo

install_awesomewm_stuff()
{
     #Make sure destination folder exists
    #mkdir -p ~/.config/awesome

     #Install custom version of awesome-copycatz
    #git clone --recursive https://github.com/matteobarbieri/awesome-copycats
    #mv -bv awesome-copycats/* ~/.config/awesome && rm -rf awesome-copycats

     #Create a symlink to rc.lua file
    #ln -s $SCRIPTPATH/dotfiles/awesome/rc.lua ~/.config/awesome/rc.lua

     #Create a symlink to the folder containing flag icons for keyboard layout
    #ln -s $SCRIPTPATH/resources/awesome/country_flags ~/.config/awesome/
}

setup_xmonad()
{
    ######################
    #### Install packages
    ######################

    # Install packages for awesomewm
    $SUDO apt install -y \
        picom \
        libasound2-dev


    # xmobar installation command: 
    # cabal install --lib xmobar --flags="with_xft with_alsa"

    # Install plugins and themes
    #install_awesomewm_stuff
}
