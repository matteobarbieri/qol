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
  # Add Docker's official GPG key:
  $SUDO apt-get update
  $SUDO apt-get install ca-certificates curl
  $SUDO install -m 0755 -d /etc/apt/keyrings
  $SUDO curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  $SUDO chmod a+r /etc/apt/keyrings/docker.asc
  # Install docker
  $SUDO apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  # Add user to docker group
  $SUDO usermod -aG docker $(whoami)

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    $SUDO tee /etc/apt/sources.list.d/docker.list > /dev/null
  $SUDO apt-get update

  # Terraform
  wget -O- https://apt.releases.hashicorp.com/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
  $SUDO apt update && $SUDO apt install terraform

  # Minikube
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
  $SUDO dpkg -i minikube_latest_amd64.deb

  # Helm
  # TODO
}
