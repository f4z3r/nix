# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bd02f4bd-b67a-4a42-9fc4-2ac464263168";
      fsType = "ext4";
    };
# Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };


  boot.initrd.luks.devices."luks-6b11644b-f8ea-4158-90e2-278224ebf5d7".device = "/dev/disk/by-uuid/6b11644b-f8ea-4158-90e2-278224ebf5d7";
 boot.initrd.luks.devices."luks-61a8f812-0b86-4be9-9b69-9472960c08b8".device = "/dev/disk/by-uuid/61a8f812-0b86-4be9-9b69-9472960c08b8";
  boot.initrd.luks.devices."luks-61a8f812-0b86-4be9-9b69-9472960c08b8".keyFile = "/crypto_keyfile.bin";


  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8C2D-CEDA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3576143b-55b0-41ce-af04-a9eeefba0c3f"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}