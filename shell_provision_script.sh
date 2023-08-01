#! /bin/bash

# Variables - System Info
DISTRO_SHORT_CODENAME=$(lsb_release -cs)
PACKAGE_ARCHITECTURE=$(dpkg --print-architecture)

# Variables - Package Versions
VERS_AZURE_CLI="2.50.\*"
VERS_AZURE_FUNC_TOOLS="4.0.\*"

# Install the Microsoft package repository GPG key, to validate package integrity, needed for installing Azure CLI and Azure Functions Core Tools
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# Set up the APT source list needed for installing Azure CLI
sudo sh -c 'echo "deb [arch='$PACKAGE_ARCHITECTURE'] https://packages.microsoft.com/repos/azure-cli/ '$DISTRO_SHORT_CODENAME' main" > /etc/apt/sources.list.d/azure-cli.list'

# Set up the APT source list needed for installing Azure Functions Core Tools
sudo sh -c 'echo "deb [arch='$PACKAGE_ARCHITECTURE'] https://packages.microsoft.com/repos/microsoft-ubuntu-'$DISTRO_SHORT_CODENAME'-prod '$DISTRO_SHORT_CODENAME' main" > /etc/apt/sources.list.d/dotnetdev.list'

# Update packages
sudo apt-get update

# .Net SDK 7.0
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2204
sudo apt-get install -y dotnet-sdk-7.0

# Installing a specific `azure-cli` version:
# sudo apt-get install -y azure-cli=2.50.\*-1~focal
sudo sh -c 'sudo apt-get install -y azure-cli='$VERS_AZURE_CLI''

# Install the Core Tools package:
# sudo apt-get install -y azure-functions-core-tools-4
sudo sh -c 'sudo apt-get install -y azure-functions-core-tools-4='$VERS_AZURE_FUNC_TOOLS''

# Getting installed versions of packages
dotnet --info
az –version
func –version
