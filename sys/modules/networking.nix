{ vars, ... }: {
  # Network configuration.
  # Hostname and connection settings.
  networking = {
    # Host name.
    # Machine network identifier.
    hostName = vars.hostname;

    # DNS servers.
    # Quad9 nameserver addresses.
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];

    # Network Manager.
    # Dynamic network connection management settings.
    networkmanager = {
      # Enable flag.
      # Network Manager activation state.
      enable = true;

      # Log level.
      # Network Manager message suppression.
      logLevel = "OFF";

      # DNS management.
      # Systemd-resolved integration.
      dns = "systemd-resolved";

      # Wi-Fi settings.
      # Wireless connection options.
      wifi = {
        # Power save.
        # Disabled for reduced latency.
        powersave = false;

        # MAC address.
        # Randomized address for privacy.
        macAddress = "random";
      };
    };
  };

  # Systemd-resolved.
  # DNS resolver and cache service.
  services.resolved = {
    # Enable flag.
    # DNS resolver activation state.
    enable = true;

    # Resolver settings.
    # Systemd-resolved configuration options.
    settings.Resolve = {
      # DNSSEC validation.
      # Cryptographic DNS response verification.
      DNSSEC = "true";

      # DNS over TLS.
      # Encrypted DNS query transmission.
      DNSOverTLS = "true";
    };
  };
}
