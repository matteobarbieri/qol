#!/usr/bin/env bash
#
# qol bootstrap — set up a fresh machine with Ansible.
#
# Usage:
#   ./bootstrap.sh                       # install/configure everything
#   ./bootstrap.sh --tags zsh,vim        # only selected components
#   ./bootstrap.sh --skip-tags docker    # everything except some
#   ./bootstrap.sh -K                    # force the sudo password prompt
#   ./bootstrap.sh --list                # list installable components and exit
#
# Any extra arguments are passed straight through to ansible-playbook.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="${SCRIPT_DIR}/ansible"

log() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
err() { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; }

usage() {
  cat <<'EOF'
qol bootstrap — set up a fresh machine with Ansible.

Usage:
  ./bootstrap.sh                       # install/configure everything
  ./bootstrap.sh --tags zsh,vim        # only selected components
  ./bootstrap.sh --skip-tags docker    # everything except some
  ./bootstrap.sh -K                    # force the sudo password prompt
  ./bootstrap.sh --list                # list installable components and exit
  ./bootstrap.sh -h, --help            # show this help and exit

Any extra arguments are passed straight through to ansible-playbook.
EOF
}

# Print the installable components (Ansible roles and their tags), parsed
# straight from site.yml so this list never drifts from the playbook.
list_components() {
  echo "Components installed by default (pass these tags to --tags / --skip-tags):"
  echo
  awk '
    /role:/ {
      role = $0; sub(/.*role: */, "", role); sub(/,.*/, "", role)
      tags = $0; sub(/.*tags: *\[/, "", tags); sub(/\].*/, "", tags)
      gsub(/'\''/, "", tags); gsub(/ /, "", tags); gsub(/,/, ", ", tags)
      printf "  %-10s (tags: %s)\n", role, tags
    }
  ' "${ANSIBLE_DIR}/site.yml"
}

# Handle informational flags before doing any installation work.
for arg in "$@"; do
  case "$arg" in
    -h|--help) usage; exit 0 ;;
    --list)    list_components; exit 0 ;;
  esac
done

# --------------------------------------------------------------------------
# OS-specific prelude: ensure a package manager + Ansible are present.
# --------------------------------------------------------------------------
bootstrap_macos() {
  # Xcode Command Line Tools (gives git, curl, compilers).
  if ! xcode-select -p &>/dev/null; then
    log "Installing Xcode Command Line Tools (a GUI prompt will appear)..."
    xcode-select --install || true
    log "Waiting for the Command Line Tools installation to finish..."
    until xcode-select -p &>/dev/null; do sleep 5; done
  fi

  # Homebrew.
  if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Make brew available in this session (Apple Silicon vs Intel paths).
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  if ! command -v ansible-playbook &>/dev/null; then
    log "Installing Ansible (Homebrew)..."
    brew install ansible
  fi
}

bootstrap_debian() {
  log "Updating apt cache and installing prerequisites..."
  sudo apt-get update
  sudo apt-get install -y software-properties-common git curl
  if ! command -v ansible-playbook &>/dev/null; then
    log "Installing Ansible (apt)..."
    sudo apt-get install -y ansible
  fi
}

# --------------------------------------------------------------------------
# Detect OS and run the matching prelude.
# --------------------------------------------------------------------------
case "$(uname -s)" in
  Darwin) bootstrap_macos ;;
  Linux)
    if command -v apt-get &>/dev/null; then
      bootstrap_debian
    else
      err "Only Debian/Ubuntu (apt) Linux is supported by this bootstrap script."
      exit 1
    fi
    ;;
  *)
    err "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac

# --------------------------------------------------------------------------
# Install required Galaxy collections.
# --------------------------------------------------------------------------
log "Installing Ansible Galaxy collections..."
ansible-galaxy collection install -r "${ANSIBLE_DIR}/requirements.yml"

# --------------------------------------------------------------------------
# Decide whether we need to prompt for the sudo password.
#   - passwordless sudo  -> no flag
#   - normal sudoer      -> --ask-become-pass
#   - caller passed their own become flag -> respect it
# --------------------------------------------------------------------------
BECOME_FLAG=()
if [[ ! " $* " =~ " -K " && ! " $* " =~ " --ask-become-pass " ]]; then
  if ! sudo -n true 2>/dev/null; then
    BECOME_FLAG=(--ask-become-pass)
  fi
fi

# --------------------------------------------------------------------------
# Run the playbook. Extra args ($@) are forwarded to ansible-playbook.
# --------------------------------------------------------------------------
log "Running the playbook..."
cd "${ANSIBLE_DIR}"
ansible-playbook site.yml "${BECOME_FLAG[@]}" "$@"

log "Done. Open a new terminal (or log out/in) to pick up shell changes."
