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

## Contributing

To see a list of things still needing to be implemented, please refer to the [issues in the current repository](https://github.com/pncoelho/azure-development-box/issues).

The following section describes how the development process for this repo is done and how to contribute to this project.

### Development Environment Prerequisites

List of things you need installed in your environment in order to contribute to this project:
- **Required:** [Vagrant](https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-install)
- ***Optional but recomended:***  [pre-commit](https://pre-commit.com/)
- ***Optional but recomended:***  [Commitizen](https://commitizen-tools.github.io/commitizen/)

### Commit Structure

To keep things simple, all commits in this repo will follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) standard, basing the available *commit types* on the [Angular convention](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines).

### Pre-commit

[Pre-commit](https://pre-commit.com/) is a great and simple to use tool for managing Git hook scripts.

**We highly recommend using this**, since it ensures that all your contributions follow our validations that will also be performed server side (no one wants to push something, only to find out it needs reworking).

In order to use it you need to:
1. Have or install [pre-commit](https://pre-commit.com/#installation)
2. Setup the git hook scripts with `pre-commit install`
   1. **NOTE:** some git hook scripts required other software installed on your machine, [have a look at the list below](#pre-commit-plugins) to be sure you have everything
3. *(Optional):* Run `pre-commit` against all files, to ensure any files you've created are valid
   1. `pre-commit run --all-files`

Afterwards, pre-commit will run behind the scenes to validate all code and commits, so no need to worry about running anything else.

#### Pre-commit Plugins

List of software that needs to be installed in order to run *pre-commit* smoothly:
- [Commitizen](https://commitizen-tools.github.io/commitizen/)

#### Commit Validation

To ensure commits follow the [standard listed above](#commit-structure), we employ [pre-commit](https://pre-commit.com/) with [Commitizen](https://commitizen-tools.github.io/commitizen/) as a plugin.

This way, when performing commits we can validate the message before creating the commit.

### Commitizen

[Commitizen](https://commitizen-tools.github.io/commitizen/) is a tool for managing software version (based on [SemVer](https://semver.org/)) and generating a Changelog (see [keep a changelog](https://keepachangelog.com/en/1.1.0/)) using [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

***NOTE:* If you are using [pre-commit](#pre-commit) this is a required tool**.

It is not required for contributing to this project if you are not using pre-commit (*why not though?*), but if you are new to [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), or are prone to error like any human being, we **highly recommend it** for writing commit messages.

#### Helping create the correct commit message

In order to make it easier on contributors to create commits, this tool is used for helping generate the commit messages.

In order for this to help with the messages you create, you need to have [Commitizen installed](https://commitizen-tools.github.io/commitizen/#installation), and afterwards it will use the config file (`.cz.yaml`) in this directory to help validate your commit messages using pre-commit ([check the previous section](#commit-validation---pre-commit)).

If you are new to using [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), then we would **highly recommend** using Commitizen to help you write commit messages.

The only thing you need to do is run `cz commit` and an interactive prompt will appear to guide you on writing the commit.

For more help on this, please have a look at the [Commitizen `commit` command page](https://commitizen-tools.github.io/commitizen/commit/).

#### Bumping Project Version

Commitizen can also take care of bumping the project by simply running `cz bump`.

This command will:
- Check the current version, check the commits since then and calculate the new version
- Update the CHANGELOG with all changes done since the last version
  - Or create a CHANGELOG if your creating the first version
- Create a [Git tag](https://git-scm.com/book/en/v2/Git-Basics-Tagging) with the updated Commitizen config file and change log

We will use Commitizen to help with this part of the release process, but there is an important note to make:

> When running `cz bump` Commitizen will do the following:
> - Update the CHANGELOG and the `.cz.yaml` config file
> - Create a new commit with these changes with a message similar to `bump: version x.x.x -> y.y.y.`
> - Creates a Git tag pointing to this new commit

Now, if we want the tag to point to a commit in the `main` branch (which is our case, since our *stable* or *release* code is what is in `main`), we need to run `cz bump` on the `main` branch.

This means that `cz bump` should **only be run in the CD pipeline, since no one else should be able to directly commit and push to `main`.**

#### Useful Commitizen Commands

- `cz commit`: assisted commit message writing
- `cz bump`: bump project version and create a Git tag
- `cz bump --major-version-zero`: the same as `cz bump`, but if we're using v0, maintains the major version to `0`
- `cz bump --dry-run`: performs a dry run of `cz bump`
- `cz version -p`: returns the current version of the project

### Branching Strategy

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

### Branch Naming Convention

Other than `main`, the *feature branches* will need to follow this naming convention, which follows a similar structure to what is presented [in this article](https://dev.to/varbsan/a-simplified-convention-for-naming-branches-and-commits-in-git-il4).

The structure is as follows: `type/reference/summary`

The logic is:
- `type`: refers to the the same types as the ones used in our [commit structure definition](#commit-structure)
- `reference`: Points to a GitHub issue
  - Should look like `issue-##`
  - If there is no issue, just use `no-ref`
- `summary`: is a brief description of the purpose of this branch
