# f4z3r's NixOS Flake

## Screenshots

TODO(@jakob):

## Standard Software Used

TODO(@jakob): 

## Update

```sh
# update channels
sudo nix-channel --update
# update flake lock file
nix flake update
# rebuild system
sudo nixos-rebuild switch --flake .#
```

## OpenVPN

Download configurations from Proton to get the CAs, Keys, etc. All VPN information is then stored
under `/root/vpn` to ensure they are not world readable. Store them as:

- `/root/vpn/ca`: Proton's CA, theoretically public
- `/root/vpn/tls-auth`: Proton's TLS key, theoretically not too problematic
- `/root/vpn/jakobbeckmann-proton.cred`: your credentials (with `+f2` attached to the username for
  NetShield protection), with username on first line and password on second.
