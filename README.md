# qol - Quality Of Life improvements

If you're like me, every once in a while you have to undergo the menial task of reinstalling the system from scratch on a new work laptop, personal desktop or whatever.
While installing the OS itself should be relatively straightforward (I'm assuming a relatively standard Ubuntu distribution or one of its variations), a lot is left to do, such as installing basic packages such as `vim`, `tmux` and `openssh-server`, setting up a new fancy shell with `zsh` and its plugins, installing `anaconda` and creating standard virtual environments etc.

Here is where this set of scripts and resources comes in handy!

## Overview

This repository consists of several (theoretically) idependent scripts which take care of different parts: installing base packages, setting up a powerful yet readable shell prompt, installing anaconda and creating standard environments and so on.

But hey! How do I clone a repository if the

Don't panic, I got you covered: use the following code snippet to just install git and clone this repo. Come on, it's just **one** line, I'm pretty sure you can remember it :)

```
wget git.io/hexe_kickstart -O kickstart-qol.sh
```

Then, just make it executable, run it (you will be asked your password for `sudo`, since you still need to install stuff) _et voilà_.

Here is the code if you're _that_ lazy:

```
chmod +x kickstart-qol.sh
./kickstart-qol.sh
```

You now have a new folder `repo` in your home containing just this repo.

Now the real stuff begins.

## System setup script

Inside folder `setup-scripts` you will find a script which will launch the installation of all components.

### Core

Include a shell script which installs most common packages such as `git`, `tmux`, `google chrome` etc.

### Shell install script

Once zsh has been installed, configure it to use `antigen` to manage the various plugins (mainly `powerlevel9k`)

#### tl;dr

Here is how your prompt will look like after running this component of the setup:

![](https://raw.githubusercontent.com/matteobarbieri/qol/master/screenshots/prompt-powerlevel9k.png)


### Color scheme for terminal

A custom color scheme for the `xfce4-terminal` is installed.
colorschemes
dotfiles
kickstart.sh
LICENSE
newfile.sh
README.md
setup-scripts
