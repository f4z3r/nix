{ config, pkgs, ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

      # this is not supported by dell, is set in the bios directly
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 90;
      RESTORE_THRESHOLDS_ON_BAT = 1;

      INTEL_GPU_MIN_FREQ_ON_AC = 350;
      INTEL_GPU_MIN_FREQ_ON_BAT = 350;
      INTEL_GPU_MAX_FREQ_ON_AC = 1150;
      INTEL_GPU_MAX_FREQ_ON_BAT = 800;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1150;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 950;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_MIN_PERF_ON_AC = 16;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 16;
      CPU_MAX_PERF_ON_BAT = 40;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      USB_BLACKLIST_PRINTER = 0;
      USB_BLACKLIST_PHONE = 0;

      RUNTIME_PM_ON_AC = "auto";
    };
  };
}
