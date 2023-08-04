> **THIS PROJECT IS STILL IN DEVELOPMENT**
>
> The main purpose of this project is for experimenting and practicing SDLC and DevOps best practices, so please use this project remember that the actual Vagrant box is an afterthought, intended to serve as an *Hello World* of sorts.

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

### Branching Strategy

The selected branching strategy for this project is Trunk Based Development. If you are not familiar with it, please have a look at the [following link](https://trunkbaseddevelopment.com/).

As a quick summary, if you have something to add you, the workflow is as follows:
1. Create a new **short lived** *feature branch*
2. **Add your changes to that branch**
3. When you've implemented what you wanted, **create a PR to merge** your features to `main`
4. When the PR is created, the **CI pipeline will run and check if everything is OK** with your code
5. If the CI pipeline run is valid, **reviewers will approve the PR**
6. With the PR approved, one of the **maintainers will merge the PR**
7. With the **PR merged**, your **code is now added** to our `main` stable branch (or *trunk branch*)
8. At this point, your part is done, but behind the scenes **pipelines will take care of creating a release** with the changes you just added

### Branch Protection

To ensure we employ TBD correctly and the `main` branch always has a releasable version of our code, we employ the following GitHub branch protections that:
- Require a pull request before merging
- Pull requests require a minimum of 1 approval and no changes requested before they can be merged.
- When new commits are pushed, dismiss stale pull request approvals
- Require review from Code Owners

### Branch Naming Convention

Other than `main`, the *feature branches* will need to follow this naming convention, which follows a similar structure to what is presented [in this article](https://dev.to/varbsan/a-simplified-convention-for-naming-branches-and-commits-in-git-il4).

The structure is as follows: `type/reference/summary`

The logic is:
- `type`: refers to the the same types as the ones used in our [commit structure definition](#commit-structure)
  - *build*: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
  - *ci*: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
  - *docs*: Documentation only changes
  - *feat*: A new feature
  - *fix*: A bug fix
  - *perf*: A code change that improves performance
  - *refactor*: A code change that neither fixes a bug nor adds a feature
  - *style*: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
  - *test*: Adding missing tests or correcting existing tests
- `reference`: Points to a GitHub issue
  - Should look like `issue-##`
  - If there is no issue, just use `no-ref`
- `summary`: is a brief description of the purpose of this branch

The **only exception to this rule** is the `bump-release-branch` that is used to create a Release PR, that serves for approving the creation of a new release whenever code is added to `main`. You can find more info on this on the [Bumping Project Version](#bumping-project-version) and the [Release Process](#release-process) section.

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

It is not required for contributing to this project if you are not using pre-commit (*why not though?*), but if you are new to [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), or *are prone to error like any human being*, we **highly recommend it** for writing commit messages.

#### Helping create the correct commit message

In order to make it easier on contributors to create commits, this tool is used for helping generate the commit messages.

In order for this to help with the messages you create, you need to have [Commitizen installed](https://commitizen-tools.github.io/commitizen/#installation), and afterwards it will use the config file (`.cz.yaml`) in this directory to help validate your commit messages using pre-commit ([check the previous section](#commit-validation---pre-commit)).

If you are new to using [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), then we would **highly recommend** using Commitizen to help you write commit messages.

The only thing you need to do is run `cz commit` and an interactive prompt will appear to guide you on writing the commit.

For more help on this, please have a look at the [Commitizen `commit` command page](https://commitizen-tools.github.io/commitizen/commit/).

#### Bumping Project Version

Commitizen can also take care of bumping the project by simply running `cz bump`, but before we can take advantage of this we need to understand how this command works:

> - Update the CHANGELOG (add list of changes) and the `.cz.yaml` config file (update the version)
> - Create a new commit with these changes with a message similar to `bump: version x.x.x -> y.y.y.`
> - Creates a Git tag pointing to this new commit

Now, our `main` branch is our *source of truth* and it's from this *trunk branch* that we want to create tags and releases. To ensure that it's always a stable and releasable version of our code, we employ branch protection rules (have a look [over here](#branch-protection) for info on this) to ensure that no direct changes can be pushed to this branch.

Since the branch is protected, this means **we can't** (or at least shouldn't) **run** `cz bump` **directly on** `main`, **because we don't want to push any commits directly to** `main`.

If we simply tried to run `cz bump` in the feature branch, or another temporary branch, the tag that would be created, would be pointing to a commit that is not on the `main` branch, which is not an ideal solution as well.

How the actual release process is handled is discussed in on the [Release Process section](#release-process) and we show we still take advantage of Commitizen while not going against our branch protection rules.

#### Useful Commitizen Commands

- `cz commit`: assisted commit message writing
- `cz bump`: bump project version and create a Git tag
- `cz bump --dry-run`: performs a dry run of `cz bump`
- `cz version -p`: returns the current version of the project

## Release Process

Since we're using [TBD as our branching strategy](#branching-strategy), every time a PR is merged to `main`, we will consider this a new version, and we want to automatically create a new *git tag* and *GitHub Release*

But we do have to note that by using **protected branches**, an **automated pipeline cannot directly push** to these branches as a security policy ([see this discussion](https://github.com/orgs/community/discussions/25305#discussioncomment-3247401)), so we have to employ a workaround to ease the creation of a release.

So the way we approach this is to use the following workflow:

1. User creates a *feature branch* using `main` as a basis
2. User creates whatever *commits* are needed
3. User pushes the *commits* and the *feature branch* to *remote*
4. User creates a PR to merge their *feature branch* to `main`
5. Reviewers approve the PR and it is merged
6. Changes are pushed to `main`
7. Release bump pr pipeline performs the following tasks:
   > **triggers on pushes to `main` but excludes changes to `CHANGELOG.md` and `.cz.yaml` files**
   1. Creates a temporary `bump-release-branch`
   2. Calculates the new version and updates the Commitizen config file (`.cz.yaml`)
   3. Updates the CHANGELOG
   4. Commits both changes to this branch
   > *NOTE:* steps 2-4 will be done with `cz bump`, which will also create a `git tag` with this new version. Since we want the tag to point to main, and not this commit, in this branch, this tag will be ignored and a new one will be created in the *release creation pipeline*.
   5. Creates a release PR to merge this temporary branch
      1. Body: the CHANGELOG differences between the last release and this one
      2. Title:
         > RELEASE-BUMP-PR: bump to `RELEASE_NUMBER`
   6. Adds comment to PR to forge a review before merge
   > **NOTE:** while this PR is not merged, any other feature branch PR that gets merged, will have it's changes reflected on this branch and release PR
8. If the PR gets merged, the release creation pipeline performs the following tasks:
   > **triggers on pushes to `main` that change the `CHANGELOG.md` and `.cz.yaml` files and that the last commit message has `RELEASE-BUMP-PR` in the message**
   1. creates a tag with the new release
      1. contains the CHANGELOG differences between this version and the last
   2. creates a GitHub Release
      1. points to the new tag
      2. contains the CHANGELOG differences between this version and the last
