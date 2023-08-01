# Azure Development Box

A Vagrant box for creating an Azure Development Environment.

## Description

This box is for creating a development environment for creating Azure components.

## How the box is setup

### Base box

Used the Ubuntu 20.04 LTS, `ubuntu/focal64`, box.

### Provisioning

Provisioning will be done in a first phase using the [Vagrant Shell Provisioner](https://developer.hashicorp.com/vagrant/docs/provisioning/shell).

> This might be something to look in to once the provisioning is done with a configuration tool:
> https://developer.hashicorp.com/vagrant/docs/provisioning/basic_usage#run-once-always-or-never

#### What is installed

The following section list each of the components that's installed by the provisioning step in Vagrant
- [.Net SDK 7.0](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2204)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt#option-2-step-by-step-installation-instructions)
- [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cportal%2Cv2%2Cbash&pivots=programming-language-csharp#install-the-azure-functions-core-tools)

## Development

To see a list of things still needing to be implemented, please refer to the [Checklist](./Checklist.md)

### Contributing

Rules on how to contribute to this repo.

#### Branching Strategy

GitHub Flow
