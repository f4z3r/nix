{
  config,
  monitoring,
  ...
}: {
  services = {
    prometheus = {
      enable = monitoring;
      port = 9090;
      globalConfig.scrape_interval = "10s"; # "1m"
      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [
            {
              targets = ["localhost:${toString config.services.prometheus.exporters.node.port}"];
            }
          ];
        }
      ];
      exporters = {
        node = {
          enable = monitoring;
          port = 9000;
          # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
          enabledCollectors = ["systemd"];
          # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
          extraFlags = ["--collector.ethtool" "--collector.softirqs" "--collector.tcpstat" "--collector.wifi"];
        };
      };
    };

    grafana = {
      enable = monitoring;
      provision.datasources.settings.datasources = [
        {
          name = "prometheus";
          type = "prometheus";
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
      ];
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;
          domain = "grafana.localhost";
        };
        security = {
          admin_user = "admin";
          admin_password = "admin";
        };
      };
    };
  };
}
