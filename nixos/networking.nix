{
  config,
  pkgs,
  hostname,
  ...
}: {
  networking = {
    hostName = "${hostname}";

    networkmanager.enable = true;

    hosts = {
      "127.0.0.1" = [
        "example.com"
      ];
    };

    nftables.enable = true;

    firewall = {
      enable = true;
      allowPing = false;
      interfaces.wlp0s20f3 = {
        allowedTCPPorts = [8080];
        # needed for chromecast on brave
        # allowedUDPPortRanges = [
        #   {
        #     from = 32768;
        #     to = 60999;
        #   }
        # ];
      };
    };
  };
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIDgTCCAmmgAwIBAgIUXFaVS2QR35qA9QefKsJZdryc9hMwDQYJKoZIhvcNAQEL
      BQAwEzERMA8GA1UEAxMIc3ZjIFJvb3QwHhcNMjQxMTEzMDc1NTA2WhcNMzQwOTIy
      MDc1NTM2WjATMREwDwYDVQQDEwhzdmMgUm9vdDCCASIwDQYJKoZIhvcNAQEBBQAD
      ggEPADCCAQoCggEBAMPeDwF3geYWLr5fbDDaT0R4OsjhLaPWhHuYuW29s7Fs0mu3
      yH5f8UM2mz9bxxNM/sYzrySN91s+7nNk14Vd8mxV7ZAhlBzufiMiVKwStonadRnb
      NFLSoHQk71nBqjVLmVrV2elUtGOtwx1E0YcuajYqD7YDqSv+SzZW5jg3WBbxPt0P
      HlkhRvMZ2NL5ZvqhY+jqtJrfTtrwwSdF1nHPys9zIdl3SJ1b8nvbkLOuIuG3mmL6
      3OqpaknudZtCKALrQgv40QMGdJU1PJ4zGorMlgRLHzdK1nElEV0vInBVSis0Nelg
      DrzURp3Q+j2tG85O9FtAmc8GLatSbeir/qdO9u0CAwEAAaOBzDCByTAOBgNVHQ8B
      Af8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUDFc7wFl9ZQUQ5V0O
      eMc6Q9dI0f4wHwYDVR0jBBgwFoAUDFc7wFl9ZQUQ5V0OeMc6Q9dI0f4wNwYIKwYB
      BQUHAQEEKzApMCcGCCsGAQUFBzAChhtodHRwOi8vdmF1bHQ6ODIwMC92MS9wa2kv
      Y2EwLQYDVR0fBCYwJDAioCCgHoYcaHR0cDovL3ZhdWx0OjgyMDAvdjEvcGtpL2Ny
      bDANBgkqhkiG9w0BAQsFAAOCAQEAmbRRisKqfTCGcg2enl+xGQk+ganspACNDRRI
      XTwRd01Km78IZ4mFN+6H0JvzpKJ/ZzbvezRwiLxwYGAhV9O5ZLLECjeL0YBsJszc
      cqZGfKOO2BW2C2JYQ9x2pShZvOmQ5uAAn0uRvZXseJZOteCV0WVM1psmi7ElJkp3
      W0H8INIPxZ90sJage5c5/ngFtRT8PfL5ihOsEbJYxSk37CG9EtYCgboUxwnDVkSN
      V81DXeqT2Ge9YOrgeomZlOZ4+DkG9QpkIJbnzOPCVMNTXnbV8M7mPq4Y86tLK6BB
      tCnJm3b2HpVpti/qwIUg/OJDYX8yxE3JRiwesFUW9EGt3hFBTA==
      -----END CERTIFICATE-----
    ''
  ];
}
