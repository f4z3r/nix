# Bootstrapping a new Computer

<!--toc:start-->

- [Bootstrapping a new Computer](#bootstrapping-a-new-computer)
  - [NixOS Installation](#nixos-installation)
  - [Flake Installation](#flake-installation)
    - [Setup Hardware Configuration](#setup-hardware-configuration)
    - [Register the Device in Flake](#register-the-device-in-flake)
    - [Setup Services](#setup-services)
  - [Battery Managment](#battery-managment)
  - [GPG Imports (needed for git)](#gpg-imports-needed-for-git)
  - [SSH Generation (needed for git)](#ssh-generation-needed-for-git)

<!--toc:end-->

## NixOS Installation

Install NixOS from a USB.

> Note that if the LUKS password does not work after installation, it might be due to keyboard
> mappings not properly working.

## Flake Installation

> You might need to add `git` and `vim` via a Nix shell to perform any operations.

### Setup Hardware Configuration

Setup the hardware configuration by copying `/etc/nixos/hardware-configuration.nix` to
`./<host>-hardware-configuration.nix`. Remove stuff that is not related to hardware from the
hardware configuration file. Then add the blocks from `/etc/nixos/configuration.nix` that are
related to LUKS and EFI boot mountpoint. This includes entries such as:

```nix
boot.initrd.secrets = {
  "/crypto_keyfile.bin" = null;
};
boot.initrd.luks.devices."luks-61a8f812-0b86-4be9-9b69-9472960c08b8".device = "/dev/disk/by-uuid/61a8f812-0b86-4be9-9b69-9472960c08b8";
boot.initrd.luks.devices."luks-61a8f812-0b86-4be9-9b69-9472960c08b8".keyFile = "/crypto_keyfile.bin";
```

### Register the Device in Flake

In order to register the device in the flake, simply copy a `nixosConfigurations` block and add your
new host.

Download the `secrets.nix` file from Proton Drive and put it in the project root.

Finally, comment out the Restic, and ClamAV imports in `configuration.nix` on the first
install.

Install the flake using:

```bash
sudo nixos-rebuild boot --flake .#<host>
```

Once installed, reboot.

> Some NeoVim plugins use a cache at `~/.cache/nvim` but cannot create that directory if it does not
> exist. Create it to ensure all plugins can work as expected.

### Setup Services

In order to setup Restic, and ClamAV, follow the instructions in the `README.md`.

You might also want to sync Brave with an existing device.

## Battery Management

On Dell laptops, the battery cannot be fully managed by TLP. Stuff like the battery charge
thresholds need to be set in the BIOS directly.

## GPG Imports (needed for git)

On an existing device, export the GPG keys:

```bash
gpg -a --export > pub.asc
gpg -a --export-secret-keys > priv.asc
gpg --export-ownertrust > trust.txt
```

Copy the files over to the new PC (e.g. via `miniserve`) and run:

```bash
gpg --import pub.asc
gpg --import priv.asc
gpg --import-ownertrust trust.txt
```

## SSH Generation (needed for git)

Generate a SSH keypair and register on GitHub:

```bash
ssh-keygen -t rsa -b 4096
```
