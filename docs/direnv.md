# Direnv

Direnv allows you to declare your development environment declaratively and have them active per
default only in the directories of your project.

Direnv is configured per default with this setup.

In order to use Direnv in a project, add a `shell.nix` file that describes the development
environment in the project root. Examples can be found under [`./direnv-shells/`](./direnv-shells/).
Then execute the following two commands to activate the environment:

```sh
echo "use nix" >> .envrc
direnv allow
```

This fill generate a non reproducible setup, as a lock file is not generated. In order to generate
fully reproducible environments, use Flake.

<!--TODO(@jakob): document the usage of nix-shell with flake-->
