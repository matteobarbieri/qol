# qol - Quality Of Life improvements

If you're like me, every once in a while you have to undergo the menial task of
reinstalling the system from scratch on a new work laptop, personal desktop or
whatever.  While installing the OS itself should be relatively straightforward
(I'm assuming a relatively standard Ubuntu distribution or one of its
variations), a lot is left to do, such as installing basic packages such as
`vim`, `tmux` and `openssh-server`, setting up a new fancy shell with `zsh` and
its plugins, installing `anaconda` and creating standard virtual environments
etc.

Here is where this set of scripts and resources comes in handy!

## Overview

This repository consists of several (theoretically) idependent scripts which
take care of different parts: installing base packages, setting up a powerful
yet readable shell prompt, installing anaconda and creating standard
environments and so on.

"But hey! How do I clone a repository if the system is brand new and I don't even 
have `git` installed?" - _Everyone, panicking_.

Don't panic, I got you covered: use the following code snippet to just install
git and clone this repo. Come on, it's just **one** line, I'm pretty sure you
can remember it :)

```
    wget git.io/hexe_kickstart -O kickstart-qol.sh 
```


Then, just make it executable, run it (you will be asked your password for
`sudo`, since you still need to install stuff) _et voilà_.

Here is the code if you're _that_ lazy:

```
    chmod +x kickstart-qol.sh && ./kickstart-qol.sh 
```

You now have a new folder `repo` in your home containing just this repo.

Now the real stuff begins.

## System setup script

Inside folder `setup-scripts` you will find the script `setup_lubuntu.sh` which
will begin the installation process for all components.

Just execute it with `./setup_lubuntu.sh` and a menu will allow you to select
which components you want to install.

### Core

Include a shell script which installs most common packages such as `git`,
`tmux`, `google chrome` etc.

### Shell (`zsh`)

Install zsh and set it as default shell (might require logging back in/rebooting
for changes to take place).

Moreover, configure it to use `antigen` to manage the various plugins (mainly
the `powerlevel9k` theme for the `oh-my-zsh` bundle and the
`zsh-syntax-highlight` plugin). 

Since the `powerlevel9k` theme requires the installation of fonts with special
glyphs which are not available normally (`nerdfonts`), also take care of
properly installing them (also recreating font cache).

The effect of such changes is shown in the screenshot below (note: uses the
color `materialshell-dark` color scheme, also included in this repository and
installed by the `terminal` component.).

#### tl;dr

Here is how your prompt will look like after running this component of the
setup:

![](https://raw.githubusercontent.com/matteobarbieri/qol/master/screenshots/prompt-powerlevel9k.png)

### Terminal emulator

#### tl;dr

Install `xfce4-terminal` and copy in the local configuration folder (the default
location is `~/.local/share/xfce4/terminal/colorschemes`) the two colorschemes
included in this repository, `materialshell-oceanic` and `materialshell-dark`,
from https://github.com/carloscuesta/materialshell.

### `vim`

#### tl;dr

Install `Vim` and the `Vundle` plugin manager (from
https://github.com/VundleVim/Vundle.vim) , plus create a symbolik link to
the `.vimrc` file included in this repo in order to include many useful plugins 
in your configuration.

### Desktop

#### tl;dr

Install packages `suckless-tools` (include the `dmenu` program), `xcompmgr` and
`docky`.

### Anaconda

#### tl;dr

Install the latest `miniconda` version and create two standard virtual
environments (one for `python 2.*` and the other one for `python 3.*`) that can
later be cloned.

Note: this component should be installed _after_ the shell component has been
configured, so that the correct `.*rc` is properly altered by the installation
to include the path to `anaconda` binaries in the `$PATH` environment variable.

The virtual enviromnents include the following packages:

 * `numpy`
 * `scikit-learn`
 * `jupyter`
 * `seaborn`

Moreover, create an _alias_ for `jupyter notebook` so that it can be accessed
remotely.
