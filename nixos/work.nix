{pkgs, ...}: let
  secrets = import ../secrets.nix;
in {
  programs = {
    nix-ld.enable = true;
    chromium = {
      enable = true;
      extraOpts = {
        CloudManagementEnrollmentToken = secrets.chrome.enterprise-enrollment-token;
        CloudManagementEnrollmentMandatory = true;
      };
    };
  };

  systemd.tmpfiles.settings = {
    google-enterprise = {
      "/opt/google/endpoint-verification/bin" = {
        d = {
          group = "users";
          user = "root";
          mode = "775";
        };
      };
      "/opt/google/endpoint-verification/var/lib" = {
        d = {
          group = "users";
          user = "root";
          mode = "775";
        };
      };
      "/etc/opt/chrome/policies/enrollment" = {
        d = {
          group = "root";
          user = "root";
          mode = "755";
        };
      };
      "/etc/opt/chrome/native-messaging-hosts" = {
        d = {
          group = "root";
          user = "root";
          mode = "755";
        };
      };
    };
  };

  environment = {
    etc = {
      "opt/chrome/policies/enrollment/CloudManagementEnrollmentToken" = {
        mode = "0444";
        text = secrets.chrome.enterprise-enrollment-token;
      };
      "opt/chrome/policies/enrollment/CloudManagementEnrollmentMandatory" = {
        mode = "0444";
        text = "Mandatory";
      };
      "opt/chrome/native-messaging-hosts/com.google.endpoint_verification.api_helper.json" = {
        mode = "0444";
        text = ''
          {
            "name": "com.google.endpoint_verification.api_helper",
            "description": "Google Endpoint Verification API Helper",
            "path": "/opt/google/endpoint-verification/bin/apihelper",
            "type": "stdio",
            "allowed_origins": [
              "chrome-extension://kngjcibmkbngcpnaoafbgkicpgmdehje/",
              "chrome-extension://callobklhcbilhphinckomhgkigmfocg/",
              "chrome-extension://oigombmpildfokhngfpagoddcpmfbjbk/",
              "chrome-extension://defpdpdbabkdgiiemipddkjbpcekecbj/",
              "chrome-extension://flccafnekgjghjclpipcihjcibfopold/"
            ]
          }
        '';
      };
    };

    systemPackages = with pkgs; [
      google-chrome
    ];
  };
}
