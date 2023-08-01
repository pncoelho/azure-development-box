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

The following section describes how the development process for this repo is done and how to contribute to this project.

#### Commit Structure

To keep things simple, all commits in this repo will follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) standard.

#### Commit Validation

To ensure commits follow the [standard listed above](#commit-structure), we employ [pre-commit](https://pre-commit.com/) with [Commitizen](https://commitizen-tools.github.io/commitizen/) as a plugin.

This way, when performing commits we can validate the message (and many other interesting things), and even use [Commitizen](https://commitizen-tools.github.io/commitizen/) to help write the messages with the correct structure.

What you need to do is simply:
1. Have or install [pre-commit](https://pre-commit.com/#installation)
2. Setup the git hook scripts with `pre-commit install`
3. *(Optional):* Run `pre-commit` against all files, to ensure any files you've created are valid
   1. `pre-commit run --all-files`

#### Branching Strategy

The selected branching strategy for this project is GitHub Flow. If you are not familiar with it, please have a look at the [following link from GitHub themselves](https://docs.github.com/en/get-started/quickstart/github-flow).

As a quick summary, if you have something to add you, the workflow is as follows:
1. Create a new (*feature*) branch
2. Add your changes to that branch
3. When you've implemented what you wanted, create a PR to merge your features to `main`
4. When the PR is create, the CI pipeline will run and check if everything is OK with your code
5. If the CI pipeline run is valid, reviewers will approve the PR
6. With the PR approved, one of the maintainers will merge the PR
7. With the PR merged, the CD pipeline will run
8. The CP pipeline will create a new version, with CHANGELOG and (*hopefully soon*) publish the box to Vagrant Cloud
