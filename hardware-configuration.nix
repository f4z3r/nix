{ config, lib, pkgs, modulesPath, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
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

  environment.systemPackages = [
    nvidia-offload
  ];

  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
