# f4z3r's NixOS Flake

## Screenshots

![](./assets/shell-quake.jpeg)


![](./assets/desktop.jpeg)


With the light theme, for working outside in the sun:

![](./assets/shell-quake-light.jpeg)

## Standard Software Used

- Channel: NixOS unstable
- Window Manager: `bspwm`
- Bar: `polybar`
- Shortcut Daemon: `sxhkd`
- Layered Keyboard Mapping: `kanata`
- Launcher: `rofi`
- Compositor: `picom`
- GTK Theme: `Gruvbox Material Dark`
- GTK Icon Theme: `Papirus Dark`
- Terminal: `wezterm`
- Multiplexer: `tmux`
- Shell: `zsh`
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
shells. WezTerm will take over the theme dynmically. GTK themes typically reload only on application
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
/etc/nixos/rclone.conf
# add restic backup password under
/etc/nixos/restic-password
```
