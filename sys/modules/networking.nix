{ vars, ... }: {
  # Connectivity configuration.
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
      # Enablement state.
      # Network Manager activation flags.
      enable = true;

      # Output severity.
      # Daemon message suppression levels.
      logLevel = "OFF";

      # Name resolution.
      # Systemd-resolved integration modes.
      dns = "systemd-resolved";

      # Wireless settings.
      # Radio connection options.
      wifi = {
        # Energy efficiency.
        # Wireless power-save mode states.
        powersave = false;

        # Hardware identity.
        # Randomized MAC address privacy policies.
        macAddress = "random";
      };
    };
  };

  # Resolver configuration.
  # Systemd-resolved daemon services.
  services.resolved = {
    # Enablement state.
    # DNS resolver activation flags.
    enable = true;

    # Resolution settings.
    # Domain security and encryption options.
    settings.Resolve = {
      # DNSSEC validation.
      # Cryptographic domain response verification.
      DNSSEC = "true";

      # DoT protocol.
      # Encrypted DNS query transmission modes.
      DNSOverTLS = "true";
    };
  };
}
