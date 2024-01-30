#!/bin/bash

# Core packages such as git, tmux and openssh

[ $(whoami) = root ] || SUDO=sudo

setup_k8s()
{

  ######################
  #### Install packages
  ######################

  # Unlock sudo
  $SUDO ls > /dev/null

  # Docker
  # TODO

  # Terraform
  wget -O- https://apt.releases.hashicorp.com/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
  $SUDO apt update && $SUDO apt install terraform

  # Minikube
  # TODO

  # Helm
  # TODO
}
