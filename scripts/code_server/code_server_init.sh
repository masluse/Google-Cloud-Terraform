#!/bin/bash

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# Install Ansible
sudo apt update
sudo apt upgrade -y
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y

# Install gcloud
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update and install gcloud CLI
sudo apt-get update && sudo apt-get install google-cloud-cli -y

# Initialize gcloud (optional)
# gcloud init

# Install Extensions on the code server
code --install-extension 4ops.terraform
code --install-extension hashicorp.terraform
code --install-extension redhat.ansible
code --install-extension github.copilot 

echo "Installation completed."