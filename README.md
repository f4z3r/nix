# f4z3r's NixOS Flake

## Screenshots

![](./assets/base.png)

![](./assets/windows.png)

Supports quake terminals:

![](./assets/quake.png)

## Standard Software Used

- Channel: NixOS unstable
- Package Manager: `lix`
- Window Manager: `hyprland`
- Bar: `waybar`
- Layered Keyboard Mapping: `kanata`
- Launcher: `rofi`
- GTK Theme: `Materia Material Dark`
- GTK Icon Theme: `Papirus Dark`
- Terminal: `foot`
- Multiplexer: `tmux`
- Shell: `fish`
- Editor: `neovim`
- Prompt: `starship`
- Audio: `pipewire`, `mpd`, `ncmpcpp`

## Update

```sh
# update channels
sudo nix-channel --update
# update flake lock file
nix flake update
# rebuild system (impure needed due to external credentials for rclone)
sudo nixos-rebuild switch --impure --flake .#
```

## Dynamic Theming

Themes cannot be implemented fully dynamically, as Nix's filesystems are read-only. Instead, you can
choose to switch between themes (`dark` or `light`) in `./flake.nix` and rebuild. You will need to
reload the tmux configurations if a tmux instance is already running:

```sh
:source ~/.config/tmux/tmux.conf
```

and export `NIX_THEME="..."` for NeoVim to take over the theme if you do not which to restart
shells. Foot will take over the theme dynmically. GTK themes typically reload only on application
restart.

## Bootstrap New Computer

See [`docs/bootstrap.md`](./docs/bootstrap.md).

## OpenVPN

Download configurations from Proton to get the CAs, Keys, etc. All VPN information is then stored
under `/etc/nixos/vpn` to ensure they are not world readable. Store them as:

- `/etc/nixos/vpn/ca`: Proton's CA, theoretically public
- `/etc/nixos/vpn/tls-auth`: Proton's TLS key, theoretically not too problematic
- `/etc/nixos/vpn/jakobbeckmann-proton.cred`: your credentials (with `+f2` attached to the username
  for NetShield protection), with username on first line and password on second.

## ClamAV

ClamAV should be instantiated and installed by default. In order to set up the folder for the
quarantine, run the following:

```sh
sudo mkdir -p /root/quarantine
# needed to run once or the service will fail
sudo freshclam
```

## Restic

Configure a `rclone` backend named `gdrive`. Store the `rclone` configuration under:

```bash
# can be found on proton drive
# ! do not use the same config as for sb sync actions, as that one is encrypted for additional
# protection !
/etc/nixos/rclone.conf
# add restic backup password under
/etc/nixos/restic-password
```

## Rclone

Rclone is setup to sync the second brain between devices with an alias. In order to allow a simple
sync without having to trust google to not eavesdrop, all files within the second brain are passed
via the `crypt` encryption layer from Rclone before syncing. Both encryption and salt are protected
by 512bit passphrases. The encrypted configuration can be found in the proton drive.

```bash
# copy from the proton drive to local and change premissions
sudo chmod 600 ~/.config/rclone/rclone.conf
# check that there are at least the following backends configured:
# - gdrive (used by restic directly, restic does encryption as well)
# - gdrive-crypt (used by to sync the second brain between devices, with rclone encryption layer)
rclone config
```

Once this is done, you can sync with `nph` and `npl`.

## Static Configuration

This repository also offers some static configurations for environments where a basic shell is
needed to work. These can be found under [`./static-configs/`](./static-configs/).

## Technical Debt

- Check how to notify on virus event.
- Treesitter parsers are currently not held within Nix. This is due to an issue of the parsers no
  longer being installed properly by Nix. In order to test new versions of nixpkgs, remove [the line
  defining the install dir](https://github.com/f4z3r/nix/blob/1b3ca0fc940eff8a192334831ac6f1d9238895ca/home/apps/nvim/plugin/treesitter.lua#L8),
  rebuild and run `:checkhealth nvim-treesitter`.
- Various nvim plugins are my own forks awaiting merging in the upstream.
- Various nvim plugins are pinned to a version, and might want to be updated.
- Rofi colours are not dynamic for system theme.
- Foot copy output does not work when run within Tmux.
