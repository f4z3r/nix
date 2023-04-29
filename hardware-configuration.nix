{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/75995e17-88af-4eca-aff1-63a88c064e6a";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-0981ed39-6df0-4d4b-9973-84b0563e062a".device = "/dev/disk/by-uuid/0981ed39-6df0-4d4b-9973-84b0563e062a";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/E990-B4DE";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/85d6d645-1a70-4dc9-8cc7-ea867810ff3a"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
