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

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/E990-B4DE";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/85d6d645-1a70-4dc9-8cc7-ea867810ff3a"; }
    ];

  boot.initrd = {
    secrets = {
      "/crypto_keyfile.bin" = null;
    };
    luks.devices = {
      "luks-0981ed39-6df0-4d4b-9973-84b0563e062a" = {
        device = "/dev/disk/by-uuid/0981ed39-6df0-4d4b-9973-84b0563e062a";
      };
      "luks-d8862d2e-20cd-41a7-be46-043a7f66e1ec" = {
        device = "/dev/disk/by-uuid/d8862d2e-20cd-41a7-be46-043a7f66e1ec";
        keyFile = "/crypto_keyfile.bin";
      };
    };
  };

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = [
    pkgs.nvtop
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      offload = {
        # nvidia on standby for offloading
        # enable = true;
        # enableOffloadCmd = true;
      };
      # nvidia always on
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
