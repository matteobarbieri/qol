#!/bin/bash

[ $(whoami) = root ] || SUDO=sudo

setup_xmobar()
{
    # TODO must be checked
    sudo apt install cabal-install

    cabal update
    cabal install --lib xmobar -fall_extensions

    echo "Complete the installation by moving xmobar binary"
    echo "to .local/bin folder"

    # xmobar installation command: 
    # cabal install --lib xmobar --flags="with_xft with_alsa"
}

setup_xmonad()
{
    # Install packages for XMonad
    $SUDO apt install -y \
        haskell-stack \
        libx11-dev libxft-dev libxinerama-dev libxrandr-dev libxss-dev \
        trayer \
        libasound2-dev

    # Upgrade stack
    stack upgrade

    # Download xmonad sources
    mkdir -p ~/.config/xmonad

    git clone https://github.com/xmonad/xmonad-contrib ~/.config/xmonad/xmonad-contrib
    git clone https://github.com/xmonad/xmonad ~/.config/xmonad/xmonad

    # Install Xmonad
    cd ~/.config/xmonad

    stack init
    stack install

    # Add Xmonad to the list of available sessions
    $SUDO cp "${SCRIPTPATH}/dotfiles/xmonad.desktop" /usr/share/xsessions

    # Link dotfiles
    ln -s ${SCRIPTPATH}/dotfiles/xmonad/xmonad.hs ~/.config/xmonad/xmonad.hs

     setup_xmobar
}
