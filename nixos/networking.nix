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
      "127.0.0.1" = ["kiali.apps.example.com" "httpbin.apps.example.com"];
    };

    nftables.enable = true;

    firewall = {
      enable = true;
      allowPing = false;
      interfaces.wlp0s20f3 = {
        allowedTCPPorts = [8080];
        # needed for chromecast on brave
        allowedUDPPortRanges = [
          {
            from = 32768;
            to = 60999;
          }
        ];
      };
    };
  };
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIDiTCCAnGgAwIBAgIUJYu2/7VrNNfTBgZBs17HXlH9edQwDQYJKoZIhvcNAQEL
      BQAwEzERMA8GA1UEAxMIc3ZjIFJvb3QwHhcNMjQxMDI5MTgwNTQ4WhcNMzQwOTA3
      MTgwNjE4WjATMREwDwYDVQQDEwhzdmMgUm9vdDCCASIwDQYJKoZIhvcNAQEBBQAD
      ggEPADCCAQoCggEBAM42fmsVcquiwYDwtSztyD2E+7NmK4yjsQSsGWEHmqLtRU6G
      B9FAebanV6N8Acmgvu8DCrJiHli/GUpBHOFbNiHhLXhPMBQxn7np6FXBBpBLAwrq
      p389RdfU/M1Q8HwyP/3D2HB5oXBYLGUSiisByGW8WOyyF/0vaas0H2adXjY4wBRX
      rc1b5G9WZxmQpii8zzubvTbLeY3Xy6q0Fe8YX0NNsRSBCF7cKHTHmRT7WwDT3ZaR
      A4fIy5JB0pc235H/Gk51d5loydf8eg+B0PtT4lUAyYtuLn1NoodS6w2/7Kbzx6RL
      nlANgPHjSflvZsdnCYHFZaFz4RYu8O9uJdeGVnkCAwEAAaOB1DCB0TAOBgNVHQ8B
      Af8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUmpNLS/J2Ki9nm8CE
      0VYtd5iWoeMwHwYDVR0jBBgwFoAUmpNLS/J2Ki9nm8CE0VYtd5iWoeMwOwYIKwYB
      BQUHAQEELzAtMCsGCCsGAQUFBzAChh9odHRwOi8vMTI3LjAuMC4xOjgyMDAvdjEv
      cGtpL2NhMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6ODIwMC92
      MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQDFgHS+N4GsZVyuRJDdNkPQu+/u
      k8eQwFGrhZ7EJTQN+GJi6i3GrHPxAawPvPQXeKnGZguWuuj//HsMPxuspPWSwsNE
      rmQ4wMl1Q2OnvNItCXkPolpWKmw/EfzHcJEjXAI91FKOVxpFKP/H9T2tLdw8/wCR
      CQfcMEfmUfWu4k7uK6jPn9f5/NgDuu+BblpVyqphtNyiH+cRTVyYgOoI8nE8Wa/K
      R2pb95rR1KByxDlklSQz3k8EIcNxgZuJrl5Z8thnE1Je+VycUmE5IdKSs5WJCOXL
      gdzrDESJfbN2WnIX88qoE4GQGwuFiagIfdZ9R3FMyxvcxwgkloosZeIPJPOf
      -----END CERTIFICATE-----
    ''
  ];
}
