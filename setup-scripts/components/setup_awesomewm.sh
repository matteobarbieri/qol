#!/bin/bash

install_awesomewm_stuff()
{
    # Make sure destination folder exists
    mkdir -p ~/.config/awesome

    # Install custom version of awesome-copycatz
    git clone --recursive https://github.com/matteobarbieri/awesome-copycats
    mv -bv awesome-copycats/* ~/.config/awesome && rm -rf awesome-copycats

    # Create a symlink to rc.lua file
    ln -s $SCRIPTPATH/../dotfiles/awesome/rc.lua ~/.config/awesome/rc.lua

    # Create a symlink to the folder containing flag icons for keyboard layout
    ln -s $SCRIPTPATH/../resources/awesome/country_flags ~/.config/awesome/
}

setup_awesomewm()
{
    ######################
    #### Install packages
    ######################

    # Install packages for awesomewm
    sudo apt install \
        awesome \
        awesome-extra

    # Install plugins and themes
    install_awesomewm_stuff
}
