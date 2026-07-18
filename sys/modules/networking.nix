{ vars, ... }: {
  # Connectivity configurations.
  # Hostname and connection settings.
  networking = {
    # Device identity.
    # Machine network hostname.
    hostName = vars.hostname;

    # Resolution servers.
    # Quad9 DNS addresses.
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];

    # Network Manager.
    # Dynamic connection management options.
    networkmanager = {
      # Activation state.
      # Network Manager enablement flag.
      enable = true;

      # Output severity.
      # Daemon message suppression level.
      logLevel = "OFF";

      # Name resolution.
      # Systemd-resolved integration mode.
      dns = "systemd-resolved";

      # Wireless settings.
      # Radio connection options.
      wifi = {
        # Energy efficiency.
        # Wireless power save mode state.
        powersave = false;

        # Hardware identity.
        # Randomized MAC address for privacy.
        macAddress = "random";
      };
    };
  };

  # Resolver configurations.
  # Systemd-resolved daemon and cache service.
  services.resolved = {
    # Activation flag.
    # DNS resolver enablement state.
    enable = true;

    # Resolution settings.
    # Domain security and encryption options.
    settings.Resolve = {
      # DNSSEC validation.
      # Cryptographic domain response verification.
      DNSSEC = "true";

      # DoT protocol.
      # Encrypted DNS query transmission mode.
      DNSOverTLS = "true";
    };
  };
}
