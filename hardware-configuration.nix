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

  environment.systemPackages = [
    nvidia-offload
  ];
  hardware = {
    opengl.enable = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    nvidia.prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

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
