# Azure Development Box

A Vagrant box for creating an Azure Development Environment.

## Basis for the Box

Used the Ubuntu 20.04 LTS, `ubuntu/focal64`, box.

Initialized the repo with:

```bash
vagrant init ubuntu/focal64
```

## Components

Installation will be done in a first phase using the [Vagrant Shell Provisioner](https://developer.hashicorp.com/vagrant/docs/provisioning/shell).

TODO: Plans of moving this to a configuration tool such as Ansible, Puppet or Chef

### Installing Individual Components

The following section describes how each of the components would be independently installed
#### .Net SDK 7.0

https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-2204

```bash
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-7.0
```

#### Azure CLI

##### 1. Get packages needed for the installation process:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
```

##### 2. Download and install the Microsoft signing key:

```bash
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
```

##### 3. Add the Azure CLI software repository:

```bash
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list
```

##### 4. Update repository information:

```bash
sudo apt-get update
```

##### 5. Installing a specific `azure-cli` version:

```bash
# To view available versions with command:
#   apt-cache policy azure-cli

sudo apt-get install azure-cli=<version>-1~bullseye
```
#### Azure Functions Core Tools

##### 1. Install the Microsoft package repository GPG key, to validate package integrity:

```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
```

##### 2. Set up the APT source list before doing an APT update.

```bash
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
```

##### 3. Check the /etc/apt/sources.list.d/dotnetdev.list file for one of the appropriate Linux version strings

```bash
# Ubuntu 20.04 -> focal
cat /etc/apt/sources.list.d/dotnetdev.list
```

##### 4. Start the APT source update:

```bash
sudo apt-get update
```

##### 5. Install the Core Tools package:

```bash
sudo apt-get install azure-functions-core-tools-4
```

### Actual Installation

To ease the installation, and make the Vagrantfile cleaner, the installation of the components is done in the separate `shell_provision_script.sh`.
