#! /bin/bash

# Update packages and sources
sudo apt-get update

# Install packages needed for installing Azure CLI
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

# TODO: Refactor the installation of the Microsoft signing key so it only happens once

# Download and install the Microsoft signing key needed for installing Azure CLI
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

# Add the Azure CLI software repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# Install the Microsoft package repository GPG key, to validate package integrity, needed for installing Azure Functions Core Tools
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# Set up the APT source list needed for installing Azure Functions Core Tools
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'

# Check the /etc/apt/sources.list.d/dotnetdev.list file for one of the appropriate Linux version strings
# Ubuntu 20.04 -> focal
grep 'focal' /etc/apt/sources.list.d/dotnetdev.list | wc -l

# Update packages
sudo apt-get update

# .Net SDK 7.0
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2204
sudo apt-get install -y dotnet-sdk-7.0

# Installing a specific `azure-cli` version:
# To view available versions with command:
#   apt-cache policy azure-cli
sudo apt-get install azure-cli=2.50.\*-1~focal

# Install the Core Tools package:
sudo apt-get install azure-functions-core-tools-4