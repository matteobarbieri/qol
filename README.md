# qol — Quality Of Life setup

Ansible-based setup for a new machine: installs the packages and tools I rely on
and links my dotfiles into place. Works on **macOS** (Homebrew) and
**Debian/Ubuntu** (apt) from the same playbook.

## What it sets up

| Component (tag) | Contents |
|---|---|
| `core` | git, wget, curl, htop, fd, bat, fzf, ripgrep, glow |
| `dotfiles` | `.aliases`, `.gitconfig` (symlinked) + empty `*.local` override files |
| `zsh` | zsh, oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions, `.zshrc` |
| `starship` | starship prompt + `starship.toml` |
| `tmux` | tmux, tpm (plugin manager), `.tmux.conf` |
| `vim` | vim, Vundle, plugins, `.vimrc` |
| `fonts` | Nerd Fonts (Hack, Mononoki) |
| `python` | miniconda + uv |
| `docker` | Docker Desktop (mac) / Docker engine (linux) |
| `apps` | VS Code, Dropbox, Claude Code |

The `server` meta-tag selects every component above **except** `apps` and
`fonts` (the desktop-only ones), so a headless machine can be provisioned in one
go with `--tags server`. The `shell` tag is a similar shortcut for `zsh` +
`starship`.

## Requirements on the target machine

- **Internet access.**
- **Admin / sudo rights** — needed to install system packages (apt) and GUI apps
  (casks/snaps). `bootstrap.sh` detects whether your sudo needs a password and
  only prompts when necessary.
- Everything else (git, Homebrew, Ansible, Python) is installed automatically by
  `bootstrap.sh`.

## Setup on a fresh machine

Clone the repo and run the bootstrap script. It auto-installs the prerequisites
(Xcode Command Line Tools + Homebrew on mac, git/curl on linux), Ansible itself,
and then runs the playbook.

**macOS**
```bash
git clone https://github.com/matteobarbieri/qol.git ~/repos/qol
cd ~/repos/qol && ./bootstrap.sh
```
> On a truly bare mac you may first need to trigger the git install with
> `xcode-select --install`; `bootstrap.sh` also handles this if git is already
> available enough to clone.

**Ubuntu/Debian**
```bash
sudo apt update && sudo apt install -y git
git clone https://github.com/matteobarbieri/qol.git ~/repos/qol
cd ~/repos/qol && ./bootstrap.sh
```

## Installing or updating a subset

The script forwards any extra arguments to `ansible-playbook`, and every
component is exposed as a tag:

```bash
./bootstrap.sh --tags zsh,vim        # only those components
./bootstrap.sh --tags shell          # zsh + starship
./bootstrap.sh --tags server         # everything except apps + fonts
./bootstrap.sh --skip-tags docker,apps
./bootstrap.sh -K                    # force the sudo password prompt
```

Two informational flags print and exit without touching the system (handy on a
fresh machine, before any prerequisites are installed):

```bash
./bootstrap.sh --list                # list installable components and their tags
./bootstrap.sh --help                # show usage
```

Re-running is safe — the playbook is idempotent. Run it again any time to add a
component or pull in updated dotfiles.

You can also call Ansible directly once it's installed:
```bash
cd ansible
ansible-playbook site.yml --tags vim
```

## Dotfiles and machine-specific overrides

Dotfiles live in [`dotfiles/`](dotfiles) and are **symlinked** into `$HOME`, so
editing a file here updates the live config. If a real (non-symlink) file is
already present, it's backed up to `<name>.pre-ansible` before linking.

Every managed dotfile sources an unversioned `*.local` companion **at the very
end**, so general config stays under version control while machine-specific
tweaks go in the local file without touching tracked files:

| Dotfile | Local override |
|---|---|
| `~/.zshrc` | `~/.zshrc.local` |
| `~/.aliases` | `~/.aliases.local` |
| `~/.tmux.conf` | `~/.tmux.conf.local` |
| `~/.gitconfig` | `~/.gitconfig.local` |
| `~/.vimrc` | `~/.vimrc.local` |

(For example, the `python` role writes conda's init block into `~/.zshrc.local`
rather than the tracked `.zshrc`.)

## Repository layout

```
ansible/
  site.yml            # main playbook (roles tagged by component)
  inventory.ini       # localhost, local connection
  requirements.yml    # Galaxy collections (community.general)
  group_vars/all.yml  # shared variables
  roles/<component>/  # one role per component, with per-OS task files
bootstrap.sh          # one-shot entry point for a fresh machine
dotfiles/             # tracked dotfiles, symlinked into $HOME
legacy/               # the previous bash-based setup scripts (archived)
```

## Legacy

The original bash setup scripts (Ubuntu-focused, menu-driven) are kept in
[`legacy/`](legacy) for reference. They also contain extra desktop bits
(xmonad, xmobar, awesome, xfce4-terminal) that the Ansible setup doesn't manage
yet — the corresponding dotfiles remain in `dotfiles/`.
