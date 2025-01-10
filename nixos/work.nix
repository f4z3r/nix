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
      "secfix/secret" = {
        mode = "0600";
        text = secrets.secfix.enrollment-secret;
      };
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
