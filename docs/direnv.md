# Direnv

Direnv allows you to declare your development environment declaratively and have them active per
default only in the directories of your project.

Direnv is configured per default with this setup.

In order to use Direnv in a project, add a `flake.nix` file that describes the development
environment in the project root. Examples can be found under [`./direnv-shells/`](./direnv-shells/).
Then execute the following two commands to activate the environment:

```sh
echo "use flake" >> .envrc
direnv allow
```

This will generate a fully reproducible setup, including a lock file. However, note that Flake
requires you to have files staged in order to activate the environment. If these should not be
committed, use the following:

```sh
# the same will be necessary for flake.lock once generated
git add --intent-to-add flake.nix
git update-index --assume-unchanged flake.nix
```

