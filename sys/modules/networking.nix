{ vars, ... }: {
  # Network configuration.
  # Hostname and connection settings.
  networking = {
    # Host name.
    # Machine network hostname.
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
      # Network Manager message suppression level.
      logLevel = "OFF";

      # DNS management.
      # Systemd-resolved integration mode.
      dns = "systemd-resolved";

      # Wi-Fi settings.
      # Wireless connection options.
      wifi = {
        # Power save.
        # Wireless power save mode state.
        powersave = false;

        # MAC address.
        # Randomized MAC address for privacy.
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
    # DNS security and encryption options.
    settings.Resolve = {
      # DNSSEC validation.
      # Cryptographic DNS response verification.
      DNSSEC = "true";

      # DNS over TLS.
      # Encrypted DNS query transmission mode.
      DNSOverTLS = "true";
    };
  };
}
