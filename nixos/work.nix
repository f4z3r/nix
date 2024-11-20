{pkgs, ...}: let
  secrets = import ../secrets.nix;
in {
  programs = {
    chromium = {
      enable = true;
      extraOpts = {
        CloudManagementEnrollmentToken = secrets.chrome.enterprise-enrollment-token;
        CloudManagementEnrollmentMandatory = true;
      };
    };
  };

  services = {
    kolide-launcher = {
      enable = true;
      kolideHostname = "m1.secfix.com:443";
      enrollSecretDirectory = "/etc/secfix";
      rootDirectory = "/var/secfix/m1.secfix.com-443";
      updateChannel = "stable";
      osqueryFlags = [
        "host_identifier=specified"
        "specified_identifier=${secrets.secfix.host-identifier}"
      ];
    };
  };

  environment = {
    etc."secfix/secret" = {
      mode = "0600";
      text = secrets.secfix.enrollment-secret;
    };

    systemPackages = with pkgs; [
      google-chrome
    ];
  };
}
